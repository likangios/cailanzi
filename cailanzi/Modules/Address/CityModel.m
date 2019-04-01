//
//  CityModel.m
//  Podium
//
//  Created by realcloud on 2019/3/21.
//  Copyright © 2019年 realcloud. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"list":[CityModel class]};
    
}
@end
