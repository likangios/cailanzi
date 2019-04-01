//
//  RCAddressSelectView.h
//  Podium
//
//  Created by realcloud on 2019/3/18.
//  Copyright © 2019年 realcloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCAreaManager.h"

NS_ASSUME_NONNULL_BEGIN


@interface RCAddressSelectView : UIView

- (void)showWithBlock:(void (^)(void))cancel cofirm:(void (^)(id obj))confirm;

@end


NS_ASSUME_NONNULL_END
