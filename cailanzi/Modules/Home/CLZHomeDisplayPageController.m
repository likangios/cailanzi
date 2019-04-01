//
//  CLZHomeDisplayPageController.m
//  cailanzi
//
//  Created by luck on 2019/3/26.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZHomeDisplayPageController.h"
#import "CLZGoosListViewController.h"
@interface CLZHomeDisplayPageController ()<WMPageControllerDelegate,WMPageControllerDataSource>

@property(nonatomic,strong) NSArray <CLZTypeModel *> *titlesArray;

@end

@implementation CLZHomeDisplayPageController

- (void)viewDidLoad {
    [super viewDidLoad];
    @weakify(self);
    [[[CLZNetworkManager shareInstance] getMenumItemData] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.titlesArray = x;
        [self reloadData];
    }];
    self.menuViewStyle = WMMenuViewStyleLine;
    self.titleColorSelected = MainColor;
    self.titleColorNormal = [UIColor  blackColor];
    self.progressColor = MainColor;
    self.progressWidth = 30.0;
    self.progressHeight = 3.0;
    self.menuViewLayoutMode = WMMenuViewLayoutModeCenter;
    self.titleSizeSelected = 15;
}

#pragma mark - ============== WMPageControllerDataSource ==============
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.titlesArray.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    CLZTypeModel *model = self.titlesArray[index];
    return model.name;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    CLZTypeModel *model = self.titlesArray[index];
    CLZGoosListViewController *list = [[CLZGoosListViewController alloc]initWithType:model.Type];
    if (index < self.titlesArray.count) {
        return list;
    }
    return [UIViewController new];
}
- (void)pageController:(WMPageController *)pageController didEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info{
    NSLog(@"didEnterViewController");
}
- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width + 20;
}
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    return CGRectMake(0, 0, self.view.frame.size.width, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {

    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
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
