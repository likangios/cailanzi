//
//  CLZUserInfo.m
//  cailanzi
//
//  Created by luck on 2019/3/25.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZUserInfo.h"

@implementation CLZUserInfo

- (instancetype)init{
    self = [super init];
    if (self) {
        self.phone = [CLZStorageManager getUserPhone];
    }
    return self;
}
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"nickName":@"username"};
}
@end
