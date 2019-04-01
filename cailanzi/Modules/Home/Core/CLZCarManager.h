//
//  CLZCarManager.h
//  cailanzi
//
//  Created by luck on 2019/3/27.
//  Copyright © 2019年 ting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLZCarManager : NSObject

@property(nonatomic,strong) NSMutableArray *list;

@property(nonatomic,assign) NSInteger allCount;

@property(nonatomic,assign) CGFloat allPrice;


+(instancetype)shareInstance;

- (void)addGoodsToCar:(CLZGoodsModel *)model;

- (void)removeGoods:(CLZGoodsModel *)model;

- (NSArray <CLZCarModel *>*)getAllCarGoods;

- (void)removeAll;
@end
