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

/*! target=dic[key];  会对dic 进行类型检测  */
#define YKGDS_DIC_OBJ(target,dic,key) {\
if([dic isKindOfClass:[NSDictionary class]]){\
target=[dic objectForKey:key];\
}else{\
assert(NO);\
}\
if(target==nil){\
}\
}

/*! target=dic[key];  会对dic 进行类型检测，会保证 target 是字符串类型  */
#define YKGDS_DIC_OBJ_STR(target,dic,key) {\
id aaaobj=nil; \
YKGDS_DIC_OBJ(aaaobj,dic,key); \
if([aaaobj isKindOfClass:[NSString class]]){\
target=aaaobj;  \
}else{\
target=@"";\
} \
}


@implementation YGBaseParse

-(YGResponse*) parseFromJson:(id) jsonObj{
    YGResponse *base = [[YGResponse alloc] init];
    YKGDS_DIC_OBJ_STR(base.message, jsonObj, @"message");
    YKGDS_DIC_OBJ_STR(base.message, jsonObj, @"code");
    YKGDS_DIC_OBJ_STR(base.message, jsonObj, @"data");
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
    YKGDS_DIC_OBJ_STR(tempDetail.arrivalDate, res, @"arrivalDate");
    YKGDS_DIC_OBJ_STR(tempDetail.cancelTime, res, @"cancelTime");
    YKGDS_DIC_OBJ_STR(tempDetail.confirmationType, res, @"confirmationType");
    YKGDS_DIC_OBJ_STR(tempDetail.hotelId, res, @"hotelId");
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


@implementation YGCityParse

-(YGResponse*) parseFromJson:(id) jsonObj{
    return nil;
}

- (void)paserResponseObjTo:(YGCity **)dic use:(NSDictionary*)res{
    YGCity *temp = [[YGCity alloc] init];
    YKGDS_DIC_OBJ_STR(temp.cityId, res, @"id");
    YKGDS_DIC_OBJ_STR(temp.name, res, @"name");
    YKGDS_DIC_OBJ_STR(temp.pinyin, res, @"pinyin");
    NSNumber *isHot = nil;
    YKGDS_DIC_OBJ(isHot, res, @"isHot");
    [temp setHot:isHot.boolValue];
    *dic = temp;
}
@end@implementation YGCityListParse

-(YGResponse*) parseFromJson:(id) jsonObj{
    YGResponse *base =  [super parseFromJson:jsonObj];
    YGCityList *tempReaponseObj = nil;
    if ([base.result isEqualToString:YG_SUCCESS_CODE]&&[base.responseObj isKindOfClass:[NSDictionary class]]&&[base.responseObj count]>0) {
        [self paserResponseObjTo:&tempReaponseObj use:base.responseObj];
    }
    base.responseObj = tempReaponseObj;
    return base;
}

- (void)paserResponseObjTo:(YGCityList **)dic use:(NSDictionary*)res{
    NSMutableArray *mutArray = [[NSMutableArray alloc] init];
    NSArray *tempArray = [res objectForKey:@"YGCityList"];
    for (id obj in tempArray) {
        YGCityParse *cityParse = [[YGCityParse alloc] init];
        YGCity *tempDetail = nil;
        [cityParse paserResponseObjTo:&tempDetail use:obj];
        [mutArray addObject:tempDetail];
    }
    *dic = tempArray;
}
@end
