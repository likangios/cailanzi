//
//  CLZCarModel.m
//  cailanzi
//
//  Created by luck on 2019/3/27.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZCarModel.h"

@implementation CLZCarModel
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"goods":CLZGoodsModel.class};
}

@end
