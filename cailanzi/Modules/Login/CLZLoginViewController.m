//
//  CLZLoginViewController.m
//  cailanzi
//
//  Created by luck on 2019/3/25.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZLoginViewController.h"
#import "CLZRegisterViewController.h"

@interface CLZLoginViewController ()

@property(nonatomic,strong) UIImageView *avatar;

@property(nonatomic,strong) UITextField *phone;

@property(nonatomic,strong) UITextField *password;

@property(nonatomic,strong) UIButton *login;


@end

@implementation CLZLoginViewController

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
        _phone.clearButtonMode  =UITextFieldViewModeAlways;
        _phone.leftViewMode = UITextFieldViewModeAlways;
        _phone.leftView = icon;
        _phone.text = [CLZUserInfo
                       shareInstance].phone;
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
        _password.clearButtonMode  =UITextFieldViewModeAlways;
        _password.secureTextEntry = YES;
        _password.leftView = icon;
    }
    return _password;
}
- (UIButton *)login{
    if (!_login) {
        _login = [UIButton buttonWithType:UIButtonTypeCustom];
        _login.backgroundColor = MainColor;
        [_login setTitle:@"登录" forState:UIControlStateNormal];
        [_login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _login.layer.cornerRadius = 4.0;
    }
    return _login;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addDefaultBackItem];
    [self setRightItemTitle:@"注册"];
    [self.view addSubview:self.avatar];
    [self.view addSubview:self.phone];
    [self.view addSubview:self.password];
    [self.view addSubview:self.login];
    
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
    
    [self.login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.left.mas_equalTo(30);
        make.height.mas_equalTo(45);
        make.top.equalTo(self.password.mas_bottom).offset(45);
    }];
    
    [[self.phone rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        self.phone.text = [x substringToIndex:MIN(11, x.length)];
    }];
    
    [[self.password rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
        self.password.text = [x substringToIndex:MIN(16, x.length)];
    }];
    
    @weakify(self);
    [[self.login rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        if (self.phone.text.length != 11) {
            [self showHUDMessage:@"手机号格式不正确"];
            return ;
        }
        if (!self.password.text.length) {
            [self showHUDMessage:@"请输入密码"];
            return ;
        }
        [self loginAction];
    }];
}
- (void)loginAction{
    [self showHUD];
    
    @weakify(self);
    [[[CLZNetworkManager shareInstance] userLoginWithPhone:self.phone.text Password:self.password.text] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self hideHUD];
        if ([x isKindOfClass:[NSError class]]) {
            NSError *error = (NSError *)x;
            [self showHUDMessage:errorMsg(error)];
        }
        else{
            [self showHUDMessage:@"登录成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self leftItemAction:nil];
            });
            
        }
    }];
}
- (void)rightItemAction:(id)sender{
    CLZRegisterViewController *regist = [[CLZRegisterViewController alloc]init];
    [self.navigationController pushViewController:regist animated:YES];
}
- (void)leftItemAction:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
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
