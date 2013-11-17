//
//  YGBaseModel.m
//  KZPropertyMapperUse
//
//  Created by sunyanguo on 13-11-10.
//  Copyright (c) 2013年 sunyanguo. All rights reserved.
//

#import "YGBaseModel.h"
#define GETDEFINE(code)\
-(NSString *) code {\
    return [self attributeForKey:@#code];\
}
#define SETDEFINE(code)\
- (void)set##code:(NSString *)a##code{\
    [self setAttribute:a##code forKey:@#code];\
}



@interface YGBaseModel ()
@property (nonatomic, strong) NSMutableDictionary *propertyDic;

@end

@implementation YGBaseModel
#pragma mark - set&get
- (void)setAttribute:(id)obj forKey:(id <NSCopying>)key{
    [self.propertyDic setObject:obj forKey:key];
}

- (id)attributeForkey:(id<NSCopying>)key{
    return [self.propertyDic objectForKey:key];
}

#pragma mark - init
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

@implementation YGOrderDetail

- (NSString *)arrivalDate{
    return [self attributeForkey:@"arrivalDate"];
}
- (void)setArrivalDate:(NSString *)arrivalDate{
    [self setAttribute:arrivalDate forKey:@"arrivalDate"];
}
- (NSString *)cancelTime{
    return [self attributeForkey:@"cancelTime"];
}
- (void)setCancelTime:(NSString *)cancelTime{
    [self setAttribute:cancelTime forKey:@"cancelTime"];
}
- (NSString *)confirmationType{
    return [self attributeForkey:@"confirmationType"];
}
- (void)setConfirmationType:(NSString *)confirmationType{
    [self setAttribute:confirmationType forKey:@"confirmationType"];
}
- (NSString *)hotelId{
    return [self attributeForkey:@"hotelId"];
}
- (void)setHotelId:(NSString *)hotelId{
    [self setAttribute:hotelId forKey:@"hotelId"];
}
@end

@implementation YGOrderList

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

- (void)setOrderDetailResults:(YGOrderDetailResults *)orders{
    [self.propertyDic setObject:orders forKey:@"orderDetailResults"];
}

- (YGOrderDetailResults*)orderDetailResults{
    return [self.propertyDic objectForKey:@"orderDetailResults"];
}

- (void)setHotelId:(NSString *)hotelId{
    [self setAttribute:hotelId forKey:@"hotelId"];
}
- (NSString *)hotelId{
    return [self attributeForkey:@"hotelId"];
}

@end





