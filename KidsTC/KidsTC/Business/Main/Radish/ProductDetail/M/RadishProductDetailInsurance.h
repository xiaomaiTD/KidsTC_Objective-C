//
//  RadishProductDetailInsurance.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishProductDetailInsuranceItem.h"

typedef enum : NSUInteger {
    RadishProductDetailFacilitiesTypeWifi = 1,//Wifi
    RadishProductDetailFacilitiesTypeCarPark = 2,//停车场
    RadishProductDetailFacilitiesTypeMBRoom = 3,//母婴室
    RadishProductDetailFacilitiesTypeTeaRoom = 4,//茶水间
    RadishProductDetailFacilitiesTypeSafetyProtection = 5,//安全防护
    RadishProductDetailFacilitiesTypeFirstAidkit = 6,//急救包
    RadishProductDetailFacilitiesTypeAnteRoom = 7,//休息室
    RadishProductDetailFacilitiesTypeToilet = 8,//卫生间
    RadishProductDetailFacilitiesTypeDiaperBed = 9//尿布床
} RadishProductDetailFacilitiesType;

@interface RadishProductDetailInsurance : NSObject
@property (nonatomic, assign) BOOL refund_part;
@property (nonatomic, assign) BOOL refund_outdate;
@property (nonatomic, assign) BOOL refund_anytime;
@property (nonatomic, assign) BOOL appointment;
@property (nonatomic, strong) NSString *age;
//@property (nonatomic, assign) NSArray *facilitiesType;
//selfDefine
@property (nonatomic, strong) NSArray<RadishProductDetailInsuranceItem *> *items;
@end
