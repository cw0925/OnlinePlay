//
//  AFNetHelper.h
//  RLAFNetHelper
//
//  Created by RichyLeo on 15/12/22.
//  Copyright © 2015年 RL. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
    对AFNetWorking的二次封装
 */

// 重定义：给复杂的数据类型起别名
// SuccessBlock  和  void (^) (id responseObject) 等价
typedef void (^SuccessBlock) (id responseObject);
typedef void (^FailureBlock) (NSError *error);

@interface AFNetHelper : NSObject

+(void)GET:(NSString *)url parameters:(id)param success:(SuccessBlock)success failure:(FailureBlock)failure;

+(void)POST:(NSString *)url parameters:(id)param success:(SuccessBlock)success failure:(FailureBlock)failure;

@end
