//
//  MainViewController.m
//  cailanzi
//
//  Created by luck on 2019/3/18.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()<UITabBarControllerDelegate>

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    [self addDcChildViewContorller];
    self.selectedIndex = 0;
    @weakify(self);
    [RACObserve([CLZCarManager shareInstance], allCount) subscribeNext:^(NSNumber *x) {
        @strongify(self);
        UIViewController *vc = self.viewControllers[1];
        vc.tabBarItem.badgeValue = x.integerValue?x.stringValue:nil;
        
    }];


    
}
#pragma mark - 添加子控制器
- (void)addDcChildViewContorller
{
    NSArray *childArray = @[
                            @{MallClassKey  : @"CLZHomeViewController",
                              MallTitleKey  : @"首页",
                              MallImgKey    : @"tab_home",
                              MallSelImgKey : @"tab_home_sel"},
                            
                            @{MallClassKey  : @"CLZCarViewController",
                              MallTitleKey  : @"菜篮子",
                              MallImgKey    : @"tab_car",
                              MallSelImgKey : @"tab_car_sel"},
                            
                            @{MallClassKey  : @"CLZMineViewController",
                              MallTitleKey  : @"我的",
                              MallImgKey    : @"tab_wd",
                              MallSelImgKey : @"tab_wd_sel"},
                            ];
    [childArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIViewController *vc = [NSClassFromString(dict[MallClassKey]) new];
        UINavigationController *nav = [[NSClassFromString(@"CLZBaseNavigationController") alloc] initWithRootViewController:vc];
        UITabBarItem *item = vc.tabBarItem;
        item.title = dict[MallTitleKey];
        item.image = [[UIImage imageNamed:dict[MallImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        item.selectedImage = [[UIImage imageNamed:dict[MallSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
//        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"7e7e7e"]} forState:UIControlStateNormal];
        [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
        [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateSelected];
        
        [self addChildViewController:nav];
        
    }];
}
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if ([self.viewControllers indexOfObject:viewController] == 2 && ![CLZUserInfo shareInstance].isLogin) {
        [self showLogin];
        return NO;
    }
    return YES;
}
- (void)showLogin{
    
    UIViewController *login = [[NSClassFromString(@"CLZLoginViewController") alloc]init];
    UINavigationController *nav = [[NSClassFromString(@"CLZBaseNavigationController") alloc]initWithRootViewController:login];
    [self presentViewController:nav animated:YES completion:nil];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
