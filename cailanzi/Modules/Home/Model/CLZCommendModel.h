//
//  CLZCommendModel.h
//  cailanzi
//
//  Created by luck on 2019/3/19.
//  Copyright © 2019年 ting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLZBaseModel.h"
/*
 "firstPage":1,
 "hasNextPage":false,
 "hasPreviousPage":true,
 "isFirstPage":false,
 "isLastPage":true,
 "lastPage":6,
 "list":[
 {
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
 },
 */
@interface CLZCommendModel : CLZBaseModel
@property(nonatomic,strong) NSNumber *firstPage;
@property(nonatomic,assign) BOOL hasNextPage;
@property(nonatomic,assign) BOOL hasPreviousPage;
@property(nonatomic,assign) BOOL isFirstPage;
@property(nonatomic,assign) BOOL isLastPage;
@property(nonatomic,strong) NSNumber *lastPage;
@property(nonatomic,strong) NSMutableArray <CLZGoodsModel*> *list;

@end
