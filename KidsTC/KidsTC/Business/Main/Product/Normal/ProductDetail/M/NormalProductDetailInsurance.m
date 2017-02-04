//
//  NormalProductDetailInsurance.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/4.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "NormalProductDetailInsurance.h"
#import "NSString+Category.h"

@implementation NormalProductDetailInsurance
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    NSArray *ary = dic[@"facilitiesType"];
    [self setupitems:ary];
    
    return YES;
}

- (void)setupitems:(NSArray *)ary {
    
    NSMutableArray<NormalProductDetailInsuranceItem *> *items = [NSMutableArray array];
    
    if (_refund_anytime) {
        NormalProductDetailInsuranceItem *item = [NormalProductDetailInsuranceItem item:@"Prodetail_buyNotice_01" title:@"随时退"];
        if(item) [items addObject:item];
    }
    if (_refund_outdate) {
        NormalProductDetailInsuranceItem *item = [NormalProductDetailInsuranceItem item:@"Prodetail_buyNotice_06" title:@"过期退"];
        if(item) [items addObject:item];
    }
    if (_refund_part) {
        NormalProductDetailInsuranceItem *item = [NormalProductDetailInsuranceItem item:@"Prodetail_buyNotice_07" title:@"部分退"];
        if(item) [items addObject:item];
    }
    if (_appointment) {
        NormalProductDetailInsuranceItem *item = [NormalProductDetailInsuranceItem item:@"Prodetail_buyNotice_02" title:@"需要预约"];
        if(item) [items addObject:item];
    }
    {
        NSString *title = [_age isNotNull]?_age:@"无年龄限制";
        NormalProductDetailInsuranceItem *item = [NormalProductDetailInsuranceItem item:@"Prodetail_buyNotice_03" title:title];
        if(item) [items addObject:item];
    }
    
    [_facilitiesType enumerateObjectsUsingBlock:^(NSNumber * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NormalProductDetailInsuranceItem *item = [self itemWithNumber:obj];
        if (item) [items addObject:item];
    }];
    
    self.items = [NSArray arrayWithArray:items];
}

- (NormalProductDetailInsuranceItem *)itemWithNumber:(NSNumber *)number {
    NormalNormalProductDetailFacilitiesType type = (NormalNormalProductDetailFacilitiesType)[number integerValue];
    switch (type) {
        case NormalProductDetailFacilitiesTypeWifi://= 1,//Wifi
        {
            return [NormalProductDetailInsuranceItem item:@"Prodetail_buyNotice_04" title:@"Wifi"];
            
        }
            break;
        case NormalProductDetailFacilitiesTypeCarPark://= 2,//停车场
        {
            return [NormalProductDetailInsuranceItem item:@"Prodetail_buyNotice_05" title:@"停车位"];
            
        }
            break;
        case NormalProductDetailFacilitiesTypeMBRoom://= 3,//母婴室
        {
            return [NormalProductDetailInsuranceItem item:@"Prodetail_buyNotice_08" title:@"母婴室"];
            
        }
            break;
        case NormalProductDetailFacilitiesTypeTeaRoom://= 4,//茶水间
        {
            return [NormalProductDetailInsuranceItem item:@"Prodetail_buyNotice_09" title:@"茶水间"];
            
        }
            break;
        case NormalProductDetailFacilitiesTypeSafetyProtection://= 5,//安全防护
        {
            return [NormalProductDetailInsuranceItem item:@"Prodetail_buyNotice_10" title:@"安全防护"];
            
        }
            break;
        case NormalProductDetailFacilitiesTypeFirstAidkit://= 6,//急救包
        {
            return [NormalProductDetailInsuranceItem item:@"Prodetail_buyNotice_11" title:@"急救包"];
            
        }
            break;
        case NormalProductDetailFacilitiesTypeAnteRoom://= 7,//休息室
        {
            return [NormalProductDetailInsuranceItem item:@"Prodetail_buyNotice_12" title:@"休息室"];
            
        }
            break;
        case NormalProductDetailFacilitiesTypeToilet://= 8,//卫生间
        {
            return [NormalProductDetailInsuranceItem item:@"Prodetail_buyNotice_13" title:@"卫生间"];
            
        }
            break;
        case NormalProductDetailFacilitiesTypeDiaperBed://= 9//尿布床
        {
            return [NormalProductDetailInsuranceItem item:@"Prodetail_buyNotice_14" title:@"尿布床"];
            
        }
            break;
            default:
        {
            return nil;
        }
            break;
    }
}

@end
