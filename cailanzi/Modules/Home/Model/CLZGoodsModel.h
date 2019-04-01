//
//  CLZGoodsModel.h
//  cailanzi
//
//  Created by luck on 2019/3/19.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZBaseModel.h"
/*
 [avobj setObject:obj[@"name"] forKey:@"name"];
 [avobj setObject:obj[@"alias_name"] forKey:@"alias_name"];
 
 [avobj setObject:model[@"total_format"] forKey:@"total_format"];
 [avobj setObject:model[@"total_price"] forKey:@"total_price"];
 [avobj setObject:model[@"unit_price"] forKey:@"unit_price"];
 [avobj setObject:model[@"price_unit"] forKey:@"price_unit"];
 [avobj setObject:model[@"ssu_id"] forKey:@"ssu_id"];
 [avobj setObject:@"1001" forKey:@"type"];
 
 [avobj setObject:file.url forKey:@"img_url"];
 */
@interface CLZGoodsModel : CLZBaseModel
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *alias_name;
@property(nonatomic,strong) NSString *total_format;
@property(nonatomic,strong) NSNumber *total_price;
@property(nonatomic,strong) NSString *unit_price;
@property(nonatomic,strong) NSString *price_unit;
@property(nonatomic,strong) NSNumber *ssu_id;
@property(nonatomic,strong) NSNumber *type;
@property(nonatomic,strong) NSString *img_url;
@end
