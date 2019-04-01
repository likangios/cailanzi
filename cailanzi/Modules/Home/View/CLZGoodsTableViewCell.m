//
//  CLZGoodsTableViewCell.m
//  cailanzi
//
//  Created by luck on 2019/3/19.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZGoodsTableViewCell.h"

@interface CLZGoodsTableViewCell()

@end

@implementation CLZGoodsTableViewCell

- (void)setShowNumber:(BOOL)showNumber{
    _showNumber = showNumber;
    if (showNumber) {
        [self.add mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(40.0);
        }];
        self.add.userInteractionEnabled = YES;
    }
    else{
        [self.add mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(80.0);
        }];
        self.add.userInteractionEnabled = NO;
    }
    self.number.hidden = !_showNumber;
    self.sub.hidden = !_showNumber;
}
- (UILabel *)number{
    
    if (!_number) {
        _number = [UILabel new];
        _number.backgroundColor = [UIColor clearColor];
        _number.textColor = [UIColor blackColor];
        _number.textAlignment = NSTextAlignmentCenter;
        _number.font = [UIFont systemFontOfSize:15];
        _number.text = @"0";
    }
    return _number;
}
- (UIButton *)add{
    if (!_add) {
        _add = [UIButton buttonWithType:UIButtonTypeCustom];
        [_add setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
        [_add setTitleColor:MainColor forState:UIControlStateNormal];
        _add.titleLabel.font = [UIFont systemFontOfSize:40];
//        _add.layer.cornerRadius = 20.0;
//        _add.layer.borderColor = MainColor.CGColor;
//        _add.layer.borderWidth = 1.0;
        _add.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

    }
    return _add;
}
- (UIButton *)sub{
    if (!_sub) {
        _sub = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sub setImage:[UIImage imageNamed:@"sub"] forState:UIControlStateNormal];
        [_sub setTitleColor:MainColor forState:UIControlStateNormal];
        _sub.titleLabel.font = [UIFont systemFontOfSize:40];
//        _sub.layer.cornerRadius = 20.0;
//        _sub.layer.borderColor = MainColor.CGColor;
//        _sub.layer.borderWidth = 1.0;
        _sub.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

    }
    return _sub;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.goodImage];
        [self.contentView addSubview:self.goodName];
        [self.contentView addSubview:self.total_format_price];

        [self.goodImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(60);
            make.left.mas_equalTo(10);
            make.centerY.equalTo(self.contentView);
        }];
        [self.goodName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.goodImage.mas_right).offset(10);
            make.bottom.equalTo(self.contentView.mas_centerY).offset(-5);
        }];
        [self.total_format_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_centerY).offset(5);
            make.left.equalTo(self.goodImage.mas_right).offset(10);
        }];
        
        [self.contentView addSubview:self.add];
        [self.contentView addSubview:self.number];
        [self.contentView addSubview:self.sub];
        
        [self.add mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(40.0);
            make.centerY.equalTo(self.contentView);
            make.right.mas_equalTo(-20);
        }];
        [self.number mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.add.mas_left).offset(-5);
            make.width.mas_equalTo(20);
        }];
        [self.sub mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.number.mas_left).offset(-5);
            make.size.mas_equalTo(40);
        }];
        self.showNumber = NO;
        [[self.add rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [[CLZCarManager shareInstance] addGoodsToCar:self.goodModel];
        }];
        [[self.sub rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [[CLZCarManager shareInstance] removeGoods:self.goodModel];
        }];
        
    }
    return self;
}
- (void)setCarModel:(CLZCarModel *)carModel{
    _carModel = carModel;
    self.goodModel = _carModel.goods;
    self.number.text = [NSString stringWithFormat:@"%ld",carModel.count];
}
- (void)setGoodModel:(CLZGoodsModel *)goodModel{
    _goodModel = goodModel;
    [self.goodImage sd_setImageWithURL:[NSURL URLWithString:_goodModel.img_url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
    }];
    self.goodName.text = _goodModel.name;
    self.total_format_price.text = [NSString stringWithFormat:@"￥%.2f/%@",_goodModel.total_price.floatValue,_goodModel.total_format];

    
}
- (UIImageView *)goodImage{
    if (!_goodImage) {
        _goodImage = [[UIImageView alloc]init];
        _goodImage.contentMode = UIViewContentModeScaleAspectFill;
        _goodImage.clipsToBounds = YES;
    }
    return _goodImage;
}
- (UILabel *)goodName{
    if (!_goodName) {
        _goodName = [UILabel new];
        _goodName.backgroundColor = [UIColor clearColor];
        _goodName.textColor = [UIColor blackColor];
        _goodName.textAlignment = NSTextAlignmentLeft;
        _goodName.font = [UIFont systemFontOfSize:15];
    }
    return _goodName;
}
- (UILabel *)total_format_price{
    if (!_total_format_price) {
        _total_format_price = [UILabel new];
        _total_format_price.backgroundColor = [UIColor clearColor];
        _total_format_price.textColor = [UIColor grayColor];
        _total_format_price.textAlignment = NSTextAlignmentLeft;
        _total_format_price.font = [UIFont systemFontOfSize:14];
    }
    return _total_format_price;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
