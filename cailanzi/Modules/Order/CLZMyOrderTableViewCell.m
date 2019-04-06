//
//  CLZMyOrderTableViewCell.m
//  cailanzi
//
//  Created by luck on 2019/4/1.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZMyOrderTableViewCell.h"

@interface CLZMyOrderTableViewCell()
@property(nonatomic,strong) UILabel *time_Label;

@property(nonatomic,strong) UILabel *statue_Label;

@property(nonatomic,strong) UILabel *types_Label;

@property(nonatomic,strong) UILabel *total_price_Label;

@property(nonatomic,strong) UIScrollView *goodsContent;

@property(nonatomic,strong) UIImageView *arrowImage;

@property(nonatomic,strong) UILabel *order_number_Label;


@property(nonatomic,strong) UIView *bgView;

@end
@implementation CLZMyOrderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = MainBGColor;
        [self creatSubViews];
    }
    return self;
}
- (void)setModel:(CLZOrderModel *)model{
    _model = model;
    NSDate *time = [NSDate dateWithTimeIntervalSince1970:_model.confirmTime.doubleValue];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSLocale*usLocale=[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    formatter.locale = usLocale;
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *nows = [formatter stringFromDate:time];
    
    if ([_model.orderType isEqualToString:@"0"]) {
        self.time_Label.text = [NSString stringWithFormat:@"订单提交时间：%@",nows];
        self.statue_Label.text = @"已提交";
    }
    else if ([_model.orderType isEqualToString:@"1"]){
        self.time_Label.text = [NSString stringWithFormat:@"订单提交时间：%@",nows];
        self.statue_Label.text = @"已确认";
    }
    else if ([_model.orderType isEqualToString:@"2"]){
        self.time_Label.text = [NSString stringWithFormat:@"订单提交时间：%@",nows];
        self.statue_Label.text = @"已完成";
    }
    self.types_Label.text = [NSString stringWithFormat:@"共%ld种商品",_model.goodList.count];
  __block  CGFloat total_price = 0.00;
    [_model.goodList enumerateObjectsUsingBlock:^(CLZCarModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        total_price = total_price + (obj.goods.total_price.floatValue * obj.count);
    }];
    self.total_price_Label.text = [NSString stringWithFormat:@"￥%.2f",total_price];
    self.order_number_Label.text = [NSString stringWithFormat:@"订单编号：%@",_model.orderSerialNumber];
    
    UIImageView *last;
    for (int i = 0; i< _model.goodList.count; i++) {
        UIImageView *imageView = [UIImageView new];
        [self.goodsContent addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(40);
            make.centerY.equalTo(self.goodsContent.mas_centerY);
            if (last) {
                make.left.equalTo(last.mas_right).offset(10);
            }
            else{
                make.left.mas_equalTo(15);
            }
        }];
        CLZCarModel *model = _model.goodList[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.goods.img_url]];
        UILabel *count = [UILabel new];
        [imageView addSubview:count];
        [count mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(imageView);
        }];
        count.textAlignment = NSTextAlignmentCenter;
        count.font = [UIFont systemFontOfSize:13];
        count.textColor = [UIColor blackColor];
        count.text = [NSString stringWithFormat:@"X%ld",model.count];
        last = imageView;
    }
    [last mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_lessThanOrEqualTo(-10);
    }];
    
}

- (void)creatSubViews{
    [self.contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-10);
    }];
    UIView *topView = [UIView new];
    [self.bgView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
    [topView addSubview:self.time_Label];
    [topView addSubview:self.statue_Label];
    [self.time_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.time_Label.superview);
        make.left.mas_equalTo(15);
    }];
    
    [self.statue_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.statue_Label.superview);
        make.right.mas_equalTo(-15);
    }];
    [self.bgView addSubview:self.goodsContent];
    [self.goodsContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(topView.mas_bottom);
        make.height.mas_equalTo(50);
    }];
    
    [self.bgView addSubview:self.types_Label];
    [self.bgView addSubview:self.total_price_Label];
    [self.types_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.equalTo(self.goodsContent.mas_bottom);
        make.height.mas_equalTo(25);
    }];
    [self.total_price_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.types_Label.mas_centerY);
        make.right.mas_equalTo(-15);
    }];
    [self.bgView addSubview:self.order_number_Label];
    [self.order_number_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.top.equalTo(self.types_Label.mas_bottom);
        make.height.mas_equalTo(35);
        make.bottom.mas_equalTo(0);
    }];
    
    [self.bgView addSubview:self.arrowImage];
    [self.arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.order_number_Label.mas_centerY);
        make.right.mas_equalTo(-15);
        make.size.mas_equalTo(25);
    }];
    
    
}
- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor whiteColor];
    }
    return _bgView;
}
- (UILabel *)time_Label{
    if (!_time_Label) {
        _time_Label = [UILabel new];
        _time_Label.backgroundColor = [UIColor clearColor];
        _time_Label.textColor = [UIColor blackColor];
        _time_Label.textAlignment = NSTextAlignmentLeft;
        _time_Label.font = [UIFont systemFontOfSize:13];
        _time_Label.text = @"送达时间：12345";
    }
    return _time_Label;
}
- (UILabel *)statue_Label{
    
    if (!_statue_Label) {
        _statue_Label = [UILabel new];
        _statue_Label.backgroundColor = [UIColor clearColor];
        _statue_Label.textColor = [UIColor blackColor];
        _statue_Label.textAlignment = NSTextAlignmentLeft;
        _statue_Label.font = [UIFont systemFontOfSize:13];
        _statue_Label.text = @"已完成";
    }
    return _statue_Label;
}
- (UILabel *)types_Label{
    
    if (!_types_Label) {
        _types_Label = [UILabel new];
        _types_Label.backgroundColor = [UIColor clearColor];
        _types_Label.textColor = MainGrayColor;
        _types_Label.textAlignment = NSTextAlignmentCenter;
        _types_Label.font = [UIFont systemFontOfSize:12];
        _types_Label.text = @"共3种商品";
    }
    return _types_Label;
}
- (UILabel *)total_price_Label{
    
    if (!_total_price_Label) {
        _total_price_Label = [UILabel new];
        _total_price_Label.backgroundColor = [UIColor clearColor];
        _total_price_Label.textColor = [UIColor orangeColor];
        _total_price_Label.textAlignment = NSTextAlignmentCenter;
        _total_price_Label.font = [UIFont systemFontOfSize:13];
        _total_price_Label.text = @"￥110.00";
    }
    return _total_price_Label;
}
- (UIImageView *)arrowImage{
    if (!_arrowImage) {
        _arrowImage = [[UIImageView alloc]init];
        _arrowImage.contentMode = UIViewContentModeScaleAspectFill;
        _arrowImage.image = [UIImage imageNamed:@"arrow"];
    }
    return _arrowImage;
}
- (UIScrollView *)goodsContent{
    if (!_goodsContent) {
        _goodsContent = [[UIScrollView alloc]init];
        _goodsContent.showsVerticalScrollIndicator = NO;
        _goodsContent.showsHorizontalScrollIndicator = NO;
    }
    return _goodsContent;
}
- (UILabel *)order_number_Label{
    
    if (!_order_number_Label) {
        _order_number_Label = [UILabel new];
        _order_number_Label.backgroundColor = [UIColor clearColor];
        _order_number_Label.textColor = [UIColor blackColor];
        _order_number_Label.textAlignment = NSTextAlignmentLeft;
        _order_number_Label.font = [UIFont systemFontOfSize:13];
        _order_number_Label.text = @"订单号：";
    }
    return _order_number_Label;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
