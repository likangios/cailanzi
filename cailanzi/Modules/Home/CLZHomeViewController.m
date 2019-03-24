
//
//  CLZHomeViewController.m
//  cailanzi
//
//  Created by luck on 2019/3/18.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZHomeViewController.h"

#import "CLZHomeCommendRequest.h"
#import "CLZCommendModel.h"
#import "CLZGoodsTableViewCell.h"

@interface CLZHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,assign) NSInteger page;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic,strong) CLZCommendModel *commendModel;


@end

@implementation CLZHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarTitle:@"首页"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(navBarH, 0, 0, 0));
    }];
    [self loadData];
    
}
- (void)loadData{
    @weakify(self);
    [[CLZHomeCommendRequest requestHomeCommendDataWithPage:self.page] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (self.commendModel) {
            CLZCommendModel *newData = [CLZCommendModel modelWithDictionary:x];
//            [self addServiceData:newData.list];
            NSMutableArray <CLZGoodsModel *>*array  = self.commendModel.list;
            [array appendObjects:newData.list];
            newData.list = array;
            self.commendModel = newData;
            [self.tableView.mj_footer endRefreshing];
        }
        else{
        self.commendModel = [CLZCommendModel modelWithDictionary:x];
//            [self addServiceData:self.commendModel.list];
        }
        [self.tableView reloadData];
    }];
}
- (void)addServiceData:(NSMutableArray *)array{
    [array enumerateObjectsUsingBlock:^(CLZGoodsModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            AVObject *avobj = [AVObject objectWithClassName:@"CLZGoods"];
            NSDictionary *modelDic = [model modelToJSONObject];
            [modelDic bk_each:^(id key, id obj) {
                [avobj setObject:obj forKey:key];
            }];
            AVFile *file = [AVFile fileWithRemoteURL:[NSURL URLWithString:model.goodsImage]];
            [file uploadWithCompletionHandler:^(BOOL succeeded, NSError * _Nullable error) {
                if (succeeded) {
                    [avobj setObject:file.url forKey:@"goodsImage"];
                    [avobj saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self showHUDMessage:@"保存成功"];
                        });
                        
                    }];
                }
                else{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self showHUDMessage:@"图片上传失败"];
                    });
                    
                }
            }];
        });
        
    }];
    
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.backgroundColor = MainBGColor;
        [_tableView registerClass:[CLZGoodsTableViewCell class] forCellReuseIdentifier:@"CLZGoodsTableViewCell"];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
            if (self.commendModel && self.commendModel.hasNextPage) {
                self.page++;
                [self loadData];
            }
            else{
                [self.tableView.mj_footer resetNoMoreData];
                [self.tableView.mj_footer endRefreshing];

               
                
            }
        }];
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.commendModel.list.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CLZGoodsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CLZGoodsTableViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CLZGoodsModel *model = self.commendModel.list[indexPath.row];
    [cell.goodImage sd_setImageWithURL:[NSURL URLWithString:model.goodsImage] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
    }];
    cell.goodName.text = model.goodsName;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    CLZGoodsModel *model = self.commendModel.list[indexPath.row];
//
//    AVObject *avobj = [AVObject objectWithClassName:@"CLZGoods"];
//    NSDictionary *modelDic = [model modelToJSONObject];
//    [modelDic bk_each:^(id key, id obj) {
//        [avobj setObject:obj forKey:key];
//    }];
//    AVFile *file = [AVFile fileWithRemoteURL:[NSURL URLWithString:model.goodsImage]];
//    [file uploadWithCompletionHandler:^(BOOL succeeded, NSError * _Nullable error) {
//        if (succeeded) {
//            [avobj setObject:file.url forKey:@"goodsImage"];
//            [avobj saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//                [self showHUDMessage:@"保存成功"];
//            }];
//        }
//        else{
//             [self showHUDMessage:@"图片上传失败"];
//        }
//    }];
    
 
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
