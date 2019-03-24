//
//  CLZAPIManager.m
//  cailanzi
//
//  Created by luck on 2019/3/19.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZAPIManager.h"
@interface CLZAPIManager()

@property(nonatomic,strong) AFHTTPSessionManager *manager;

@end

@implementation CLZAPIManager

static CLZAPIManager *_instance;
+(instancetype)shareInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[CLZAPIManager alloc]init];
    });
    return _instance;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _manager = [[AFHTTPSessionManager  alloc]initWithSessionConfiguration:configuration];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _manager.requestSerializer.timeoutInterval = 30;
    }
    return self;
}
- (RACSignal *)CustomGET:(NSString *)URLString parameters:(id)parameters{
    
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [self.manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *result = [responseObject mj_JSONObject];
            if (result && [result[@"resultCode"] isEqualToString:@"0000"]) {
                [subscriber sendNext:result[@"resultData"]];
            }
            else if (result){
                NSLog(@"faile:%@====errorMsg:%@",URLString,result[@"resultMsg"]);
            }
            [subscriber sendCompleted];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"faile:%@====errorMsg:%@",task.currentRequest.URL.absoluteString,error.description);
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
  
}
- (RACSignal *)CustomPost:(NSString *)URLString parameters:(id)parameters{
    return  [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        [self.manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary *result = [responseObject mj_JSONObject];
            [subscriber sendNext:result];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [subscriber sendCompleted];
        }];
        return  [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}
@end
