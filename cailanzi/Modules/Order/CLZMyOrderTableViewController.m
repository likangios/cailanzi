//
//  CLZMyOrderTableViewController.m
//  cailanzi
//
//  Created by luck on 2019/3/31.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZMyOrderTableViewController.h"
#import "CLZMyOrderTableViewCell.h"
@interface CLZMyOrderTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,assign) NSString *type;

@property(nonatomic,strong) NSArray <CLZOrderModel *> * dataArray;

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation CLZMyOrderTableViewController

-(instancetype)initWithType:(NSString *)type{
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self hidenNavBar];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    [self loadData];
}
- (void)loadData{
    @weakify(self);
    [[[CLZNetworkManager shareInstance] getMyOrdersWithType:self.type] subscribeNext:^(id  _Nullable x) {
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
        [_tableView registerClass:[CLZMyOrderTableViewCell class] forCellReuseIdentifier:@"CLZMyOrderTableViewCell"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self loadData];
        }];
        _tableView.estimatedRowHeight = 100.0;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.tableFooterView = [UIView new];
        
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CLZMyOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CLZMyOrderTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CLZOrderModel *model = self.dataArray[indexPath.row];
    cell.model = model;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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
