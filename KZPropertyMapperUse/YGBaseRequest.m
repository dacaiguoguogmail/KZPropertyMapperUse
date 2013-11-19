//
//  YGBaseRequest.m
//  KZPropertyMapperUse
//
//  Created by sunyanguo on 13-11-10.
//  Copyright (c) 2013年 sunyanguo. All rights reserved.
//

#import "YGBaseRequest.h"
#import "YGBaseParse.h"


#define YG_REQUEST_VALIDATION(responseObject,url,op,paserClass) {\
    NSURLRequest *request = [NSURLRequest requestWithURL:url];\
    op = [[AFHTTPRequestOperation alloc] initWithRequest:request];\
    op.responseSerializer = [AFJSONResponseSerializer serializer];\
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {\
        paserClass *paser = [[paserClass alloc] init];\
        YGResponse *response = [paser parseFromJson:responseObject];\
        if ([response.result isEqualToString:YG_ERROR_CODE]) {\
            NSError* error=[NSError errorWithDomain:YG_SERVER_ERROR_DOMAIN code:YG_ERROR_CODE_INVALID_RESPONSE_EXCEPTION userInfo:@{@"message": [responseObject objectForKey:@"message"]}];\
            failure(operation, error);\
        }\
        success(operation, response);\
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {\
        failure(operation, error);\
    }];\
}




@implementation YGBaseRequest

+ (AFHTTPRequestOperation* )requestOrderListWithUrl:(NSURL *)url completionBlock:(void (^)(AFHTTPRequestOperation *operation, YGResponse* responseObject))success
                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] init];
    YG_REQUEST_VALIDATION(responseObject,url,op,YGOrderListParse);
    return op;
}


@end
