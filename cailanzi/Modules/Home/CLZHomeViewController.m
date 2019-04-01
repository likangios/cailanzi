
//
//  CLZHomeViewController.m
//  cailanzi
//
//  Created by luck on 2019/3/18.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZHomeViewController.h"
#import "CLZHomeDisplayPageController.h"

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
    CLZHomeDisplayPageController *display = [[CLZHomeDisplayPageController alloc]init];
    [self addChildViewController:display];
    [self.view addSubview:display.view];
    display.view.frame = CGRectMake(0, navBarH, kScreenWidth, kScreenHeight - navBarH);

    [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:MainColor} forState:UIControlStateSelected];
    [self.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"7e7e7e"]} forState:UIControlStateNormal];
    
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
