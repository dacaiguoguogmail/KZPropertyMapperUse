//
//  YGBaseRequest.m
//  KZPropertyMapperUse
//
//  Created by sunyanguo on 13-11-10.
//  Copyright (c) 2013年 sunyanguo. All rights reserved.
//

#import "YGBaseRequest.h"
#define YG_REQUEST_LOG 1
#define YG_ERROR_CODE @"-1"
#define YG_SUCCESS_CODE @"1"
#define YG_SERVER_ERROR_DOMAIN @"com.datasource.server"
#define YG_ERROR_CODE_INVALID_RESPONSE_EXCEPTION 1001

#if(YG_REQUEST_LOG)
    #define NSLog(format, ...) NSLog(format, ## __VA_ARGS__)
#else
    #define NSLog(format, ...)
#endif

#define YG_REQUEST(responseObject) {\
    NSLog(@"JSON: %@", responseObject);\
    if([[responseObject objectForKey:@"code"] isEqualToString:YG_ERROR_CODE]){\
        NSError* error=[NSError errorWithDomain:YG_SERVER_ERROR_DOMAIN code:YG_ERROR_CODE_INVALID_RESPONSE_EXCEPTION userInfo:@{@"errorMessage": [responseObject objectForKey:@"message"]}];\
        failure(operation, error);\
    }\
}
@implementation YGResponse

@end

@implementation YGBaseParse

-(YGResponse*) parseFromJson:(id) jsonObj{
    YGResponse *base = [[YGResponse alloc] init];
    base.message = [jsonObj objectForKey:@"message"];
    base.result = [jsonObj objectForKey:@"code"];
    base.responseObj = [jsonObj objectForKey:@"data"];
    return base;
}

@end

@implementation YGOrderDetailParse

-(YGResponse*) parseFromJson:(id) jsonObj{
   YGResponse *base =  [super parseFromJson:jsonObj];
    NSDictionary *tempReaponseObj = nil;
    if ([base.result isEqualToString:YG_SUCCESS_CODE]&&[base.responseObj isKindOfClass:[NSDictionary class]]&&[base.responseObj count]>0) {
        [self paserResponseObjTo:&tempReaponseObj];
    }
    base.responseObj = tempReaponseObj;
    return base;
}

- (void)paserResponseObjTo:(NSDictionary **)dic{
    *dic = @{@"a": @"1"};
}
@end


@implementation YGBaseRequest

+ (AFHTTPRequestOperation* )requestOrderDetailWithUrl:(NSURL *)url completionBlock:(void (^)(AFHTTPRequestOperation *operation, YGResponse* responseObject))success
                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        YG_REQUEST(responseObject);
        YGOrderDetailParse *paser = [[YGOrderDetailParse alloc] init];
        YGResponse *response = [paser parseFromJson:responseObject];
        success(operation, response);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation, error);
        NSLog(@"Error: %@", error);
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
    return op;
}


@end
