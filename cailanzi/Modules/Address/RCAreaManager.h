//
//  RCAreaManager.h
//  Podium
//
//  Created by realcloud on 2019/3/21.
//  Copyright © 2019年 realcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityModel.h"
@interface RCAreaManager : NSObject

+ (instancetype)shareInstance;
- (void)getAreaArray:(void(^)(NSArray <CityModel *>*array))block;
- (NSString *)getLocationStringWithID:(NSNumber *)stringId;
@end



