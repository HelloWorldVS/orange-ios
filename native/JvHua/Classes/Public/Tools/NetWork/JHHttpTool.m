//
//  JHHttpTool.m
//  JvHua
//
//  Created by 乔耐 on 15/11/24.
//  Copyright © 2015年 juzi. All rights reserved.
//

#import "JHHttpTool.h"

@implementation JHHttpTool
+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.发送一个GET请求
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) { // 请求成功后会调用
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) { // 请求失败后会调用
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.发送一个POST请求
    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) { // 请求成功后会调用
        // 告诉外界(外面):我们请求成功了
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) { // 请求失败后会调用
        // 告诉外界(外面):我们请求失败了
        if (failure) {
            failure(error);
        }
    }];
}



+ (void)putWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr PUT:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}


@end
