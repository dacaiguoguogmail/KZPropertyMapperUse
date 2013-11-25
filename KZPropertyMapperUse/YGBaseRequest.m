//
//  YGBaseRequest.m
//  KZPropertyMapperUse
//
//  Created by sunyanguo on 13-11-10.
//  Copyright (c) 2013年 sunyanguo. All rights reserved.
//

#import "YGBaseRequest.h"
#import "YGBaseParse.h"
#import "SFHFKeychainUtils.h"
#import "sys/utsname.h"

@import CoreTelephony;
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


@interface YGBaseRequest ()
@property (nonatomic, retain) AFHTTPRequestOperationManager *requestManager;
@end

@implementation YGBaseRequest
- (id)init{
    self = [super init];
    if (self) {
        self.requestManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:REQUEST_URL]];
    }
    return self;
}

- (void)cancelAllRequest{
    NSOperationQueue *queue =  [self.requestManager operationQueue];
    for (AFHTTPRequestOperation *op in [queue operations]) {
        [op cancel];
    }
}

- (void)dealloc{
    [self cancelAllRequest];
}

+ (NSString *)stringWithUUID {
    NSString *uuid = [SFHFKeychainUtils getPasswordForUsername:@"lvmama_iphone_uuid" andServiceName:@"com.Lvmama.Lvmama" error:nil];
    if ([uuid length] > 0) {
        return uuid;
    } else {
        CFUUIDRef puuid = CFUUIDCreate(nil);
        CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
        NSString *result = (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
        result = [[result stringByAppendingString:@"-uuid"]lowercaseString];
        CFRelease(puuid);
        CFRelease(uuidString);
        [SFHFKeychainUtils storeUsername:@"lvmama_iphone_uuid" andPassword:result forServiceName:@"com.Lvmama.Lvmama" updateExisting:YES error:nil];
        return result;
    }
}

+ (NSString *)getMobileCountryNetworkCode {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = info.subscriberCellularProvider;
    NSString *ret = [NSString stringWithFormat:@"%@%@", carrier.mobileCountryCode?carrier.mobileCountryCode:@"", carrier.mobileNetworkCode?carrier.mobileNetworkCode:@""];
    return ret.length>0?ret:@"WIFI";
}

+ (NSString*)deviceType
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    return deviceString;
}

+ (NSString *)getUserAgent {
    return [NSString stringWithFormat:@"%@_%@ %@ (%@; %@ %@; %@ %@)", FIRST_CHANNEL, SECOND_CHANNEL, CFBundleVersion, [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemName], [[UIDevice currentDevice] systemVersion], [[YGBaseRequest getMobileCountryNetworkCode] length] == 0?@"WIFI":[YGBaseRequest getMobileCountryNetworkCode],[YGBaseRequest deviceType]];
}


+ (NSString *)getRequestHeader {
    return [NSString stringWithFormat:@"udid=%@&lvsessionid=%@&firstChannel=%@&secondChannel=%@&lvversion=%@&osVersion=%@&deviceName=%@&netWorkType=%@&format=json",
             [YGBaseRequest stringWithUUID],
             [[NSUserDefaults  standardUserDefaults] stringForKey:@"sessionId"],
             FIRST_CHANNEL,
             SECOND_CHANNEL,
             CFBundleVersion,
             [[UIDevice currentDevice] systemVersion],
             [YGBaseRequest deviceType],
             [YGBaseRequest getMobileCountryNetworkCode]];
}

+ (NSString *)urlStringByMethod:(NSString *)methodName{
    
    NSString* urlString = [NSString stringWithFormat:@"/clutter/router/rest.do?method=api.com.%@&%@", methodName, [YGBaseRequest getRequestHeader]];
    return [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (id)requestHotelCityListWithCompletionBlock:(void (^)(YGResponse* responseObject))success failure:(void (^)(NSError *error))failure checkVersion:(BOOL)isCheckVersion{
    NSDictionary *dic = nil;
    isCheckVersion?dic = @{ @"checkVersion": @"true" }:0;
    
    return [self.requestManager GET:[YGBaseRequest urlStringByMethod:@"hotel.getCities"] parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@\nsuccess:\n%@",[operation.request.URL absoluteString],operation.responseString);
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@\failure:\n%@",[operation.request.URL absoluteString],operation.responseString);
        failure(error);
    }];
}

- (id)requestOrderListWithParameters:(NSDictionary *)param completionBlock:(void (^)(YGResponse* responseObject))success failure:(void (^)(NSError *error))failure{
    return [self.requestManager POST:@"" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}


- (AFHTTPRequestOperation* )requestOrderListWithUrl:(NSURL *)url completionBlock:(void (^)(AFHTTPRequestOperation *operation, YGResponse* responseObject))success
                                              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    [self.requestManager POST:@"" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] init];
    YG_REQUEST_VALIDATION(responseObject,url,op,YGOrderListParse);
    return op;
}

#include <ifaddrs.h>
#include <arpa/inet.h>

+ (NSString *)getIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0)
    {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL)
        {
            if(temp_addr->ifa_addr->sa_family == AF_INET)
            {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en1"])
                {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    return address;
}
@end
