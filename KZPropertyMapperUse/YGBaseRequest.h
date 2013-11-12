//
//  YGBaseRequest.h
//  KZPropertyMapperUse
//
//  Created by sunyanguo on 13-11-10.
//  Copyright (c) 2013年 sunyanguo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "YGBaseModel.h"
@interface YGBaseRequest : NSObject
+ (AFHTTPRequestOperation* )requestOrderDetailWithUrl:(NSURL *)url completionBlock:(void (^)(AFHTTPRequestOperation *operation,YGOrderDetailModel* responseObject))success
                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end
