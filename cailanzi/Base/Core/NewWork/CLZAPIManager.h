//
//  CLZAPIManager.h
//  cailanzi
//
//  Created by luck on 2019/3/19.
//  Copyright © 2019年 ting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLZAPIManager : NSObject

+(instancetype)shareInstance;
/**
 自定义get请求
 */
- (RACSignal *)CustomGET:(NSString *)URLString
              parameters:(id)parameters;

/**
 自定义Post请求
 */
- (RACSignal *)CustomPost:(NSString *)URLString
        parameters:(id)parameters;

@end
