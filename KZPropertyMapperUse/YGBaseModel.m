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
#pragma mark - writeToFile
-(BOOL) writeToFile:(NSString*) apath{
    assert(apath!=nil);
    return [NSKeyedArchiver archiveRootObject:self toFile:apath];
}
+(instancetype) entityFromFile:(NSString*) apath{
    assert(apath!=nil);
    return [NSKeyedUnarchiver unarchiveObjectWithFile:apath];

}
@end

#define YG_GETDEFINE(code)\
-(id) code {\
return [self attributeForkey:[@#code lowercaseString]];\
}

#define YG_SETDEFINE(code)\
- (void)set##code:(NSString *)a##code{\
[self setAttribute:a##code forKey:[@#code lowercaseString]];\
}

#define YG_GETDEFINE_BOOL(code)\
-(BOOL) code {\
return [[self attributeForkey:[@#code lowercaseString]] boolValue];\
}

#define YG_GETDEFINE_BOOL_IS(code)\
-(BOOL) is##code {\
return [[self attributeForkey:[@#code lowercaseString]] boolValue];\
}

#define YG_SETDEFINE_BOOL(code)\
- (void)set##code:(BOOL)a##code{\
[self setAttribute:[NSNumber numberWithBool:a##code] forKey:[@#code lowercaseString]];\
}

@implementation YGOrderDetail
YG_GETDEFINE(arrivalDate)
YG_SETDEFINE(ArrivalDate)

YG_GETDEFINE(cancelTime);
YG_SETDEFINE(CancelTime);

YG_GETDEFINE(confirmationType);
YG_SETDEFINE(ConfirmationType);

YG_GETDEFINE(hotelId);
YG_SETDEFINE(HotelId);

@end

@implementation YGOrderList

YG_GETDEFINE(orderDetailResults);
YG_SETDEFINE(OrderDetailResults);

YG_GETDEFINE_BOOL_IS(HasNext);
YG_SETDEFINE_BOOL(HasNext);


@end





