//
//  AFNetHelper.m
//  RLAFNetHelper
//
//  Created by RichyLeo on 15/12/22.
//  Copyright © 2015年 RL. All rights reserved.
//

#import "AFNetHelper.h"
#import "AFNetworking.h"

@implementation AFNetHelper

+(void)GET:(NSString *)url parameters:(id)param success:(SuccessBlock)success failure:(FailureBlock)failure
{
    // void (^success) (id responseObject)
    // void (^failure) (NSError *error)
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html", @"text/json", @"text/javascript",@"text/plain",@"image/gif", nil];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)POST:(NSString *)url parameters:(id)param success:(SuccessBlock)success failure:(FailureBlock)failure
{
    // void (^success) (id responseObject)
    // void (^failure) (NSError *error)
    
   AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //[manager.requestSerializer setValue:@"text/html" forHTTPHeaderField:@"Content-Type"];
    [manager POST:url parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
