//
//  CLZStorageManager.m
//  cailanzi
//
//  Created by luck on 2019/3/25.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZStorageManager.h"

#define USER_PHONE @"key_user_phone"
#define USER_PWD @"key_user_pwd"

@implementation CLZStorageManager

+ (void)storeUserPhone:(NSString *)phone{
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:USER_PHONE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (void)storeUserPassword:(NSString *)pwd{
    [[NSUserDefaults standardUserDefaults] setObject:pwd forKey:USER_PWD];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (NSString *)getUserPhone{
    NSString *phone = [[NSUserDefaults standardUserDefaults] objectForKey:USER_PHONE];
    return phone;
}
+ (NSString *)getUserPassword{
    NSString *pwd = [[NSUserDefaults standardUserDefaults] objectForKey:USER_PWD];
    return pwd;
}
+ (void)deleteUserPhone{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_PHONE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (void)deleteUserPassword{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_PWD];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
