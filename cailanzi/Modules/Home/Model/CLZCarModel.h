//
//  CLZCarModel.h
//  cailanzi
//
//  Created by luck on 2019/3/27.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZBaseModel.h"

@interface CLZCarModel : CLZBaseModel

@property(nonatomic,strong) CLZGoodsModel *goods;

@property(nonatomic,assign) NSInteger count;

@end
