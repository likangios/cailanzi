//
//  CLZBaseModel.m
//  cailanzi
//
//  Created by luck on 2019/3/31.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZBaseModel.h"

@implementation CLZBaseModel

static NSMutableDictionary *_instance;
+(instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [NSMutableDictionary dictionary];
    });
    id model = _instance[NSStringFromClass(self)];
    if (!model) {
        model = [[self alloc]init];
        _instance[NSStringFromClass(self)] = model;
    }
    return model;
}
@end
