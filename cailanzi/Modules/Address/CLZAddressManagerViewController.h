//
//  CLZAddressManagerViewController.h
//  cailanzi
//
//  Created by luck on 2019/3/25.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZBaseViewController.h"

@interface CLZAddressManagerViewController : CLZBaseViewController

@property(nonatomic,copy) void(^selectAddress)(CLZAddressModel *address);

@end
