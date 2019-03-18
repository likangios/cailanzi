//
//  UIView+Common.m
//  DouBoPlayer
//
//  Created by macdev on 2017/3/23.
//  Copyright © 2017年 wby. All rights reserved.
//

#import "UIView+Common.h"
#import "UIColor+expanded.h"
#import "Masonry.h"
#import "UIView+Frame.h"

#define kScreen_Width [UIScreen mainScreen].bounds.size.width
#define kTagBadgeView  1000
#define kTagBadgePointView  1001
#define kTagLineView 1007
#define kTagSideLineView 1008
#define kMAIN_COLOR_GRAY [UIColor colorWithHexString:@"e6e6e6"]
@implementation UIView (Common)
- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown{
    [self addLineUp:hasUp andDown:hasDown andColor:kMAIN_COLOR_GRAY];
}

- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andColor:(UIColor *)color{
    return [self addLineUp:hasUp andDown:hasDown andColor:color andLeftSpace:0];
}
- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andColor:(UIColor *)color andLeftSpace:(CGFloat)leftSpace{
    [self removeViewWithTag:kTagLineView];
    if (hasUp) {
        UIView *upView = [UIView lineViewWithPointYY:0 andColor:color andLeftSpace:leftSpace];
        upView.tag = kTagLineView;
        [self addSubview:upView];
        [upView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(0);
            make.left.mas_equalTo(leftSpace);
            make.top.mas_offset(0);
            make.height.mas_offset(0.5);
        }];
    }
    if (hasDown) {
        UIView *downView = [UIView lineViewWithPointYY:CGRectGetMaxY(self.bounds)-0.5 andColor:color andLeftSpace:leftSpace];
        downView.tag = kTagLineView;
        [self addSubview:downView];
        [downView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(0);
            make.left.mas_equalTo(leftSpace);
            make.bottom.mas_offset(-0.5);
            make.height.mas_offset(0.5);
        }];
    }
}
- (void)removeViewWithTag:(NSInteger)tag{
    for (UIView *aView in [self subviews]) {
        if (aView.tag == tag) {
            [aView removeFromSuperview];
        }
    }
}
+ (UIView *)lineViewWithPointYY:(CGFloat)pointY andColor:(UIColor *)color andLeftSpace:(CGFloat)leftSpace{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(leftSpace, pointY, kScreen_Width - leftSpace, 0.5)];
    lineView.backgroundColor = color;
    return lineView;
}

- (void)addLineLeft:(BOOL)hasL andRight:(BOOL)hasR andColor:(UIColor *)color andTopSpace:(CGFloat)TopSpace{
    [self removeViewWithTag:kTagSideLineView];
    if (hasL) {
        UIView *Lview = [UIView lineViewWithPointYY:0 andColor:color andLeftSpace:TopSpace];
        Lview.tag = kTagSideLineView;
        [self addSubview:Lview];
        [Lview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(TopSpace);
            make.bottom.mas_equalTo(-TopSpace);
            make.width.mas_equalTo(0.5);
        }];
    }
    if (hasR) {
        UIView *Rview = [UIView lineViewWithPointYY:CGRectGetMaxY(self.bounds)-0.5 andColor:color andLeftSpace:TopSpace];
        Rview.tag = kTagSideLineView;
        [self addSubview:Rview];
        [Rview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(TopSpace);
            make.bottom.mas_equalTo(-TopSpace);
            make.width.mas_equalTo(0.5);
        }];

    }
}
- (void)addCornerWithPosition:(UIRectCorner)corner AndCornerRadii:(CGSize)radio{
    [self layoutIfNeeded];
    CGRect rect = self.frame;
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corner cornerRadii:radio];
    CAShapeLayer *masklayer = [[CAShapeLayer alloc]init];//创建shapelayer
    masklayer.frame = self.bounds;
    masklayer.path = path.CGPath;//设置路径
    self.layer.mask = masklayer;
}
- (void)addBlurEffectWithStyle:(UIBlurEffectStyle)style{
    [self addBlurEffectWithStyle:style WithAlpha:1.0];
}
- (void)addBlurEffectWithStyle:(UIBlurEffectStyle)style WithAlpha:(CGFloat)alpha{
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:style];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc]initWithEffect:effect];
        effectView.alpha = alpha;
    [self addSubview:effectView];
    [effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)addShadeWithColor:(UIColor *)color AndAlpha:(CGFloat)alpha{
    
    UIView *shadeView = [UIView new];
    shadeView.backgroundColor = [color colorWithAlphaComponent:alpha];
    [self addSubview:shadeView];
    [shadeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}
//- (void)addBackgroundTapBlocks:(void (^)())tap{
//    UIControl * control = [UIControl new];
//    [control bk_addEventHandler:^(id sender) {
//        tap();
//    } forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:control];
//    [control mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
//    }];
//    
//}


- (void)addGradientColorFromColor:(UIColor *)fColor ToColor:(UIColor *)tColor gradientDirection:(GradientDirection)direction{
    
    NSArray *arr = [NSArray arrayWithArray:self.layer.sublayers];
    for (CALayer *layer in arr) {
        if ([layer isKindOfClass:[CAGradientLayer class]]) {
            [layer removeFromSuperlayer];
        }
    }
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.colors = @[(id)fColor.CGColor,(id)tColor.CGColor];
    switch (direction) {
        case FromLeftToRight:
        {
            layer.startPoint = CGPointMake(0, 0);
            layer.endPoint = CGPointMake(1,0);
        }
            break;
        case FromRightToLeft:
        {
            layer.startPoint = CGPointMake(1, 0);
            layer.endPoint = CGPointMake(0,0);
        }
            break;
        case FromTopToBottom:
        {
            layer.startPoint = CGPointMake(0, 0);
            layer.endPoint = CGPointMake(0,1);
        }
            break;
        case FromBottomToTop:
        {
            layer.startPoint = CGPointMake(0, 1);
            layer.endPoint = CGPointMake(0,0);
        }
            break;
        default:
            break;
    }
    [self layoutIfNeeded];
    layer.frame = CGRectMake(0, 0, self.width, self.height);
//    [self.layer addSublayer:layer];
    [self.layer insertSublayer:layer atIndex:0];
    
}


@end
