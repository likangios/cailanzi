//
//  AppDelegate+extend.m
//  cailanzi
//
//  Created by luck on 2019/3/20.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "AppDelegate+extend.h"

@implementation AppDelegate (extend)

- (void)initAVOSCloud{
    [AVOSCloud setApplicationId:@"rOhkoAH9bgcXVW3SJIn5tj1c-gzGzoHsz" clientKey:@"pISJp7aEHySrAgbD5cpjteDv"];
    [AVOSCloud setAllLogsEnabled:YES];
}
@end
