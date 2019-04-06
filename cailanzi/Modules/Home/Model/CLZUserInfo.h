//
//  CLZUserInfo.h
//  cailanzi
//
//  Created by luck on 2019/3/25.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZBaseModel.h"

@interface CLZUserInfo : CLZBaseModel
@property(nonatomic,strong) NSString *avatar;

@property(nonatomic,strong) NSString *nickName;

@property(nonatomic,strong) NSString *phone;

@property(nonatomic,strong) NSNumber *admin;

@property(nonatomic,strong) NSString *password;

@property(nonatomic,assign) BOOL isLogin;

@end
