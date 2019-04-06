//
//  CLZBaseViewController.h
//  cailanzi
//
//  Created by luck on 2019/3/18.
//  Copyright © 2019年 ting. All rights reserved.
//

#import <UIKit/UIKit.h>

#define navBarH  self.navigationController.navigationBar.frame.size.height+[[UIApplication sharedApplication] statusBarFrame].size.height


@interface CLZBaseViewController : UIViewController

@property (nonatomic,strong) UIButton *leftItemBtn;

@property (nonatomic,strong) UIButton *rightItemBtn;

@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) UILabel *backTipLabel;

@property (nonatomic,strong) UIView  *customNavBar;

@property (nonatomic,assign) CGFloat statusBarHeight;

- (void)adjustStatusBar;

- (void)hidenBottomLine;

- (void)hidenNavBar;

- (void)addDefaultBackItem;

- (void)setNavBarTitle:(NSString *)title;

- (void)setLeftItemTitle:(NSString *)title;

- (void)setLeftItemImage:(NSString *)imageName;

- (void)setRightItemTitle:(NSString *)title;

- (void)setRightItemImage:(NSString *)imageName;

- (void)leftItemAction:(id)sender;

- (void)rightItemAction:(id)sender;

- (BOOL) IsFirstTimeDisplay;


@end
