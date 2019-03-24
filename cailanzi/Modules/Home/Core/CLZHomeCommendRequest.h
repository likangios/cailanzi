//
//  CLZHomeCommendRequest.h
//  cailanzi
//
//  Created by luck on 2019/3/19.
//  Copyright © 2019年 ting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLZHomeCommendRequest : NSObject
+(RACSignal *)requestHomeCommendDataWithPage:(NSInteger)page;
@end
