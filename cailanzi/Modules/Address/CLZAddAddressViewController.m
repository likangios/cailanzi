//
//  CLZAddAddressViewController.m
//  cailanzi
//
//  Created by luck on 2019/3/29.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZAddAddressViewController.h"
#import "RCAddressSelectView.h"

@interface CLZAddAddressViewController ()<UITextFieldDelegate>

@property(nonatomic,strong) UITextField *userName;

@property(nonatomic,strong) UITextField *userPhone;

@property(nonatomic,strong) UITextField *city;

@property(nonatomic,strong) UITextField *detailAddress;

@property(nonatomic,strong) UITextField *storeName;

@property(nonatomic,strong) UIButton *confirmButton;

@end

@implementation CLZAddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarTitle:@"编辑地址"];
    if (!self.model) {
        [self setNavBarTitle:@"新建地址"];
        self.model = [[CLZAddressModel alloc]init];
    }
    NSArray *tips = @[@"收货人：",@"手机号：",@"收货地区：",@"详细地址：",@"店铺："];
    NSArray *placeholders = @[@"输入收货人(必填)",@"输入收货人手机号(必填)",@"输入选择收货地区(必填)",@"输入详细地址(必填)",@"输入店铺名称"];
    UIView *bottom = [[UIView alloc]init];
    [self.view addSubview:bottom];
    [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.customNavBar.mas_bottom).offset(10);
    }];
    UIView *firstView;
    for (int i = 0;i<placeholders.count;i++) {
        UIView *view = [UIView new];
        [bottom addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(45);
            if (firstView) {
                make.top.equalTo(firstView.mas_bottom);
            }
            else{
                make.top.mas_equalTo(0);
            }
        }];
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label = [UILabel new];
        label.text = tips[i];
        label.font = [UIFont systemFontOfSize:13];
        [view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(70);
        }];
        UITextField *textField = [[UITextField alloc]init];
        textField.borderStyle = UITextBorderStyleNone;
        textField.placeholder = placeholders[i];
        textField.textAlignment = NSTextAlignmentLeft;
        [view addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.left.equalTo(label.mas_right).offset(10);
            make.right.mas_equalTo(-15);
        }];
        [view addLineUp:NO andDown:YES];
        firstView = view;
        switch (i) {
            case 0:
                self.userName = textField;
                break;
            case 1:
                self.userPhone = textField;
                break;
            case 2:
                self.city = textField;
                break;
            case 3:
                self.detailAddress = textField;
                break;
            case 4:
                self.storeName = textField;
                break;
            default:
                break;
        }
    }
    self.city.delegate = self;
    self.userPhone.keyboardType = UIKeyboardTypeNumberPad;
    [firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(bottom.mas_bottom).offset(-10);
    }];
    
    [self.view addSubview:self.confirmButton];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(40);
        make.centerX.equalTo(self.view);
        make.top.equalTo(bottom.mas_bottom).offset(80);
        make.height.mas_equalTo(40);
    }];
    self.userName.text = self.model.userName;
    self.userPhone.text = self.model.phoneNumber;
    self.detailAddress.text = self.model.detailAddress;
    self.storeName.text = self.model.storeName;
    @weakify(self);
   RAC(self.city,text) = [RACSignal combineLatest:@[RACObserve(self.model, city),RACObserve(self.model, province),RACObserve(self.model, country)] reduce:^id _Nullable(id obj){
       @strongify(self);
        return [NSString stringWithFormat:@"%@%@%@",self.model.province?:@"",self.model.city?:@"",self.model.country?:@""];
    }];
//    RAC(self.city,text) = [RACObserve(self.model, city) map:^id _Nullable(id  _Nullable value) {
//        return [NSString stringWithFormat:@"%@%@%@",self.model.province?:@"",self.model.city?:@"",self.model.country?:@""];
//    }];
    
    RAC(self.model,userName) = [self.userName rac_textSignal];
    RAC(self.model,phoneNumber) = [[self.userPhone rac_textSignal] map:^id _Nullable(NSString * _Nullable value) {
        @strongify(self);
        self.userPhone.text = [value substringToIndex:MIN(value.length, 11)];
        return [value substringToIndex:MIN(value.length, 11)];
    }];
    RAC(self.model,detailAddress) = [self.detailAddress rac_textSignal];
    RAC(self.model,storeName) = [self.storeName rac_textSignal];
    
    RACSignal *userNameSignal = [[self.userName rac_textSignal] map:^id _Nullable(NSString * _Nullable value) {
        return @(value.length);
    }];
    RACSignal *userPhoneSignal = [[self.userPhone rac_textSignal] map:^id _Nullable(NSString * _Nullable value) {
        return @(value.length == 11);
    }];
    
    RACSignal *citySignal = [[self.city rac_textSignal] map:^id _Nullable(NSString * _Nullable value) {
        return @(value.length);
    }];
    
    RACSignal *detailSignal = [[self.detailAddress rac_textSignal] map:^id _Nullable(NSString * _Nullable value) {
        return @(value.length);
    }];
    
    RAC(self.confirmButton,enabled) = [RACSignal combineLatest:@[userNameSignal,userPhoneSignal,citySignal,detailSignal] reduce:^id _Nullable(NSNumber *x){
        return x;
    }];
    [[self.confirmButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"添加");
        @strongify(self);
        [self addAddressAction];
    }];
}
- (void)addAddressAction{
    [[[CLZNetworkManager shareInstance] updateAddress:self.model] subscribeNext:^(id  _Nullable x) {
        if ([x isKindOfClass:[NSError class]]) {
            NSError *error = (NSError *)x;
            [self showHUDMessage:errorMsg(error)];
        }
        else{
            [self showHUDMessage:@"添加成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self leftItemAction:nil];
            });
        }
    }];
}
- (UIButton *)confirmButton{
    if (!_confirmButton) {
        _confirmButton =[UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmButton setTitle:@"保存" forState:UIControlStateNormal];
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmButton.backgroundColor = MainColor;
        _confirmButton.layer.cornerRadius = 4;
        _confirmButton.adjustsImageWhenDisabled = YES;
    }
    return _confirmButton;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.city) {
        [self.view endEditing:YES];
        [self showCityList];
        return NO;
    }
    return YES;
}
- (void)showCityList{
    RCAddressSelectView *select = [[RCAddressSelectView  alloc]init];
    [select showWithBlock:^{
        
    } cofirm:^(id  _Nonnull obj) {
        self.model.province = obj[@"provinceName"];
        self.model.country = obj[@"countyName"];
        self.model.city = obj[@"cityName"];
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
