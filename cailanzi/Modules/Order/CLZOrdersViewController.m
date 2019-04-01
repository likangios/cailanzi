//
//  CLZOrdersViewController.m
//  cailanzi
//
//  Created by luck on 2019/3/25.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZOrdersViewController.h"
#import "CLZMyOrdersPageViewController.h"

@interface CLZOrdersViewController ()

@end

@implementation CLZOrdersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CLZMyOrdersPageViewController *display = [[CLZMyOrdersPageViewController alloc]init];
    [self addChildViewController:display];
    [self.view addSubview:display.view];
    display.view.frame = CGRectMake(0, navBarH, kScreenWidth, kScreenHeight - navBarH);
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
