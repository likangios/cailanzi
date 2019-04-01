//
//  CLZNetworkManager.m
//  cailanzi
//
//  Created by luck on 2019/3/25.
//  Copyright © 2019年 ting. All rights reserved.
//

#import "CLZNetworkManager.h"

@implementation CLZNetworkManager

static CLZNetworkManager *_instance;
+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[[self class] alloc]init];
    });
    return _instance;
}
- (RACSignal *)getMenumItemData{
    return  [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        AVObject *obj = [AVObject objectWithClassName:@"GoodsType"];
        [obj refreshInBackgroundWithBlock:^(AVObject * _Nullable object, NSError * _Nullable error) {
            if (error) {
                [subscriber sendNext:error];
            }
            else{
                NSArray *array =  [object objectForKey:@"results"];
                NSArray <CLZTypeModel *>* modelArray = [CLZTypeModel mj_objectArrayWithKeyValuesArray:array];
                [subscriber sendNext:modelArray];
            }
            [subscriber sendCompleted];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}
- (RACSignal *)getHomeDataWithTypeString:(NSString *)type{
    return  [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        AVObject *obj = [AVObject objectWithClassName:type];
        [obj refreshInBackgroundWithBlock:^(AVObject * _Nullable object, NSError * _Nullable error) {
            if (error) {
                [subscriber sendNext:error];
            }
            else{
                NSArray *array =  [object objectForKey:@"results"];
                NSArray <CLZGoodsModel *>* modelArray = [CLZGoodsModel mj_objectArrayWithKeyValuesArray:array];
                [subscriber sendNext:modelArray];
            }
            [subscriber sendCompleted];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}
- (RACSignal *)getHomeDataWithType:(GoodsDataType)type{
    
    NSString *className = [NSString stringWithFormat:@"MCGoods100%ld",type];
    return  [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        AVObject *obj = [AVObject objectWithClassName:className];
        [obj refreshInBackgroundWithBlock:^(AVObject * _Nullable object, NSError * _Nullable error) {
            if (error) {
                [subscriber sendNext:error];
            }
            else{
                NSArray *array =  [object objectForKey:@"results"];
                NSArray <CLZGoodsModel *>* modelArray = [CLZGoodsModel mj_objectArrayWithKeyValuesArray:array];
                [subscriber sendNext:modelArray];
            }
            [subscriber sendCompleted];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}


- (RACSignal *)userRegiserWithPhone:(NSString *)phone Password:(NSString *)pwd nickName:(NSString *)nickName{
    
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        AVUser *user = [AVUser user];
        user.mobilePhoneNumber = phone;
        user.password =  pwd;
        user.username = nickName;
        [user setObject:[NSString stringWithFormat:@"touxiang%d",arc4random()%7+1] forKey:@"avatar"];
        [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            // 获取 RESTAPI 返回的错误信息详情（SDK 11.0.0 及以上的版本适用）
            if (succeeded) {
                [subscriber sendNext:@(YES)];
            }
            else{
                [subscriber sendNext:error];
            }
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}
- (RACSignal *)userLoginWithPhone:(NSString *)phone Password:(NSString *)pwd{
    
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [AVUser logInWithMobilePhoneNumberInBackground:phone password:pwd block:^(AVUser * _Nullable user, NSError * _Nullable error) {
            if (error) {
                [subscriber sendNext:error];
            }
            else{
                [CLZStorageManager storeUserPhone:user.mobilePhoneNumber];
                [CLZStorageManager storeUserPassword:pwd];
                
                [CLZUserInfo shareInstance].phone = user.mobilePhoneNumber;
                [CLZUserInfo shareInstance].password = pwd;
                [CLZUserInfo shareInstance].nickName = user.username;
                [CLZUserInfo shareInstance].avatar = [user objectForKey:@"avatar"];
                [CLZUserInfo shareInstance].objectId = user.objectId;
                [CLZUserInfo shareInstance].isLogin = YES;
                [subscriber sendNext:user];
            }
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}
- (RACSignal *)userLogout{
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [AVUser logOut];
        [CLZStorageManager deleteUserPassword];
        [CLZUserInfo shareInstance].isLogin = NO;
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}
- (RACSignal *)getAddressList{
    return  [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        AVQuery *query = [AVQuery queryWithClassName:@"addressList"];
        [query whereKey:@"user_objectId" equalTo:[CLZUserInfo shareInstance].objectId];
        [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            if (error) {
                [subscriber sendNext:error];
            }
            else{
                NSMutableArray *dics = [NSMutableArray array];
                [objects enumerateObjectsUsingBlock:^(AVObject * obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [dics addObject:[obj dictionaryForObject]];
                }];
                NSArray <CLZAddressModel *>* modelArray = [CLZAddressModel mj_objectArrayWithKeyValuesArray:dics];
                [subscriber sendNext:modelArray];
            }
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}
- (NSString *)orderNumber{
    NSDate *now = [NSDate date];
    NSString *timeString = [now stringWithFormat:@"yyyyMMddHHmmss"];
    NSString *randomNumber =[NSString stringWithFormat:@"%d",arc4random_uniform(10000)];
    return [timeString stringByAppendingString:randomNumber];
}
- (RACSignal *)confirmOrder:(NSDictionary *)address goodsList:(NSMutableArray *)list{
    
    return  [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        AVObject *avobj = [AVObject objectWithClassName:@"CLZOrder"];
        [avobj setObject:address forKey:@"address"];
        [avobj setObject:list forKey:@"goodList"];
        [avobj setObject:[CLZUserInfo shareInstance].objectId forKey:@"user_objectId"];
        [avobj setObject:[self orderNumber] forKey:@"orderSerialNumber"];
        [avobj setObject:[NSDate date] forKey:@"confirmTime"];
        [avobj saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (error) {
                [subscriber sendNext:error];
            }
            else{
                [subscriber sendNext:@(YES)];
            }
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
   
}
- (RACSignal *)updateAddress:(CLZAddressModel *)model{
    return  [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        AVObject *avobj = [AVObject objectWithClassName:@"addressList" objectId:model.objectId];
        NSDictionary *dic = [model mj_JSONObject];
        [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if (![key isEqualToString:@"objectId"]) {
                [avobj setObject:obj forKey:key];
            }
        }];
        [avobj setObject:[CLZUserInfo shareInstance].objectId forKey:@"user_objectId"];
        [avobj saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            if (error) {
                [subscriber sendNext:error];
            }
            else{
                [subscriber sendNext:@(YES)];
            }
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}
- (RACSignal *)getMyOrdersWithType:(NSString *)type{
    return  [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        AVQuery *query = [AVQuery queryWithClassName:@"CLZOrder"];
        [query whereKey:@"user_objectId" equalTo:[CLZUserInfo shareInstance].objectId];
        [query whereKey:@"orderType" equalTo:type];
        [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            if (error) {
                [subscriber sendNext:error];
            }
            else{
                NSMutableArray *dics = [NSMutableArray array];
                [objects enumerateObjectsUsingBlock:^(AVObject * obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [dics addObject:[obj dictionaryForObject]];
                }];
                NSArray <CLZOrderModel *>* modelArray = [NSArray modelArrayWithClass:CLZOrderModel.class json:dics];
                [subscriber sendNext:modelArray];
            }
            [subscriber sendCompleted];
        }];
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}
- (RACSignal *)getCLZConfig{
    return  [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        AVObject *obj = [AVObject objectWithClassName:@"CLZConfig"];
        [obj refreshInBackgroundWithBlock:^(AVObject * _Nullable object, NSError * _Nullable error) {
            if (error) {
                [subscriber sendNext:error];
            }
            else{
                NSArray *array =  [object objectForKey:@"results"];
                CLZConfig *config = [CLZConfig modelWithDictionary:array[0]];
                CLZConfig *instance = [CLZConfig shareInstance];
                instance.minePrice = config.minePrice;
                [subscriber sendNext:config];
            }
            [subscriber sendCompleted];
        }];
        
        return [RACDisposable disposableWithBlock:^{
            
        }];
    }];
}
@end
