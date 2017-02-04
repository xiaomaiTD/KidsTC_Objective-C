//
//  RadishProductDetailInsurance.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishProductDetailInsurance.h"
#import "NSString+Category.h"
@implementation RadishProductDetailInsurance
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    NSArray *ary = dic[@"facilitiesType"];
    [self setupitems:ary];
    
    return YES;
}
- (void)setupitems:(NSArray *)ary {
    
    NSMutableArray<RadishProductDetailInsuranceItem *> *items = [NSMutableArray array];
    
    if (_refund_anytime) {
        RadishProductDetailInsuranceItem *item = [RadishProductDetailInsuranceItem item:@"Prodetail_buyNotice_01" title:@"随时退"];
        if(item) [items addObject:item];
    }
    if (_refund_outdate) {
        RadishProductDetailInsuranceItem *item = [RadishProductDetailInsuranceItem item:@"Prodetail_buyNotice_06" title:@"过期退"];
        if(item) [items addObject:item];
    }
    if (_refund_part) {
        RadishProductDetailInsuranceItem *item = [RadishProductDetailInsuranceItem item:@"Prodetail_buyNotice_07" title:@"部分退"];
        if(item) [items addObject:item];
    }
    if (_appointment) {
        RadishProductDetailInsuranceItem *item = [RadishProductDetailInsuranceItem item:@"Prodetail_buyNotice_02" title:@"需要预约"];
        if(item) [items addObject:item];
    }
    {
        NSString *title = [_age isNotNull]?_age:@"无年龄限制";
        RadishProductDetailInsuranceItem *item = [RadishProductDetailInsuranceItem item:@"Prodetail_buyNotice_03" title:title];
        if(item) [items addObject:item];
    }
    
    if (ary && ![ary isKindOfClass:[NSNull class]]) {
        [ary enumerateObjectsUsingBlock:^(NSNumber  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            RadishProductDetailFacilitiesType type = (RadishProductDetailFacilitiesType)(obj.integerValue);
            switch (type) {
                case RadishProductDetailFacilitiesTypeWifi://= 1,//Wifi
                {
                    RadishProductDetailInsuranceItem *item = [RadishProductDetailInsuranceItem item:@"Prodetail_buyNotice_04" title:@"Wifi"];
                    if(item) [items addObject:item];
                }
                    break;
                case RadishProductDetailFacilitiesTypeCarPark://= 2,//停车场
                {
                    RadishProductDetailInsuranceItem *item = [RadishProductDetailInsuranceItem item:@"Prodetail_buyNotice_05" title:@"停车位"];
                    if(item) [items addObject:item];
                }
                    break;
                case RadishProductDetailFacilitiesTypeMBRoom://= 3,//母婴室
                {
                    RadishProductDetailInsuranceItem *item = [RadishProductDetailInsuranceItem item:@"Prodetail_buyNotice_08" title:@"母婴室"];
                    if(item) [items addObject:item];
                }
                    break;
                case RadishProductDetailFacilitiesTypeTeaRoom://= 4,//茶水间
                {
                    RadishProductDetailInsuranceItem *item = [RadishProductDetailInsuranceItem item:@"Prodetail_buyNotice_09" title:@"茶水间"];
                    if(item) [items addObject:item];
                }
                    break;
                case RadishProductDetailFacilitiesTypeSafetyProtection://= 5,//安全防护
                {
                    RadishProductDetailInsuranceItem *item = [RadishProductDetailInsuranceItem item:@"Prodetail_buyNotice_10" title:@"安全防护"];
                    if(item) [items addObject:item];
                }
                    break;
                case RadishProductDetailFacilitiesTypeFirstAidkit://= 6,//急救包
                {
                    RadishProductDetailInsuranceItem *item = [RadishProductDetailInsuranceItem item:@"Prodetail_buyNotice_11" title:@"急救包"];
                    if(item) [items addObject:item];
                }
                    break;
                case RadishProductDetailFacilitiesTypeAnteRoom://= 7,//休息室
                {
                    RadishProductDetailInsuranceItem *item = [RadishProductDetailInsuranceItem item:@"Prodetail_buyNotice_12" title:@"休息室"];
                    if(item) [items addObject:item];
                }
                    break;
                case RadishProductDetailFacilitiesTypeToilet://= 8,//卫生间
                {
                    RadishProductDetailInsuranceItem *item = [RadishProductDetailInsuranceItem item:@"Prodetail_buyNotice_13" title:@"卫生间"];
                    if(item) [items addObject:item];
                }
                    break;
                case RadishProductDetailFacilitiesTypeDiaperBed://= 9//尿布床
                {
                    RadishProductDetailInsuranceItem *item = [RadishProductDetailInsuranceItem item:@"Prodetail_buyNotice_14" title:@"尿布床"];
                    if(item) [items addObject:item];
                }
                    break;
            }
        }];
    }
    
    
    self.items = [NSArray arrayWithArray:items];
}
@end
