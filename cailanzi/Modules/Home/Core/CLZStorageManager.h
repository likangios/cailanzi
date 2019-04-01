//
//  CLZStorageManager.h
//  cailanzi
//
//  Created by luck on 2019/3/25.
//  Copyright © 2019年 ting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLZStorageManager : NSObject
+ (void)storeUserPhone:(NSString *)phone;
+ (void)storeUserPassword:(NSString *)pwd;


+ (NSString *)getUserPhone;
+ (NSString *)getUserPassword;

+ (void)deleteUserPhone;
+ (void)deleteUserPassword;

@end
