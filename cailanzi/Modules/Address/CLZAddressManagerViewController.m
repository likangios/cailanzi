//
//  CLZAddressManagerViewController.m
//  cailanzi
//
//  Created by luck on 2019/3/25.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZAddressManagerViewController.h"
#import "CLZAddAddressViewController.h"

@interface CLZAddressManagerViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) NSArray <CLZAddressModel *> * dataArray;

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation CLZAddressManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRightItemTitle:@"新建"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(navBarH);
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    [self loadData];
}
- (void)loadData{
    @weakify(self);
    [[[CLZNetworkManager shareInstance] getAddressList] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if ([x isKindOfClass:[NSError class]]) {
            NSError *error = (NSError *)x;
            [self showHUDMessage:errorMsg(error)];
        }
        else{
            self.dataArray = x;
            [self.tableView reloadData];
        }
        [self.tableView.mj_header endRefreshing];
    }];
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.backgroundColor = MainBGColor;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self loadData];
        }];
        _tableView.tableFooterView = [UIView new];
        
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];
        cell.detailTextLabel.textColor = MainColor;
        [cell.textLabel sizeToFit];
    }
    CLZAddressModel *model = self.dataArray[indexPath.row];
    if (model.storeName.length) {
        cell.textLabel.text = [NSString stringWithFormat:@"【%@】%@:%@",model.storeName,model.userName,model.phoneNumber];
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"%@:%@",model.userName,model.phoneNumber];
    }
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@-%@-%@-%@",model.province,model.city,model.country,model.detailAddress];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CLZAddressModel *model = self.dataArray[indexPath.row];
    if (self.selectAddress) {
        self.selectAddress(model);
    }
    else{
        CLZAddAddressViewController *add =[[CLZAddAddressViewController alloc]init];
        add.model = model;
        [self.navigationController pushViewController:add animated:YES];
    }
}
#pragma mark - action
- (void)rightItemAction:(id)sender{
    CLZAddAddressViewController *add =[[CLZAddAddressViewController alloc]init];
    [self.navigationController pushViewController:add animated:YES];
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
