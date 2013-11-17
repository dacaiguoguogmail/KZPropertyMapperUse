//
//  YGBaseParse.m
//  KZPropertyMapperUse
//
//  Created by sunyanguo on 13-11-17.
//  Copyright (c) 2013年 sunyanguo. All rights reserved.
//

#import "YGBaseParse.h"
#import "YGBaseModel.h"
#import "YGResponse.h"

@implementation YGBaseParse

-(YGResponse*) parseFromJson:(id) jsonObj{
    YGResponse *base = [[YGResponse alloc] init];
    base.message = [jsonObj objectForKey:@"message"];
    base.result = [jsonObj objectForKey:@"code"];
    base.responseObj = [jsonObj objectForKey:@"data"];
    return base;
}

@end

@implementation YGOrderDetailParse

-(YGResponse*) parseFromJson:(id) jsonObj{
    YGResponse *base =  [super parseFromJson:jsonObj];
    YGOrderDetail *tempReaponseObj = nil;
    if ([base.result isEqualToString:YG_SUCCESS_CODE]&&[base.responseObj isKindOfClass:[NSDictionary class]]&&[base.responseObj count]>0) {
        [self paserResponseObjTo:&tempReaponseObj useDic:base.responseObj];
    }
    base.responseObj = tempReaponseObj;
    return base;
}

- (void)paserResponseObjTo:(YGOrderDetail **)dic useDic:(NSDictionary*)res{
    YGOrderDetail *tempDetail = [YGOrderDetail new];
    tempDetail.arrivalDate = [res objectForKey:@"arrivalDate"];
    tempDetail.cancelTime = [res objectForKey:@"cancelTime"];
    tempDetail.confirmationType = [res objectForKey:@"confirmationType"];
    tempDetail.hotelId = [res objectForKey:@"hotelId"];
    *dic = tempDetail;
}
@end

@implementation YGOrderListParse

-(YGResponse*) parseFromJson:(id) jsonObj{
    YGResponse *base =  [super parseFromJson:jsonObj];
    YGOrderList *tempReaponseObj = nil;
    if ([base.result isEqualToString:YG_SUCCESS_CODE]&&[base.responseObj isKindOfClass:[NSDictionary class]]&&[base.responseObj count]>0) {
        [self paserResponseObjTo:&tempReaponseObj use:base.responseObj];
    }
    base.responseObj = tempReaponseObj;
    return base;
}

- (void)paserResponseObjTo:(YGOrderList **)dic use:(NSDictionary*)res{
    YGOrderList *temp = [[YGOrderList alloc] init];
    NSMutableArray *mutArray = [[NSMutableArray alloc] init];
    NSArray *tempArray = [res objectForKey:@"orderDetailResults"];
    for (id obj in tempArray) {
        YGOrderDetailParse *orderDetail = [[YGOrderDetailParse alloc] init];
        YGOrderDetail *tempDetail = nil;
        [orderDetail paserResponseObjTo:&tempDetail useDic:obj];
        [mutArray addObject:tempDetail];
    }
    temp.orderDetailResults = mutArray;
    *dic = temp;
}
@end

