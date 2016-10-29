//
//  ProductDetailInsurance.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailInsurance.h"
#import "NSString+Category.h"


@implementation ProductDetailInsurance
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    NSArray *ary = dic[@"facilitiesType"];
    [self setupitems:ary];
    
    return YES;
}

- (void)setupitems:(NSArray *)ary {
    
    NSMutableArray<ProductDetailInsuranceItem *> *items = [NSMutableArray array];
    
    if (_refund_anytime) {
        ProductDetailInsuranceItem *item = [ProductDetailInsuranceItem item:@"Prodetail_buyNotice_01" title:@"随时退"];
        if(item) [items addObject:item];
    }
    if (_refund_outdate) {
        ProductDetailInsuranceItem *item = [ProductDetailInsuranceItem item:@"Prodetail_buyNotice_06" title:@"过期退"];
        if(item) [items addObject:item];
    }
    if (_refund_part) {
        ProductDetailInsuranceItem *item = [ProductDetailInsuranceItem item:@"Prodetail_buyNotice_07" title:@"部分退"];
        if(item) [items addObject:item];
    }
    if (_appointment) {
        ProductDetailInsuranceItem *item = [ProductDetailInsuranceItem item:@"Prodetail_buyNotice_02" title:@"需要预约"];
        if(item) [items addObject:item];
    }
    {
        NSString *title = [_age isNotNull]?_age:@"无年龄限制";
        ProductDetailInsuranceItem *item = [ProductDetailInsuranceItem item:@"Prodetail_buyNotice_03" title:title];
        if(item) [items addObject:item];
    }
    
    if (ary && ![ary isKindOfClass:[NSNull class]]) {
        [ary enumerateObjectsUsingBlock:^(NSNumber  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ProductDetailFacilitiesType type = (ProductDetailFacilitiesType)(obj.integerValue);
            switch (type) {
                case ProductDetailFacilitiesTypeWifi://= 1,//Wifi
                {
                    ProductDetailInsuranceItem *item = [ProductDetailInsuranceItem item:@"Prodetail_buyNotice_04" title:@"Wifi"];
                    if(item) [items addObject:item];
                }
                    break;
                case ProductDetailFacilitiesTypeCarPark://= 2,//停车场
                {
                    ProductDetailInsuranceItem *item = [ProductDetailInsuranceItem item:@"Prodetail_buyNotice_05" title:@"停车位"];
                    if(item) [items addObject:item];
                }
                    break;
                case ProductDetailFacilitiesTypeMBRoom://= 3,//母婴室
                {
                    ProductDetailInsuranceItem *item = [ProductDetailInsuranceItem item:@"Prodetail_buyNotice_08" title:@"母婴室"];
                    if(item) [items addObject:item];
                }
                    break;
                case ProductDetailFacilitiesTypeTeaRoom://= 4,//茶水间
                {
                    ProductDetailInsuranceItem *item = [ProductDetailInsuranceItem item:@"Prodetail_buyNotice_09" title:@"茶水间"];
                    if(item) [items addObject:item];
                }
                    break;
                case ProductDetailFacilitiesTypeSafetyProtection://= 5,//安全防护
                {
                    ProductDetailInsuranceItem *item = [ProductDetailInsuranceItem item:@"Prodetail_buyNotice_10" title:@"安全防护"];
                    if(item) [items addObject:item];
                }
                    break;
                case ProductDetailFacilitiesTypeFirstAidkit://= 6,//急救包
                {
                    ProductDetailInsuranceItem *item = [ProductDetailInsuranceItem item:@"Prodetail_buyNotice_11" title:@"急救包"];
                    if(item) [items addObject:item];
                }
                    break;
                case ProductDetailFacilitiesTypeAnteRoom://= 7,//休息室
                {
                    ProductDetailInsuranceItem *item = [ProductDetailInsuranceItem item:@"Prodetail_buyNotice_12" title:@"休息室"];
                    if(item) [items addObject:item];
                }
                    break;
                case ProductDetailFacilitiesTypeToilet://= 8,//卫生间
                {
                    ProductDetailInsuranceItem *item = [ProductDetailInsuranceItem item:@"Prodetail_buyNotice_13" title:@"卫生间"];
                    if(item) [items addObject:item];
                }
                    break;
                case ProductDetailFacilitiesTypeDiaperBed://= 9//尿布床
                {
                    ProductDetailInsuranceItem *item = [ProductDetailInsuranceItem item:@"Prodetail_buyNotice_14" title:@"尿布床"];
                    if(item) [items addObject:item];
                }
                    break;
            }
        }];
    }
    
    
    self.items = [NSArray arrayWithArray:items];
}
@end
