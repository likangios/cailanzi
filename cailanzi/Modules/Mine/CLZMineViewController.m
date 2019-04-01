//
//  CLZMineViewController.m
//  cailanzi
//
//  Created by luck on 2019/3/18.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZMineViewController.h"

@interface CLZMineViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) UIView *footView;

@end

@implementation CLZMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(navBarH, 0, 0, 0));
    }];
    [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:MainColor} forState:UIControlStateSelected];
    [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"7e7e7e"]} forState:UIControlStateNormal];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.backgroundColor = MainBGColor;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 100.0;
    }
    return 60.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row >0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else{
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    switch (indexPath.row) {
        case 0:
            cell.imageView.image = [UIImage imageNamed:[CLZUserInfo shareInstance].avatar];
            cell.textLabel.text = [CLZUserInfo shareInstance].nickName;
            break;
        case 1:
            cell.imageView.image = [UIImage imageNamed:@"order"];
            cell.textLabel.text = @"我的订单";
            break;
        case 2:
            cell.imageView.image = [UIImage imageNamed:@"order"];
            cell.textLabel.text = @"地址管理";
            break;
        case 3:
            cell.imageView.image = [UIImage imageNamed:@"shanchu"];
            cell.textLabel.text = [NSString stringWithFormat:@"清除缓存：%.2fM",[[SDImageCache sharedImageCache] getDiskCount]/1000.0];
            break;
        case 4:
            cell.imageView.image = [UIImage imageNamed:@"fankui"];
            cell.textLabel.text = @"意见反馈";
            break;
        case 5:
            cell.imageView.image = [UIImage imageNamed:@"tiaokuan"];
            cell.textLabel.text = @"用户协议";
            break;
        case 6:
            cell.imageView.image = [UIImage imageNamed:@"guanyu"];
            cell.textLabel.text = @"关于我们";
            break;
            
        default:
            break;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 100.0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return self.footView;
}
- (UIView *)footView{
    if (!_footView) {
        _footView = [UIView new];
        UIButton *logout = [UIButton buttonWithType:UIButtonTypeCustom];
        [logout setTitle:@"退出登录" forState:UIControlStateNormal];
        [logout setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        logout.backgroundColor = MainColor;
        logout.layer.cornerRadius = 4;
        logout.frame = CGRectMake(40, 60, kScreenWidth - 80, 40);
        @weakify(self);
        [[logout rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [self logout];
        }];
        [_footView addSubview:logout];
    }
    return _footView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 1:{
            UIViewController *fankui = [[NSClassFromString(@"CLZOrdersViewController") alloc]init];
            [self.navigationController pushViewController:fankui animated:YES];
        }
            break;
        case 2:{
            UIViewController *fankui = [[NSClassFromString(@"CLZAddressManagerViewController") alloc]init];
            [self.navigationController pushViewController:fankui animated:YES];
        }
            break;
        case 3:{
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                [self showHUDMessage:@"清除成功"];
                [self.tableView reloadData];
            }];
            
        }
            break;
        case 4:{
            UIViewController *fankui = [[NSClassFromString(@"CLZFanKuiViewController") alloc]init];
            [self.navigationController pushViewController:fankui animated:YES];
        }
            break;
        case 5:{
            UIViewController *fankui = [[NSClassFromString(@"CLZProtocolViewController") alloc]init];
            [self.navigationController pushViewController:fankui animated:YES];
        }
            break;
        case 6:{
            UIViewController *fankui = [[NSClassFromString(@"CLZAboutViewController") alloc]init];
            [self.navigationController pushViewController:fankui animated:YES];
        }
            break;
        default:
            break;
    }
}
- (void)logout{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:@"退出登录？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES completion:nil];
    }];
    @weakify(self);
    UIAlertAction *logout = [UIAlertAction actionWithTitle:@"退出" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showHUD];
        [[[CLZNetworkManager shareInstance] userLogout] subscribeCompleted:^{
            @strongify(self);
            [self hideHUD];
            [self showHUDMessage:@"退出成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.tabBarController.selectedIndex = 0;
                [alert dismissViewControllerAnimated:YES completion:nil];
            });
        }];
        
    }];
    [alert addAction:cancel];
    [alert addAction:logout];
    [self presentViewController:alert animated:YES completion:nil];
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
