//
//  SFHFLoginUtil.m
//  KeyChainProj
//
//  Created by y xlong on 12-9-11.
//  Copyright (c) 2012年 水蓝 Tech. All rights reserved.
//

#import "SFHFLoginUtil.h"
#import "SFHFKeychainUtils.h"

#define kSchemePrefix                @"Keychain_"
#define kKeychainServiceNameSuffix   @"_ServiceName"

#define KKeychainUserID              @"com.UserID"
#define KKeychainPassword            @"com.Password"
#define KKeychainExpireTime          @"com.ExpireTime"

#define KExpireTimeInterval          60*2

static SFHFLoginUtil * singlton = nil;
@interface SFHFLoginUtil (Private)

- (void)saveAuthorizeDataToKeychain;
- (void)readAuthorizeDataFromKeychain;
- (void)deleteAuthorizeDataInKeychain;

@end

@implementation SFHFLoginUtil
@synthesize expireTime;
@synthesize account;
@synthesize password;
@synthesize isLoggedIn;
@synthesize isAuthorizeExpired;


#pragma private Methods-
- (NSString *)urlSchemeString
{
    NSDictionary* infoDict =[[NSBundle mainBundle] infoDictionary];
//    NSString* versionNum =[infoDict objectForKey:@"CFBundleVersion"];
    NSString*appName =[infoDict objectForKey:@"CFBundleDisplayName"];
    return [NSString stringWithFormat:@"%@%@", kSchemePrefix,appName];
}

- (void)saveAuthorizeDataToKeychain
{
    NSString *serviceName = [[self urlSchemeString] stringByAppendingString:kKeychainServiceNameSuffix];
    
    [SFHFKeychainUtils storeUsername:KKeychainUserID andPassword:self.account forServiceName:serviceName updateExisting:YES error:nil];
	[SFHFKeychainUtils storeUsername:KKeychainPassword andPassword:self.password forServiceName:serviceName updateExisting:YES error:nil];
	[SFHFKeychainUtils storeUsername:KKeychainExpireTime andPassword:[NSString stringWithFormat:@"%lf", self.expireTime] forServiceName:serviceName updateExisting:YES error:nil];
}

- (void)readAuthorizeDataFromKeychain
{
    NSString *serviceName = [[self urlSchemeString] stringByAppendingString:kKeychainServiceNameSuffix];
    
    self.account = [SFHFKeychainUtils getPasswordForUsername:KKeychainUserID andServiceName:serviceName error:nil];
    self.password = [SFHFKeychainUtils getPasswordForUsername:KKeychainPassword andServiceName:serviceName error:nil];
    self.expireTime = [[SFHFKeychainUtils getPasswordForUsername:KKeychainExpireTime andServiceName:serviceName error:nil] doubleValue];
}

- (void)deleteAuthorizeDataInKeychain
{
    self.account = nil;
    self.password = nil;
    self.expireTime = 0;
    
    NSString *serviceName = [[self urlSchemeString] stringByAppendingString:kKeychainServiceNameSuffix];
    
    [SFHFKeychainUtils deleteItemForUsername:KKeychainUserID andServiceName:serviceName error:nil];
	[SFHFKeychainUtils deleteItemForUsername:KKeychainPassword andServiceName:serviceName error:nil];
	[SFHFKeychainUtils deleteItemForUsername:KKeychainExpireTime andServiceName:serviceName error:nil];
}

#pragma public Methods-
- (id) init
{
    if(self = [super init])
    {
        account = nil;
        password = nil;
        expireTime = KExpireTimeInterval;
    }
    return self;
}

+ (SFHFLoginUtil *) shared
{
    if(!singlton)
    {
        singlton = [[SFHFLoginUtil alloc] init];
    }
    
    return singlton;
}

- (void) saveUserInfoWithAccount:(NSString *) acc password:(NSString *) pwd
{
    assert(nil!=acc);
    assert(nil!=pwd);
    
    self.account = acc;
    self.password = pwd;
    
    [self saveAuthorizeDataToKeychain];
}

//判断是否登录，此时可以在程序中读取账号、密码使用
- (BOOL)isLoggedIn
{
    [self readAuthorizeDataFromKeychain];
    
    return account && password && (expireTime > 0);
}
//判断登录信息是否过时
- (BOOL)isAuthorizeExpired
{
    if ([[NSDate date] timeIntervalSince1970] > expireTime)
    {
        [self deleteAuthorizeDataInKeychain];
        return YES;
    }
    return NO;
}

//删除登录信息
-(void)logOut
{
    self.account = nil;
    self.password = nil;
    self.expireTime = 0.0f;
    [self deleteAuthorizeDataInKeychain];
}

@end
