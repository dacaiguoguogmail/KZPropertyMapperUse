//
//  YGResponse.h
//  KZPropertyMapperUse
//
//  Created by sunyanguo on 13-11-17.
//  Copyright (c) 2013年 sunyanguo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YGResponse : NSObject
@property (copy, nonatomic) NSString* result;
@property (copy, nonatomic) NSString* message;
@property (strong, nonatomic) id responseObj;
@end