//
//  NormalProductDetailInsurance.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/4.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NormalProductDetailInsuranceItem.h"

typedef enum : NSUInteger {
    NormalProductDetailFacilitiesTypeWifi = 1,//Wifi
    NormalProductDetailFacilitiesTypeCarPark = 2,//停车场
    NormalProductDetailFacilitiesTypeMBRoom = 3,//母婴室
    NormalProductDetailFacilitiesTypeTeaRoom = 4,//茶水间
    NormalProductDetailFacilitiesTypeSafetyProtection = 5,//安全防护
    NormalProductDetailFacilitiesTypeFirstAidkit = 6,//急救包
    NormalProductDetailFacilitiesTypeAnteRoom = 7,//休息室
    NormalProductDetailFacilitiesTypeToilet = 8,//卫生间
    NormalProductDetailFacilitiesTypeDiaperBed = 9//尿布床
} NormalNormalProductDetailFacilitiesType;

@interface NormalProductDetailInsurance : NSObject
@property (nonatomic, assign) BOOL refund_part;
@property (nonatomic, assign) BOOL refund_outdate;
@property (nonatomic, assign) BOOL refund_anytime;
@property (nonatomic, assign) BOOL appointment;
@property (nonatomic, strong) NSString *age;
@property (nonatomic, assign) NSArray<NSNumber *> *facilitiesType;
//selfDefine
@property (nonatomic, strong) NSArray<NormalProductDetailInsuranceItem *> *items;
@end
