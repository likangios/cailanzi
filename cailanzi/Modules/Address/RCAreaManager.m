//
//  RCAreaManager.m
//  Podium
//
//  Created by realcloud on 2019/3/21.
//  Copyright © 2019年 realcloud. All rights reserved.
//

#import "RCAreaManager.h"
#import <NSObject+YYModel.h>
@interface RCAreaManager()

@property (nonatomic,strong) NSArray <CityModel *>*areaData;

@property (nonatomic,strong) NSMutableDictionary *areaDic;


@end
@implementation RCAreaManager

static RCAreaManager *_instance;

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[RCAreaManager alloc]init];
    });
    return _instance;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        _areaData = [NSArray array];
        _areaDic = [NSMutableDictionary dictionary];
        [self getRegion:^(NSArray *array) {
            _areaData = [NSArray arrayWithArray:array];
        }];
    }
    return self;
}
- (void)getAreaArray:(void(^)(NSArray <CityModel *>*array))block{
    if (_areaData.count) {
        block(_areaData);
    }
    else{
        [self getRegion:^(NSArray *array) {
            _areaData = [NSArray arrayWithArray:array];
            block(_areaData);
        }];
    }
}
- (NSString *)getLocationStringWithID:(NSNumber *)stringId{
    
    NSString *string = _areaDic[stringId.stringValue];
    if (!string) {
        string = @"";
    }
    return string;
}
- (void)getRegion:(void (^)(NSArray *array))success
{
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"area" ofType:@"json"];
    NSString *json = [NSString stringWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:nil];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *array = [NSArray modelArrayWithClass:CityModel.class json:json];
        [array enumerateObjectsUsingBlock:^(CityModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_areaDic setObject:obj.name forKey:obj.id.stringValue];
            [obj.list enumerateObjectsUsingBlock:^(CityModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [_areaDic setObject:obj.name forKey:obj.id.stringValue];
                [obj.list enumerateObjectsUsingBlock:^(CityModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [_areaDic setObject:obj.name forKey:obj.id.stringValue];
                }];
            }];
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            success(array);
        });
    });
}

@end
