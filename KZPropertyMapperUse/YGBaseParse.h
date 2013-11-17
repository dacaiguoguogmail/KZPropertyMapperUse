//
//  YGBaseParse.h
//  KZPropertyMapperUse
//
//  Created by sunyanguo on 13-11-17.
//  Copyright (c) 2013年 sunyanguo. All rights reserved.
//

#import <Foundation/Foundation.h>
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




@class YGResponse;
@protocol YGJsonParser <NSObject>
-(YGResponse*) parseFromJson:(id) jsonObj;
@end

@interface YGBaseParse : NSObject<YGJsonParser>

@end

@interface YGOrderDetailParse : YGBaseParse<YGJsonParser>

@end

@interface YGOrderListParse : YGBaseParse<YGJsonParser>

@end
