//
//  CLZGoodsTableViewCell.h
//  cailanzi
//
//  Created by luck on 2019/3/19.
//  Copyright © 2019年 ting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLZGoodsTableViewCell : UITableViewCell
@property(nonatomic,strong) UIImageView *goodImage;

@property(nonatomic,strong) UILabel *goodName;

@property(nonatomic,strong) UILabel *total_format_price;

@property(nonatomic,strong) UILabel *number;

@property(nonatomic,strong) UIImageView *yixiajia;

@property(nonatomic,strong) UIButton *add;

@property(nonatomic,strong) UIButton *sub;

@property(nonatomic,assign) BOOL showNumber;

@property(nonatomic,strong) CLZGoodsModel *goodModel;

@property(nonatomic,strong) CLZCarModel *carModel;

- (void)showNumberWith:(NSInteger)count;

@property(nonatomic,copy) void (^addGoodsBlock)(CLZGoodsModel *model);


@end
