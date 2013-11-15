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

@interface YGResponse : NSObject
@property (copy, nonatomic) NSString* result;
@property (copy, nonatomic) NSString* message;
@property (strong, nonatomic) id responseObj;
@end

@protocol YGJsonParser <NSObject>
-(YGResponse*) parseFromJson:(id) jsonObj;
@end

@interface YGBaseParse : NSObject<YGJsonParser>

@end

@interface YGOrderDetailParse : YGBaseParse<YGJsonParser>

@end




@interface YGBaseRequest : NSObject
+ (AFHTTPRequestOperation* )requestOrderDetailWithUrl:(NSURL *)url completionBlock:(void (^)(AFHTTPRequestOperation *operation, YGResponse* responseObject))success
                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end
