//
//  UIView+Common.h
//  DouBoPlayer
//
//  Created by macdev on 2017/3/23.
//  Copyright © 2017年 wby. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    FromLeftToRight = 1,
    FromRightToLeft,
    FromTopToBottom,
    FromBottomToTop
}GradientDirection;

@interface UIView (Common)
- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown;
- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andColor:(UIColor *)color;
- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andColor:(UIColor *)color andLeftSpace:(CGFloat)leftSpace;
- (void)addLineLeft:(BOOL)hasL andRight:(BOOL)hasR andColor:(UIColor *)color andTopSpace:(CGFloat)TopSpace;

/**
 添加圆角 view 只能设置frame有效 layout 无效

 @param corner 圆角位置
 @param radio 圆角大小
 */
- (void)addCornerWithPosition:(UIRectCorner)corner AndCornerRadii:(CGSize)radio;

/**
 添加毛玻璃效果

 @param style style
 */
- (void)addBlurEffectWithStyle:(UIBlurEffectStyle)style;
- (void)addBlurEffectWithStyle:(UIBlurEffectStyle)style WithAlpha:(CGFloat)alpha;

/**
 添加遮罩层

 @param color 颜色
 @param alpha 透明度
 */
- (void)addShadeWithColor:(UIColor *)color AndAlpha:(CGFloat)alpha;
- (void)addBackgroundTapBlocks:(void (^)())tap;

- (void)addGradientColorFromColor:(UIColor *)fColor ToColor:(UIColor *)tColor gradientDirection:(GradientDirection)direction;

@end
