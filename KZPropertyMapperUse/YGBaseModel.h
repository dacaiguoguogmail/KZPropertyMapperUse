//
//  YGBaseModel.h
//  KZPropertyMapperUse
//
//  Created by sunyanguo on 13-11-10.
//  Copyright (c) 2013年 sunyanguo. All rights reserved.
//

/*
 {
 "arrivalDate": "2013-11-05",
 "cancelTime": "2013-11-06",
 "confirmationType": "NoNeed",
 "contact": {
 "email": "",
 "fax": "",
 "gender": "Female",
 "mobile": "13322220013",
 "name": "fdsf4",
 "phone": ""
 },
 "creditCard": null,
 "currencyCode": "RMB",
 "customerType": "All",
 "departureDate": "2013-11-06",
 "earliestArrivalTime": "2013-11-05",
 "elongCardNo": "2000000001973271329",
 "extendInfo": {
 "int1": 0,
 "int2": 0,
 "int3": 0,
 "string1": "",
 "string2": "",
 "string3": ""
 },
 "guaranteeRule": null,
 "hasInvoice": false,
 "hotelId": "40101628",
 "invoice": null,
 "latestArrivalTime": "2013-11-05",
 "nightlyRates": [
 {
 "addBed": 0,
 "cost": -1,
 "date": "2013-11-05",
 "member": 450,
 "status": false
 }
 ],
 "noteToElong": "",
 "noteToHotel": "*客人手机号：13322220013*",
 "numberOfCustomers": 2,
 "numberOfRooms": 2,
 "orderId": 71180376,
 "orderRooms": [
 {
 "customers": [
 {
 "confirmationNumber": "",
 "email": "",
 "fax": "",
 "gender": "Female",
 "mobile": "",
 "name": "add",
 "nationality": "中国",
 "phone": ""
 }
 ]
 },
 {
 "customers": [
 {
 "confirmationNumber": "",
 "email": "",
 "fax": "",
 "gender": "Female",
 "mobile": "",
 "name": "bb",
 "nationality": "中国",
 "phone": ""
 }
 ]
 }
 ],
 "paymentType": "前台支付",
 "penaltyCurrencyCode": "RMB",
 "penaltyToCustomer": 0,
 "prepayRule": null,
 "ratePlanId": 21875,
 "roomTypeId": "1017",
 "status": "删除",
 "totalPrice": 900,
 "valueAdds": [
 "附加服务：单加1份早餐 68 元",
 "附加服务：包含服务费;"
 ],
 "name": "北京香江戴斯酒店",
 "address": "北京市东城区南河沿大街南湾子胡同1号（毗邻王府井金街西侧，步行可至天安门广场）",
 "phone": "010-65127788",
 "placeType": "经济酒店",
 "canCancel": true
 },

 
 */

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