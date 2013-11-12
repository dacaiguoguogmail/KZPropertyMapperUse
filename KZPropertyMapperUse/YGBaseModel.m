//
//  YGBaseModel.m
//  KZPropertyMapperUse
//
//  Created by sunyanguo on 13-11-10.
//  Copyright (c) 2013年 sunyanguo. All rights reserved.
//

#import "YGBaseModel.h"

@interface YGBaseModel ()
@property (nonatomic, strong) NSMutableDictionary *propertyDic;
@end

@implementation YGBaseModel

- (id)init{
    self = [super init];
    if (self) {
        self.propertyDic = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone{
    YGBaseModel *copy = [[self class] allocWithZone:zone];
    copy.propertyDic = [self.propertyDic copyWithZone:zone];
    return copy;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder {
    self = [self init];
    if (!self) {
        return nil;
    }
    
    self.propertyDic = [decoder decodeObjectForKey:NSStringFromSelector(@selector(propertyDic))];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.propertyDic forKey:NSStringFromSelector(@selector(propertyDic))];
}


@end

@implementation YGOrderDetailModel

- (BOOL)isHasNext{
    return [[self.propertyDic objectForKey:@"hasNext"] boolValue];
}

- (void)setHasNext:(BOOL)hasNext{
    [self.propertyDic setObject:[NSNumber numberWithBool:hasNext] forKey:@"hasNext"];
}

- (NSString *)message{
    return [self.propertyDic objectForKey:@"message"];
}
- (void)setMessage:(NSString *)message{
    [self.propertyDic setObject:message forKey:@"message"];
}

@end





