//
//  CLZAddressModel.h
//  cailanzi
//
//  Created by luck on 2019/3/28.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZBaseModel.h"

@interface CLZAddressModel : CLZBaseModel

@property(nonatomic,strong) NSString *province;
@property(nonatomic,strong) NSString *city;
@property(nonatomic,strong) NSString *country;
@property(nonatomic,strong) NSString *detailAddress;
@property(nonatomic,strong) NSString *userName;
@property(nonatomic,strong) NSString *phoneNumber;
@property(nonatomic,strong) NSString *storeName;

@end
