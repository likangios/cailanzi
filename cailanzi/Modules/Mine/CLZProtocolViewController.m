//
//  CLZProtocolViewController.m
//  cailanzi
//
//  Created by luck on 2019/3/25.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZProtocolViewController.h"

@interface CLZProtocolViewController ()

@property(nonatomic,strong) YYTextView *textView;

@end

@implementation CLZProtocolViewController
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
        _textView.font = [UIFont systemFontOfSize:15];
        _textView.placeholderText = @"请输入您的反馈内容";
        _textView.text = @"本软件尊重并保护所有使用服务用户的个人隐私权。为了给您提供更准确、更有个性化的服务，本软件会按照本隐私权政策的规定使用和披露您的个人信息。但本软件将以高度的勤勉、审慎义务对待这些信息。除本隐私权政策另有规定外，在未征得您事先许可的情况下，本软件不会将这些信息对外披露或向第三方提供。本软件会不时更新本隐私权政策。您在同意本软件服务使用协议之时，即视为您已经同意本隐私权政策全部内容。本隐私权政策属于本软件服务使用协议不可分割的一部分。\n在您使用本软件网络服务，本软件自动接收并记录的您的手机上的信息，包括但不限于使用的语言、访问日期和时间、软硬件特征信息及您需求的网页记录等数据；\n本软件不会将您的信息披露给不受信任的第三方。\n根据法律的有关规定，或者行政或司法机构的要求，向第三方或者行政、司法机构披露；\n如您出现违反中国有关法律、法规或者相关规则的情况，需要向第三方披露；\n本软件收集的有关您的信息和资料将保存在本软件及（或）其关联公司的服务器上，这些信息和资料可能传送至您所在国家、地区或本软件收集信息和资料所在地的境外并在境外被访问、存储和展示。\n在使用本软件网络服务进行网上交易时，您不可避免的要向交易对方或潜在的交易对方披露自己的个人信息，如联络方式或者邮政地址。请您妥善保护自己的个人信息，仅在必要的情形下向他人提供。如您发现自己的个人信息泄密，请您立即联络本软件客服，以便本软件采取相应措施。";
    }
    return _textView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addDefaultBackItem];
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.customNavBar.mas_bottom).offset(15);
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(-10);
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
