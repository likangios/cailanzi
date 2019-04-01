//
//  CLZRegisterViewController.m
//  cailanzi
//
//  Created by luck on 2019/3/25.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZRegisterViewController.h"

@interface CLZRegisterViewController ()
@property(nonatomic,strong) UIImageView *avatar;

@property(nonatomic,strong) UITextField *phone;

@property(nonatomic,strong) UITextField *password;

@property(nonatomic,strong) UITextField *nickName;

@property(nonatomic,strong) UIButton *regist;


@end

@implementation CLZRegisterViewController

- (UIImageView *)avatar{
    if (!_avatar) {
        _avatar = [[UIImageView alloc]init];
        _avatar.image = [UIImage imageNamed:@"temp"];
        _avatar.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _avatar;
}
- (UITextField *)phone{
    if (!_phone) {
        _phone = [UITextField new];
        _phone.placeholder = @"请输入手机号";
        _phone.keyboardType = UIKeyboardTypeNumberPad;
        UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        icon.image = [UIImage imageNamed:@"mobile"];
        _phone.leftViewMode = UITextFieldViewModeAlways;
        _phone.leftView = icon;
    }
    return _phone;
}

- (UITextField *)password{
    if (!_password) {
        _password = [UITextField new];
        _password.placeholder = @"请输入密码";
        UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        icon.image = [UIImage imageNamed:@"mima"];
        _password.leftViewMode = UITextFieldViewModeAlways;
        _password.secureTextEntry = YES;
        _password.leftView = icon;
    }
    return _password;
}
- (UITextField *)nickName{
    if (!_nickName) {
        _nickName = [UITextField new];
        _nickName.placeholder = @"请输入昵称";
        UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        icon.image = [UIImage imageNamed:@"nicheng"];
        _nickName.leftViewMode = UITextFieldViewModeAlways;
        _nickName.leftView = icon;
    }
    return _nickName;
}

- (UIButton *)regist{
    if (!_regist) {
        _regist = [UIButton buttonWithType:UIButtonTypeCustom];
        _regist.backgroundColor = MainColor;
        [_regist setTitle:@"注册" forState:UIControlStateNormal];
        [_regist setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _regist.layer.cornerRadius = 4.0;
    }
    return _regist;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addDefaultBackItem];
    [self.view addSubview:self.avatar];
    [self.view addSubview:self.phone];
    [self.view addSubview:self.password];
    [self.view addSubview:self.nickName];
    [self.view addSubview:self.regist];
    
    [self.avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.customNavBar.mas_bottom).offset(40);
        make.size.mas_equalTo(100);
        make.centerX.equalTo(self.view);
    }];
    [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.left.mas_equalTo(30);
        make.height.mas_equalTo(45);
        make.top.equalTo(self.avatar.mas_bottom).offset(50);
    }];
    [self.phone addLineUp:NO andDown:YES];
    
    [self.password mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.left.mas_equalTo(30);
        make.height.mas_equalTo(45);
        make.top.equalTo(self.phone.mas_bottom).offset(15);
    }];
    [self.password addLineUp:NO andDown:YES];
    
    
    [self.nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.left.mas_equalTo(30);
        make.height.mas_equalTo(45);
        make.top.equalTo(self.password.mas_bottom).offset(15);
    }];
    [self.nickName addLineUp:NO andDown:YES];
    
    [self.regist mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.left.mas_equalTo(30);
        make.height.mas_equalTo(45);
        make.top.equalTo(self.nickName.mas_bottom).offset(45);
    }];
    
    [[self.phone rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        self.phone.text = [x substringToIndex:MIN(11, x.length)];
    }];
    
    [[self.password rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        self.password.text = [x substringToIndex:MIN(16, x.length)];
    }];
    [[self.nickName rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        self.nickName.text = [x substringToIndex:MIN(16, x.length)];
    }];
    
    
    @weakify(self);
    [[self.regist rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.phone.text.length != 11 || ![self.phone.text containsString:@"1"]) {
            [self showHUDMessage:@"手机号格式不正确"];
            return ;
        }
        if (!self.password.text.length) {
            [self showHUDMessage:@"请输入密码"];
            return ;
        }
        if (!self.nickName.text.length) {
            [self showHUDMessage:@"请输入昵称"];
            return ;
        }
        [self registAction];
    }];
}
- (void)registAction{
    
    @weakify(self);
    [[[CLZNetworkManager shareInstance] userRegiserWithPhone:self.phone.text Password:self.password.text nickName:self.nickName.text] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x isKindOfClass:[NSError class]]) {
            NSError *error = (NSError *)x;
            [self showHUDMessage:errorMsg(error)];
        }
        else{
            [self showHUDMessage:@"注册成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
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
