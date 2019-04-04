//
//  Macros.h
//  cailanzi
//
//  Created by luck on 2019/3/18.
//  Copyright © 2019年 ting. All rights reserved.
//

#ifndef Macros_h
#define Macros_h


#define  CLZ_DEBUG  0

#define APPDELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define DCIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)


#define KEYWINDOW  [UIApplication sharedApplication].keyWindow

/** 屏幕高度 */
#define ScreenH [UIScreen mainScreen].bounds.size.height
/** 屏幕宽度 */
#define ScreenW [UIScreen mainScreen].bounds.size.width

#define kAUTOSCALE_WIDTH(width) (width) * ScreenW/375.00
#define kAUTOSCALE_HEIGHT(height) (height) * ScreenH/667.00

/** 弱引用 */
#define WEAKSELF __weak typeof(self) weakSelf = self;

/*****************  屏幕适配  ******************/
#define iphone6p (ScreenH == 763)
#define iphone6 (ScreenH == 667)
#define iphone5 (ScreenH == 568)
#define iphone4 (ScreenH == 480)

#define APP_VERSION                         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//色值
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define HEXCOLOR(hex) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:1]

#define MainColor [UIColor colorWithHexString:@"1acaaf"]

#define MainGrayColor [UIColor colorWithHexString:@"bfbfbf"]

#define MainBGColor [UIColor colorWithHexString:@"e6e6e6"]


#define errorMsg(error) error.userInfo[NSLocalizedDescriptionKey]?:error.userInfo[NSLocalizedFailureReasonErrorKey]


/******************    TabBar          *************/
#define MallClassKey   @"rootVCClassString"
#define MallTitleKey   @"title"
#define MallImgKey     @"imageName"
#define MallSelImgKey  @"selectedImageName"



#endif /* Macros_h */
