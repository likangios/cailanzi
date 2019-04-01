//
//  CLZGoosListViewController.m
//  cailanzi
//
//  Created by luck on 2019/3/26.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZGoosListViewController.h"
#import "CLZGoodsTableViewCell.h"
@interface CLZGoosListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) NSString *type;

@property(nonatomic,strong) NSArray <CLZGoodsModel *> * dataArray;

@property(nonatomic,strong) UITableView *tableView;

@end

@implementation CLZGoosListViewController

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
    [[[CLZNetworkManager shareInstance] getHomeDataWithTypeString:self.type] subscribeNext:^(id  _Nullable x) {
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
        [_tableView registerClass:[CLZGoodsTableViewCell class] forCellReuseIdentifier:@"CLZGoodsTableViewCell"];
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
    CLZGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CLZGoodsTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CLZGoodsModel *model = self.dataArray[indexPath.row];
    cell.goodModel = model;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CLZGoodsModel *model = self.dataArray[indexPath.row];
    [[CLZCarManager shareInstance] addGoodsToCar:model];
    [self showHUDMessage:@"加入菜篮子"];
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
