//
//  NSString+base64.h
//  BeePlayTestDemo
//
//  Created by luck on 2018/7/14.
//  Copyright © 2018年 luck. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (base64)
- (NSString *)SAblum_base64Decode;
- (NSString *)SAblum_base64Encode;
//字符串 替换
- (NSString *)SAblum_stringEncode;
//字符串 还原
- (NSString *)SAblum_stringDecode;
- (NSString *)SAblum_URLDecode;

- (NSString *)SAblum_md5;
@end
