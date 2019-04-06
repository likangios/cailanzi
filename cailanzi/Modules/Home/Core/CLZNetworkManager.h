//
//  CLZNetworkManager.h
//  cailanzi
//
//  Created by luck on 2019/3/25.
//  Copyright © 2019年 ting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLZAddressModel.h"
typedef enum : NSUInteger {
    Goods_CYL = 1,
    Goods_GJL,
    Goods_QGL,
    Goods_CJS,
    Goods_DL,
    Goods_JL,
    Goods_TC,
} GoodsDataType;

@interface CLZNetworkManager : NSObject
+ (instancetype)shareInstance;
- (RACSignal*)getPersonData;
- (RACSignal *)getMenumItemData;
- (RACSignal *)getHomeDataWithType:(GoodsDataType)type;
- (RACSignal *)getHomeDataWithTypeString:(NSString *)type;
- (RACSignal *)userRegiserWithPhone:(NSString *)phone Password:(NSString *)pwd nickName:(NSString *)nickName;
- (RACSignal *)userLoginWithPhone:(NSString *)phone Password:(NSString *)pwd;
- (RACSignal *)userLogout;
- (RACSignal *)schoolPushMessage:(NSString *)title Content:(NSString *)content;
- (RACSignal *)getAddressList;
- (RACSignal *)confirmOrder:(NSDictionary *)address goodsList:(NSMutableArray *)list remark:(NSString *)remark;
- (RACSignal *)updateAddress:(CLZAddressModel *)model;
- (RACSignal *)updateOrderWithobjectId:(NSString *)objectId Type:(NSNumber *)type;
- (RACSignal *)getMyOrdersWithType:(NSString *)type;
- (RACSignal *)getCLZConfig;
- (RACSignal *)updateUserInfo;
- (RACSignal *)updateGoods:(CLZGoodsModel *)model;
@end
