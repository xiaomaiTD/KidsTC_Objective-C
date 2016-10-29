//
//  ProductDetailInsurance.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailInsuranceItem.h"

typedef enum : NSUInteger {
    ProductDetailFacilitiesTypeWifi = 1,//Wifi
    ProductDetailFacilitiesTypeCarPark = 2,//停车场
    ProductDetailFacilitiesTypeMBRoom = 3,//母婴室
    ProductDetailFacilitiesTypeTeaRoom = 4,//茶水间
    ProductDetailFacilitiesTypeSafetyProtection = 5,//安全防护
    ProductDetailFacilitiesTypeFirstAidkit = 6,//急救包
    ProductDetailFacilitiesTypeAnteRoom = 7,//休息室
    ProductDetailFacilitiesTypeToilet = 8,//卫生间
    ProductDetailFacilitiesTypeDiaperBed = 9//尿布床
} ProductDetailFacilitiesType;

@interface ProductDetailInsurance : NSObject
@property (nonatomic, assign) BOOL refund_part;
@property (nonatomic, assign) BOOL refund_outdate;
@property (nonatomic, assign) BOOL refund_anytime;
@property (nonatomic, assign) BOOL appointment;
@property (nonatomic, strong) NSString *age;
//@property (nonatomic, assign) NSArray *facilitiesType;
//selfDefine
@property (nonatomic, strong) NSArray<ProductDetailInsuranceItem *> *items;
@end
