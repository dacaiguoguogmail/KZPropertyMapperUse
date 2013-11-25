//
//  SFHFLoginUtil.h
//  KeyChainProj
//
//  Created by y xlong on 12-9-11.
//  Copyright (c) 2012年 水蓝 Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>

@interface SFHFLoginUtil : NSObject{
    
    NSTimeInterval  expireTime;
    
    NSString        * account;
    NSString        * password;
    BOOL            isLoggedIn;
    BOOL            isAuthorizeExpired;
    
}

@property (nonatomic, assign) NSTimeInterval  expireTime;
@property (nonatomic, copy) NSString * account;
@property (nonatomic, copy) NSString * password;

@property (nonatomic, readonly) BOOL isLoggedIn;
@property (nonatomic, readonly) BOOL isAuthorizeExpired;

- (void) saveUserInfoWithAccount:(NSString *) acc password:(NSString *) pwd;
+ (id) shared;
- (void) logOut;
@end
