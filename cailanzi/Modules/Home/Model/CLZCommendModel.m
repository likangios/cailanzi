//
//  CLZCommendModel.m
//  cailanzi
//
//  Created by luck on 2019/3/19.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZCommendModel.h"

@implementation CLZCommendModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass{
    return @{@"list":[CLZGoodsModel class]};
}
@end
