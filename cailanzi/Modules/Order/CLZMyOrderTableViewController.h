//
//  CLZMyOrderTableViewController.h
//  cailanzi
//
//  Created by luck on 2019/3/31.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZBaseViewController.h"

typedef enum : NSUInteger {
    orderType_Pending,
    orderTYpe_Receipt,
    orderType_Received,
} orderType;


@interface CLZMyOrderTableViewController : CLZBaseViewController
-(instancetype)initWithType:(NSString *)type;
@end
