//
//  CLZOrderModel.m
//  cailanzi
//
//  Created by luck on 2019/4/1.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZOrderModel.h"

@implementation CLZOrderModel
+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass{
    return @{@"address":CLZAddressModel.class,@"goodList":[CLZCarModel class]};
}

@end
