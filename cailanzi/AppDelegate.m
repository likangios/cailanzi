//
//  AppDelegate.m
//  cailanzi
//
//  Created by luck on 2019/3/18.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "AppDelegate+extend.h"
#import "RCAreaManager.h"
@interface AppDelegate ()

@property(nonatomic,strong) MainViewController *mainTabBar;

@property(nonatomic,strong) NSArray  *rows;

@property(nonatomic,assign) NSInteger index;

@end

@implementation AppDelegate

- (MainViewController *)mainTabBar{
    if (!_mainTabBar) {
        _mainTabBar = [[MainViewController alloc]init];
    }
    return _mainTabBar;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = self.mainTabBar;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
    [self.window makeKeyAndVisible];
    [self setUpFixiOS11]; //适配IOS 11
    [self initAVOSCloud];
    [self autoLogin];
    [RCAreaManager shareInstance];
    [[[CLZNetworkManager shareInstance] getCLZConfig] subscribeNext:^(id  _Nullable x) {
        
    }];

    /*
    NSString *homePath = [[NSBundle mainBundle] pathForResource:@"叶菜类" ofType:@"json"];
    NSData *homeData = [NSData dataWithContentsOfFile:homePath];
    NSDictionary *_homeDic = [NSJSONSerialization JSONObjectWithData:homeData options:NSJSONReadingMutableLeaves error:nil];
    self.rows =  _homeDic[@"data"][@"rows"];
    self.index = 0;
    [self uploadDataWithIndex:self.index];
    */
    return YES;
}
- (void)autoLogin{
    NSString *phone = [CLZStorageManager getUserPhone];
    NSString *pwd = [CLZStorageManager getUserPassword];
    if (phone.length & pwd.length) {
        [[[CLZNetworkManager shareInstance] userLoginWithPhone:phone Password:pwd] subscribeCompleted:^{
            NSLog(@"自动登录成功");
        }];
    }
}
- (void)uploadDataWithIndex:(NSInteger)index{
    if (index >= self.rows.count) {
        NSLog(@"上传完成");
        return;
    }
    NSDictionary *obj = self.rows[index];
    NSArray *ssu_list = obj[@"ssu_list"];
   const char * label = [[NSString stringWithFormat:@"serialQueue_%ld",index] cStringUsingEncoding:NSUTF8StringEncoding];
    NSString *img = obj[@"img_url"];
    NSString *originUrl = [img componentsSeparatedByString:@"?"].firstObject;
    AVFile *file = [AVFile fileWithRemoteURL:[NSURL URLWithString:originUrl]];
    [file uploadWithCompletionHandler:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"图片上传成功%ld",index);
            dispatch_queue_t serialQueue = dispatch_queue_create(label, DISPATCH_QUEUE_SERIAL);
            [ssu_list enumerateObjectsUsingBlock:^(NSDictionary *model, NSUInteger idx, BOOL * _Nonnull stop) {
                dispatch_async(serialQueue, ^{
                    AVObject *avobj = [AVObject objectWithClassName:@"MCGoods1001"];
                    [avobj setObject:obj[@"name"] forKey:@"name"];
                    [avobj setObject:obj[@"alias_name"] forKey:@"alias_name"];
                    
                    [avobj setObject:model[@"total_format"] forKey:@"total_format"];
                    [avobj setObject:model[@"total_price"] forKey:@"total_price"];
                    [avobj setObject:model[@"unit_price"] forKey:@"unit_price"];
                    [avobj setObject:model[@"price_unit"] forKey:@"price_unit"];
                    [avobj setObject:model[@"ssu_id"] forKey:@"ssu_id"];
                    [avobj setObject:@"1001" forKey:@"type"];
                    
                    [avobj setObject:file.url forKey:@"img_url"];
                    [avobj saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                        NSLog(@"图片上传成功:%ld——error:%@",self.index,error.description);
                        if (idx == (ssu_list.count - 1)) {
                            [self uploadDataWithIndex:self.index++];
                        }
                    }];
                });
            }];
        }
        else{
            [self uploadDataWithIndex:self.index];
            NSLog(@"图片上传失败:%ld",self.index);
        }
    }];
}
#pragma mark - 适配
- (void)setUpFixiOS11
{
    if (@available(ios 11.0,*)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
