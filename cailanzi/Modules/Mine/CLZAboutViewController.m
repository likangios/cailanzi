//
//  CLZAboutViewController.m
//  cailanzi
//
//  Created by luck on 2019/3/25.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZAboutViewController.h"

@interface CLZAboutViewController ()

@property(nonatomic,strong) UIImageView *icon;

@property(nonatomic,strong) UILabel *appName;

@property(nonatomic,strong) UILabel *appVersion;

@end
//AppIcon_60x60_
@implementation CLZAboutViewController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (UIImageView *)icon{
    if (!_icon) {
        _icon = [UIImageView new];
        _icon.image = [UIImage imageNamed:@"AppIcon60x60"];
        _icon.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _icon;
}
- (UILabel *)appName{
    
    if (!_appName) {
        _appName = [UILabel new];
        _appName.backgroundColor = [UIColor whiteColor];
        _appName.textColor = [UIColor blackColor];
        _appName.textAlignment = NSTextAlignmentLeft;
        _appName.font = [UIFont systemFontOfSize:14];
        NSString *name = [NSString stringWithFormat:@"      应用名称:%@",[NSBundle mainBundle].infoDictionary[@"CFBundleDisplayName"]];
        _appName.text = name;
    }
    return _appName;
}
- (UILabel *)appVersion{
    
    if (!_appVersion) {
        _appVersion = [UILabel new];
        _appVersion.backgroundColor = [UIColor whiteColor];
        _appVersion.textColor = [UIColor blackColor];
        _appVersion.textAlignment = NSTextAlignmentLeft;
        _appVersion.font = [UIFont systemFontOfSize:14];
        NSString *version = [NSString stringWithFormat:@"       应用版本:%@",[NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"]];
        _appVersion.text = version;
    }
    return _appVersion;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addDefaultBackItem];
    [self setNavBarTitle:@"关于我们"];
    self.view.backgroundColor = MainBGColor;
    [self.view addSubview:self.icon];
    [self.view addSubview:self.appName];
    [self.view addSubview:self.appVersion];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(100);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.customNavBar.mas_bottom).offset(25);
    }];
    
    [self.appName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(45);
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.icon.mas_bottom).offset(60);
    }];
    [self.appVersion mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(45);
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.appName.mas_bottom).offset(1);
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
