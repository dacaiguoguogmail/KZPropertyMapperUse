//
//  YGBaseModel.h
//  KZPropertyMapperUse
//
//  Created by sunyanguo on 13-11-10.
//  Copyright (c) 2013年 sunyanguo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KZPropertyMapper.h"
@interface YGBaseModel : NSObject<NSCopying,NSCoding>

@end

@interface YGOrderDetailModel : YGBaseModel
- (BOOL)isHasNext;
- (void)setHasNext:(BOOL)hasNext;
- (NSString *)message;
- (void)setMessage:(NSString *)message;

@end