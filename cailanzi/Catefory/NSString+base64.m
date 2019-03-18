//
//  NSString+base64.m
//  BeePlayTestDemo
//
//  Created by luck on 2018/7/14.
//  Copyright © 2018年 luck. All rights reserved.
//

#import "NSString+base64.h"
#import <CommonCrypto/CommonDigest.h>


@implementation NSString (base64)
- (NSString *)SAblum_base64Encode{
    NSData *data =  [self dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}
- (NSString *)SAblum_base64Decode{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}
- (NSString *)SAblum_stringEncode{
    NSMutableString *muString = [NSMutableString stringWithString:self];
    NSArray *currentStrings = @[@"-",@"_",@"c",@"e",@"#",@"x",@"z",
                                @"#",@"C",@"E",@"#",@"X",@"Z",@"#",];
    NSArray *withStrings = @[@"+",@"/",@"#",@"c",@"e",@"#",@"x",
                             @"z",@"#",@"C",@"E",@"#",@"X",@"Z",];
    [currentStrings enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [muString replaceOccurrencesOfString:obj withString:withStrings[idx] options:2 range:NSMakeRange(0, muString.length)];
    }];
    return muString;
}
- (NSString *)SAblum_stringDecode{
    NSMutableString *muString = [NSMutableString stringWithString:self];
    NSArray *currentStrings = @[@"-",@"_",@"c",@"e",@"#",@"x",@"z",
                                @"#",@"C",@"E",@"#",@"X",@"Z",@"#",];
    currentStrings = [[currentStrings reverseObjectEnumerator] allObjects];
    
    NSArray *withStrings = @[@"+",@"/",@"#",@"c",@"e",@"#",@"x",
                             @"z",@"#",@"C",@"E",@"#",@"X",@"Z",];
    withStrings = [[withStrings reverseObjectEnumerator] allObjects];
    
    [withStrings enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [muString replaceOccurrencesOfString:obj withString:currentStrings[idx] options:2 range:NSMakeRange(0, muString.length)];
    }];
    return muString;
    
}

- (NSString *)SAblum_md5{
    const char* input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    return digest;
}

- (NSString *)SAblum_URLDecode{
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
(__bridge CFStringRef)self,
CFSTR(""),
CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}
@end
