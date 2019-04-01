//
//  CLZCarManager.m
//  cailanzi
//
//  Created by luck on 2019/3/27.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZCarManager.h"

@implementation CLZCarManager

static CLZCarManager *_instance;
+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[CLZCarManager alloc]init];
    });
    return _instance;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        _list = [NSMutableArray array];
        self.allPrice = 0.00;
    }
    return self;
}
- (void)addGoodsToCar:(CLZGoodsModel *)model{
    CLZCarModel *inCar = [_list bk_match:^BOOL(CLZCarModel *obj) {
        return obj.goods.ssu_id.integerValue == model.ssu_id.integerValue;
    }];
    if (inCar) {
        inCar.count ++;
    }
    else{
        CLZCarModel *carModel = [[CLZCarModel alloc]init];
        carModel.goods = model;
        carModel.count = 1;
        [self.list addObject:carModel];
    }
    self.allCount++;
    self.allPrice += model.total_price.floatValue;

}
- (NSArray <CLZCarModel *>*)getAllCarGoods{
    return self.list;
}
- (void)removeGoods:(CLZGoodsModel *)model{
    CLZCarModel *inCar = [_list bk_match:^BOOL(CLZCarModel *obj) {
        return obj.goods.ssu_id.integerValue == model.ssu_id.integerValue;
    }];
    if (inCar.count > 1) {
        inCar.count --;
    }
    else if(inCar.count == 1){
        [self.list removeObject:inCar];
    }
    self.allCount--;
    self.allPrice -= model.total_price.floatValue;
}
- (void)removeAll{
    [self.list removeAllObjects];
    self.allCount = 0;
    self.allPrice = 0.0;
}
@end
