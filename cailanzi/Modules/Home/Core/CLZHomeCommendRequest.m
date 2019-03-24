//
//  CLZHomeCommendRequest.m
//  cailanzi
//
//  Created by luck on 2019/3/19.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZHomeCommendRequest.h"

@implementation CLZHomeCommendRequest

+(RACSignal *)requestHomeCommendDataWithPage:(NSInteger)page{
    NSString *url = [NSString stringWithFormat:@"http://api.xznxs.net/goods/v1/bill/commend/page?pageSize=9&pageNum=%ld",(long)page];
    return [[CLZAPIManager shareInstance] CustomGET:url parameters:nil];
}

@end
