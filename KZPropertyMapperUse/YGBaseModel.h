//
//  YGBaseModel.h
//  KZPropertyMapperUse
//
//  Created by sunyanguo on 13-11-10.
//  Copyright (c) 2013年 sunyanguo. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface YGBaseModel : NSObject<NSCopying,NSCoding>
- (void)setAttribute:(id)obj forKey:(id <NSCopying>)key;
- (id)attributeForkey:(id<NSCopying>)key;
-(BOOL)writeToFile:(NSString*) apath;
+(instancetype)entityFromFile:(NSString*) apath;
@end

@interface YGOrderDetail : YGBaseModel
- (void)setArrivalDate:(NSString*)arrivalDate;
- (NSString *)arrivalDate;
- (void)setCancelTime:(NSString*)cancelTime;
- (NSString *)cancelTime;
- (void)setConfirmationType:(NSString *)confirmationType;
- (NSString *)confirmationType;
- (void)setHotelId:(NSString *)hotelId;
- (NSString *)hotelId;

@end

typedef NSArray YGOrderDetailResults;

@interface YGOrderList : YGBaseModel
- (BOOL)isHasNext;
- (void)setHasNext:(BOOL)hasNext;
- (YGOrderDetailResults*)orderDetailResults;
- (void)setOrderDetailResults:(YGOrderDetailResults *)orders;
@end

typedef NSArray YGCityList;


@interface YGCity : YGBaseModel
- (void)setCityId:(NSString *)cityId;
- (NSString *)cityId;

- (void)setName:(NSString *)name;
- (NSString *)name;

- (BOOL)isHot;
- (void)setHot:(BOOL)hot;

- (void)setPinyin:(NSString *)pinyin;
- (NSString *)pinyin;

@end




