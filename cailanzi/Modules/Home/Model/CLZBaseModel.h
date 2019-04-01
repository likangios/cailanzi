//
//  CLZBaseModel.h
//  cailanzi
//
//  Created by luck on 2019/3/31.
//  Copyright © 2019年 ting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLZBaseModel : NSObject
@property(nonatomic,strong) NSString *objectId;
+ (instancetype)shareInstance;
@end
