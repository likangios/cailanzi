//
//  CLZEditGoodsViewController.m
//  cailanzi
//
//  Created by luck on 2019/4/5.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZEditGoodsViewController.h"

@interface CLZEditGoodsViewController ()

@property(nonatomic,strong) UIScrollView  *contentView;

@property(nonatomic,strong) UIImageView *img_url;

@property(nonatomic,strong) UITextField *name;

@property(nonatomic,strong) UITextField *total_format;

@property(nonatomic,strong) UITextField *total_price;

@property(nonatomic,strong) UITextField *unit_price;

@property(nonatomic,strong) UITextField *unit_des;

@property(nonatomic,strong) UITextField *isShopping;


@end

@implementation CLZEditGoodsViewController

- (UIScrollView *)contentView{
    if (!_contentView) {
        _contentView = [[UIScrollView alloc]init];
        _contentView.showsVerticalScrollIndicator = NO;
        _contentView.showsHorizontalScrollIndicator = NO;
    }
    return _contentView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.model) {
        self.model = [[CLZGoodsModel alloc]init];
    }
    [self setRightItemTitle:@"保存"];
    [self.view addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.top.equalTo(self.customNavBar.mas_bottom);
    }];
    
    NSArray *title = @[@"商品图片：",@"商品名字：",@"单位描述：",@"总价描述：",@"单价：",@"单位：",@"是否上架："];
    NSArray *placeholders = @[@"商品图片：",@"优质 圆白菜",@"袋(5斤)",@"40.00",@"8.00",@"斤",@"上架：1，下架：0"];

    UIView *lastView;
    for (int i = 0; i<title.count; i++) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(45);
            make.centerX.equalTo(self.contentView.mas_centerX);
            make.left.right.mas_equalTo(0);
            if (lastView) {
                make.top.equalTo(lastView.mas_bottom);
            }
            else{
                make.top.mas_equalTo(0);
            }
        }];
        [view addLineUp:NO andDown:YES];
        lastView = view;
        
        UILabel *tip = [UILabel new];
        tip.textColor = [UIColor blackColor];
        tip.text = title[i];
        tip.textAlignment = NSTextAlignmentLeft;
        tip.font  =[UIFont systemFontOfSize:15];
        [view addSubview:tip];
        [tip mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.left.mas_equalTo(15);
            make.width.mas_equalTo(75);
        }];
        if (i == 0) {
            UIImageView *img =[[UIImageView alloc]init];
            img.layer.borderColor  = MainColor.CGColor;
            img.layer.borderWidth = 1.0;
            [view addSubview:img];
            [img mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(40);
                make.centerY.equalTo(view.mas_centerY);
                make.right.mas_equalTo(-30);
            }];
            self.img_url  = img;
        }
        else{
        UITextField *textField = [[UITextField alloc]init];
        textField.borderStyle = UITextBorderStyleNone;
        textField.backgroundColor = [UIColor lightGrayColor];
        textField.placeholder = placeholders[i];
        textField.layer.cornerRadius = 4;
        textField.textAlignment = NSTextAlignmentLeft;
        [view addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.centerY.equalTo(view.mas_centerY);
            make.left.equalTo(tip.mas_right).offset(10);
            make.right.mas_equalTo(-15);
        }];
            switch (i) {
                case 1:
                    self.name = textField;
                    break;
                case 2:
                    self.total_format = textField;
                    break;
                case 3:
                    self.total_price = textField;
                    break;
                case 4:
                    self.unit_price = textField;
                    break;
                case 5:
                    self.unit_des = textField;
                    break;
                case 6:
                    self.isShopping = textField;
                    break;
                default:
                    break;
            }
        }
    }
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_lessThanOrEqualTo(-10);
    }];
    self.name.text = self.model.name;
    self.total_format.text = self.model.total_format;
    self.total_price.text = self.model.total_price;
    self.unit_price.text = self.model.unit_price;
    [self.img_url sd_setImageWithURL:[NSURL URLWithString:self.model.img_url]];
    self.unit_des.text = self.model.price_unit;
    self.isShopping.text = self.model.isShopping;

    RAC(self.model,name) = self.name.rac_textSignal;
    RAC(self.model,total_format) = self.total_format.rac_textSignal;
    RAC(self.model,total_price) = self.total_price.rac_textSignal;
    RAC(self.model,unit_price) = self.unit_price.rac_textSignal;
    RAC(self.model,price_unit) = self.unit_des.rac_textSignal;
    RAC(self.model,isShopping) = self.isShopping.rac_textSignal;

    [self.img_url bk_whenTapped:^{
        NSLog(@"选择图片");
    }];
}
- (void)rightItemAction:(id)sender{
    [[[CLZNetworkManager shareInstance] updateGoods:self.model] subscribeNext:^(id  _Nullable x) {
        if ([x isKindOfClass:[NSError class]]) {
            NSError *error = (NSError *)x;
            [self showHUDMessage:errorMsg(error)];
        }
        else{
            [self showHUDMessage:@"操作成功"];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
