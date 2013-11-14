//
//  YGBaseRequest.m
//  KZPropertyMapperUse
//
//  Created by sunyanguo on 13-11-10.
//  Copyright (c) 2013年 sunyanguo. All rights reserved.
//

#import "YGBaseRequest.h"
#define YG_REQUEST_LOG 1
#define YG_ERROR_CODE -1
#define YG_SUCCESS_CODE 1
#define YG_SERVER_ERROR_DOMAIN @"com.datasource.server"
#define YG_ERROR_CODE_INVALID_RESPONSE_EXCEPTION 1001

#if(YG_REQUEST_LOG)
    #define NSLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
    #define NSLog(format, ...)
#endif

#define YG_REQUEST(responseObject) {\
NSLog(@"JSON: %@", responseObject);\
    if([[responseObject objectForKey:@"code"] integerValue]== YG_ERROR_CODE){\
        NSError* error=[NSError errorWithDomain:YG_SERVER_ERROR_DOMAIN code:YG_ERROR_CODE_INVALID_RESPONSE_EXCEPTION userInfo:@{@"errorMessage": [responseObject objectForKey:@"message"]}];\
        failure(operation, error);\
    }\
}

@implementation YGBaseRequest

+ (AFHTTPRequestOperation* )requestOrderDetailWithUrl:(NSURL *)url completionBlock:(void (^)(AFHTTPRequestOperation *operation, YGOrderDetailModel* responseObject))success
                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        YG_REQUEST(responseObject);
        YGOrderDetailModel *orderDetail = [[YGOrderDetailModel alloc] init];
        orderDetail.hasNext = [[responseObject objectForKey:@"hasNext"] boolValue];
        orderDetail.message = [responseObject objectForKey:@"message"];
        success(operation, orderDetail);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation, error);
        NSLog(@"Error: %@", error);
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
    return op;
}


@end
