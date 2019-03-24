//
//  CLZGoodsModel.h
//  cailanzi
//
//  Created by luck on 2019/3/19.
//  Copyright © 2019年 ting. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 "categoryName":"酱油类",
 "defaultImage":"http://nxs.oss-cn-qingdao.aliyuncs.com/15862143900/1531968448146",
 "description":"口感绵纯",
 "goodsId":28331,
 "goodsImage":"http://nxs.oss-cn-qingdao.aliyuncs.com/15862143900/1531968448146",
 "goodsName":"酱油类 400ml*24 万通红烧酱油",
 "goodsPrice":35.00,
 "salesMin":1,
 "storeName":"农鲜生自营",
 "unitName":"箱"
 */
@interface CLZGoodsModel : NSObject
@property(nonatomic,strong) NSString *categoryName;
//@property(nonatomic,strong) NSString *defaultImage;
@property(nonatomic,strong) NSString *description;
@property(nonatomic,strong) NSNumber *goodsId;
@property(nonatomic,strong) NSString *goodsImage;
@property(nonatomic,strong) NSString *goodsName;

@property(nonatomic,strong) NSNumber *goodsPrice;
@property(nonatomic,strong) NSNumber *salesMin;
@property(nonatomic,strong) NSString *storeName;
@property(nonatomic,strong) NSString *unitName;
@end
