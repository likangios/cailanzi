//
//  CLZCarViewController.m
//  cailanzi
//
//  Created by luck on 2019/3/18.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZCarViewController.h"
#import "CLZGoodsTableViewCell.h"
#import "CLZAddressManagerViewController.h"
@interface CLZCarViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

@property(nonatomic,strong) NSArray <CLZCarModel *> * dataArray;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) UIView *bottomView;

@property(nonatomic,strong) UIButton *confirm;

@property(nonatomic,strong) UILabel *total_money;

@property(nonatomic,strong) UIView *addressView;

@property(nonatomic,strong) UILabel *topLabel;

@property(nonatomic,strong) UILabel *detailsLabel;

@property(nonatomic,strong) YYTextView *remarkTextView;

@property(nonatomic,strong) CLZAddressModel *addressModel;

@end

@implementation CLZCarViewController

- (UILabel *)topLabel{
    if (!_topLabel) {
        _topLabel = [UILabel new];
        _topLabel.textColor = [UIColor blackColor];
        _topLabel.textAlignment = NSTextAlignmentLeft;
        _topLabel.numberOfLines = 2;
        _topLabel.text = @"选择送货地址 >";
    }
    return _topLabel;
}
- (YYTextView *)remarkTextView{
    if (!_remarkTextView) {
        _remarkTextView  =[[YYTextView alloc]init];
        _remarkTextView.backgroundColor = MainBGColor;
        _remarkTextView.placeholderText = @"输入备注：";
    }
    return _remarkTextView;
}
- (UIView *)addressView{
    if (!_addressView) {
        _addressView = [UIView new];
    }
    return _addressView;
}
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor =[UIColor whiteColor];
    }
    return _bottomView;
}
- (UIButton *)confirm{
    if (!_confirm) {
        _confirm = [UIButton buttonWithType:UIButtonTypeCustom];
        _confirm.backgroundColor = MainColor;
        [_confirm setTitle:@"提交订单" forState:UIControlStateNormal];
        _confirm.titleLabel.font  = [UIFont boldSystemFontOfSize:25];
    }
    return _confirm;
}
- (UILabel *)total_money{
    if (!_total_money) {
        _total_money = [UILabel new];
        _total_money.backgroundColor = [UIColor clearColor];
        _total_money.textColor = [UIColor blackColor];
        _total_money.textAlignment = NSTextAlignmentLeft;
        _total_money.font = [UIFont boldSystemFontOfSize:28];
        _total_money.text = @"总价￥：00.00";
    }
    return _total_money;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavBarTitle:@"菜篮子"];
    [self.view addSubview:self.addressView];
    [self.addressView addSubview:self.topLabel];
    [self.view addSubview:self.remarkTextView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.confirm];
    [self.bottomView addSubview:self.total_money];
    
    [self.addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.customNavBar.mas_bottom).offset(0);
        make.height.mas_equalTo(50);
    }];
    [self.addressView addLineUp:NO andDown:YES];
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-15);
    }];
    [self.remarkTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
        make.top.equalTo(self.addressView.mas_bottom);
    }];
    [self.remarkTextView addLineUp:NO andDown:YES];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.equalTo(self.remarkTextView.mas_bottom);
        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(40.0);
    }];
    [self.bottomView addLineUp:YES andDown:NO];

    [self.confirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(0);
        make.width.mas_equalTo(120);
    }];
    [self.total_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.bottom.mas_equalTo(0);
        make.right.equalTo(self.confirm.mas_left).offset(-20);
    }];
    
    @weakify(self);
    [RACObserve([CLZCarManager shareInstance], allCount) subscribeNext:^(NSNumber *x) {
        @strongify(self);
        self.tableView.hidden = !x.boolValue;
        [self loadData];
    }];
    RAC(self.total_money,text) = [RACObserve([CLZCarManager shareInstance], allPrice) map:^id _Nullable(NSNumber * value) {
        NSLog(@"====%@",value);
        return [NSString stringWithFormat:@"总价￥：%.2f",value.floatValue];
    }];
    
    
    [[self.confirm rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        if (!self.dataArray.count) {
            return ;
        }
        if (![CLZUserInfo shareInstance].isLogin) {
            return;
        }
        if (!self.addressModel) {
            [self showHUDMessage:@"选择收货地址"];
            return;
        }
        if ([CLZCarManager shareInstance].allPrice < [CLZConfig shareInstance].minePrice.floatValue) {
            NSString *minePrice = [NSString stringWithFormat:@"总价低于起送价格(%.2f)",[CLZConfig shareInstance].minePrice.floatValue];
            [self showHUDMessage:minePrice];
            return;
        }
        NSMutableArray *array = [NSMutableArray array];
        [self.dataArray enumerateObjectsUsingBlock:^(CLZCarModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [array addObject:[obj  modelToJSONObject]];
        }];
        NSDictionary *address = [self.addressModel mj_JSONObject];
        [[[CLZNetworkManager shareInstance] confirmOrder:address goodsList:array] subscribeNext:^(id  _Nullable x) {
            if ([x isKindOfClass:[NSError class]]) {
                NSError *error = (NSError *)x;
                [self showHUDMessage:errorMsg(error)];
            }
            else{
                [self showHUDMessage:@"订单提交成功"];
                [[CLZCarManager shareInstance] removeAll];
            }
        }];;
    }];
    [RACObserve([CLZUserInfo shareInstance], isLogin) subscribeNext:^(NSNumber * x) {
        if (!x.boolValue) {
            self.addressModel = nil;
        }
    }];
    [RACObserve(self, addressModel) subscribeNext:^(id  _Nullable x) {
        if (x) {
            self.topLabel.text = [NSString stringWithFormat:@"%@ %@\n%@%@%@%@",self.addressModel.userName,self.addressModel.phoneNumber,self.addressModel.province,self.addressModel.city,self.addressModel.country,self.addressModel.detailAddress];
        }
        else{
            self.topLabel.text = @"选择送货地址 >";
        }
    }];
    
    [self.addressView bk_whenTapped:^{
        if (![CLZUserInfo shareInstance].isLogin) {
            return;
        }
        CLZAddressManagerViewController *address = [[CLZAddressManagerViewController alloc]init];
        [address setSelectAddress:^(CLZAddressModel *address) {
            self.addressModel = address;
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [self.navigationController pushViewController:address animated:YES];
    }];
    
    [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:MainColor} forState:UIControlStateSelected];
    [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"7e7e7e"]} forState:UIControlStateNormal];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}
- (void)loadData{
    self.dataArray = [[CLZCarManager shareInstance] getAllCarGoods];
    [self.tableView reloadData];
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.backgroundColor = MainBGColor;
        [_tableView registerClass:[CLZGoodsTableViewCell class] forCellReuseIdentifier:@"CLZGoodsTableViewCell"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CLZGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CLZGoodsTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CLZCarModel *carModel = self.dataArray[indexPath.row];
    cell.carModel = carModel;
    cell.showNumber = YES;
    return cell;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
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
