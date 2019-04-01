//
//  CityModel.h
//  Podium
//
//  Created by realcloud on 2019/3/21.
//  Copyright © 2019年 realcloud. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CityModel : NSObject

@property (nonatomic,strong) NSNumber *id;

@property (nonatomic,strong) NSString *name;

@property (nonatomic,strong) NSNumber *type;

@property (nonatomic,strong) NSArray <CityModel *> *list;

@end

NS_ASSUME_NONNULL_END
