//
//  CLZUserInfo.m
//  cailanzi
//
//  Created by luck on 2019/3/25.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZUserInfo.h"

@implementation CLZUserInfo

- (instancetype)init{
    self = [super init];
    if (self) {
        self.phone = [CLZStorageManager getUserPhone];
    }
    return self;
}
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"nickName":@"username"};
}
- (BOOL)isLogin{
    if (!_isLogin) {
        UIViewController *login = [[NSClassFromString(@"CLZLoginViewController") alloc]init];
        UINavigationController *nav = [[NSClassFromString(@"CLZBaseNavigationController") alloc]initWithRootViewController:login];
        UIViewController *root = [UIApplication sharedApplication].keyWindow.rootViewController;
        [root presentViewController:nav animated:YES completion:nil];
    }
    return _isLogin;
}
@end
