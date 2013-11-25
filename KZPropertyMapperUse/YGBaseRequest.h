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
#import "YGResponse.h"
//http://192.168.0.94/clutter/router/rest.do?method=api.com.hotel.getCities
#define REQUEST_URL @"http://192.168.0.94"
//#define REQUEST_URL @"http://192.168.0.243"
//#define REQUEST_URL @"http://api3g.lvmama.com"
#define LOGIN_URL @"http://login.lvmama.com"
#define FIRST_CHANNEL @"IPHONE"
#define SECOND_CHANNEL @"APPSTORE"
#define CFBundleVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]

@protocol YGRequestMethodModule

- (id)requestHotelCityListWithCompletionBlock:(void (^)(YGResponse* responseObject))success failure:(void (^)(NSError *error))failure checkVersion:(BOOL)isCheckVersion;

- (id)requestOrderListWithParameters:(NSDictionary *)param completionBlock:(void (^)(YGResponse* responseObject))success failure:(void (^)(NSError *error))failure;

- (void)cancelAllRequest;

@end

@interface YGBaseRequest : NSObject<YGRequestMethodModule>
@end
