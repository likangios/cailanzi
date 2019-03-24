//
//  CLZGoodsTableViewCell.m
//  cailanzi
//
//  Created by luck on 2019/3/19.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZGoodsTableViewCell.h"


@implementation CLZGoodsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.goodImage];
        [self.contentView addSubview:self.goodName];
        [self.goodImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(60);
            make.left.mas_equalTo(10);
            make.centerY.equalTo(self.contentView);
        }];
        [self.goodName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.goodImage.mas_right).offset(10);
        }];
    }
    return self;
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
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
