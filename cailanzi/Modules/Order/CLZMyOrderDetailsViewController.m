//
//  CLZMyOrderDetailsViewController.m
//  cailanzi
//
//  Created by luck on 2019/4/5.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZMyOrderDetailsViewController.h"
#import "CLZGoodsTableViewCell.h"
@interface CLZMyOrderDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;


@property(nonatomic,strong) UIView *bottomView;

@property(nonatomic,strong) UILabel *total_money;

@property(nonatomic,strong) UILabel *topLabel;

@property(nonatomic,strong) UIView *addressView;

@property(nonatomic,strong) UILabel *remarkTextView;

@end

@implementation CLZMyOrderDetailsViewController

- (UIView *)addressView{
    if (!_addressView) {
        _addressView = [UIView new];
    }
    return _addressView;
}
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
- (UILabel *)remarkTextView{
    if (!_remarkTextView) {
        _remarkTextView  =[[UILabel alloc]init];
        _remarkTextView.backgroundColor = MainBGColor;
    }
    return _remarkTextView;
}
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]init];
        _bottomView.backgroundColor =[UIColor whiteColor];
    }
    return _bottomView;
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
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([CLZUserInfo shareInstance].admin.intValue > 0) {
        [self setRightItemTitle:@"操作"];
    }
    NSArray *state = @[@"已提交",@"已确认",@"已完成"];
    [self setNavBarTitle:[NSString stringWithFormat:@"订单详情(%@)",state[self.model.orderType.intValue]]];
    [self.view addSubview:self.addressView];
    [self.addressView addSubview:self.topLabel];
    [self.view addSubview:self.remarkTextView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
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
        make.height.mas_greaterThanOrEqualTo(10);
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
    
    [self.total_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(-20);
    }];
    
    if (self.model.address.storeName.length) {
        self.topLabel.text = [NSString stringWithFormat:@"【%@】%@ %@\n%@%@%@%@",self.model.address.storeName,self.model.address.userName,self.model.address.phoneNumber,self.model.address.province,self.model.address.city,self.model.address.country,self.model.address.detailAddress];
    }
    else{
        self.topLabel.text = [NSString stringWithFormat:@"%@ %@\n%@%@%@%@",self.model.address.userName,self.model.address.phoneNumber,self.model.address.province,self.model.address.city,self.model.address.country,self.model.address.detailAddress];
    }

    self.remarkTextView.text  = [NSString stringWithFormat:@"备注：%@",self.model.remark?:@""];

    __block  CGFloat total_price = 0.00;
    [self.model.goodList enumerateObjectsUsingBlock:^(CLZCarModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        total_price = total_price + (obj.goods.total_price.floatValue * obj.count);
    }];
    self.total_money.text = [NSString stringWithFormat:@"总价：￥%.2f",total_price];
    
}
- (void)rightItemAction:(id)sender{
    UIAlertController *contro = [UIAlertController alertControllerWithTitle:@"修改订单状态" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"已提交" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self updateOrderType:@(0)];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"已确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self updateOrderType:@(1)];
    }];
    UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"已完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self updateOrderType:@(2)];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [contro dismissViewControllerAnimated:YES completion:nil];
    }];
    [contro addAction:action1];
    [contro addAction:action2];
    [contro addAction:action3];
    [contro addAction:cancel];

    [self presentViewController:contro animated:YES completion:nil];
}
- (void)updateOrderType:(NSNumber *)type{
    [[[CLZNetworkManager shareInstance] updateOrderWithobjectId:self.model.objectId Type:type] subscribeNext:^(id  _Nullable x) {
        if ([x isKindOfClass:[NSError class]]) {
            NSError *error = (NSError *)x;
            [self showHUDWithMessage:errorMsg(error)];
        }
        else{
            [self showHUDMessage:@"操作成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.model.goodList.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CLZGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CLZGoodsTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CLZCarModel *carModel = self.model.goodList[indexPath.row];
    cell.carModel = carModel;
    [cell showNumberWith:carModel.count];
    return cell;
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
