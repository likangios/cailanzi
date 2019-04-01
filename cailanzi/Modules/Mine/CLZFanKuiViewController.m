//
//  CLZFanKuiViewController.m
//  cailanzi
//
//  Created by luck on 2019/3/25.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZFanKuiViewController.h"

@interface CLZFanKuiViewController ()

@property(nonatomic,strong) YYTextView *textView;

@property(nonatomic,strong) UIButton *confirm;

@end

@implementation CLZFanKuiViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (YYTextView *)textView{
    if (!_textView) {
        _textView = [[YYTextView alloc]init];
        _textView.placeholderText = @"请输入您的反馈内容";
        _textView.backgroundColor = MainBGColor;
    }
    return _textView;
}
- (UIButton *)confirm{
    if (!_confirm) {
        _confirm = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirm.backgroundColor = MainColor;
        [_confirm setTitle:@"提交反馈" forState:UIControlStateNormal];
        [_confirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirm.layer.cornerRadius = 4.0;
    }
    return _confirm;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addDefaultBackItem];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.confirm];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.customNavBar.mas_bottom).offset(15);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(180);
    }];
    [self.confirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textView.mas_bottom).offset(50);
        make.left.mas_equalTo(25);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(45);
    }];
    
    [[self.confirm rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (self.textView.left < 10) {
            [self showHUDMessage:@"反馈内容字数太少"];
            return ;
        }
        [self showHUD];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self hideHUD];
            [self showHUDMessage:@"提交成功"];
        });
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
