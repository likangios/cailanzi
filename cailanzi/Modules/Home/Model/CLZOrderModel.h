//
//  CLZOrderModel.h
//  cailanzi
//
//  Created by luck on 2019/4/1.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZBaseModel.h"

@interface CLZOrderModel : CLZBaseModel
@property(nonatomic,strong) CLZAddressModel *address;
@property(nonatomic,strong) NSString *remark;
@property(nonatomic,strong) NSString *orderSerialNumber;
@property(nonatomic,strong) NSNumber *confirmTime;
@property(nonatomic,strong) NSString *user_objectId;
@property(nonatomic,strong) NSString *orderType;
@property(nonatomic,strong) NSDictionary *finishTime;
@property(nonatomic,strong) NSArray <CLZCarModel *> *goodList;

@end
