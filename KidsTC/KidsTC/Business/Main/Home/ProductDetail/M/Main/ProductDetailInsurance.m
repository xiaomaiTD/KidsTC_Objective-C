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
        ProductDetailInsuranceItem *item = [ProductDetailInsuranceItem item:@"ProductDetail_06" title:@"随时退"];
        if(item) [items addObject:item];
    }
    if (_refund_outdate) {
        ProductDetailInsuranceItem *item = [ProductDetailInsuranceItem item:@"ProductDetail_06" title:@"过期退"];
        if(item) [items addObject:item];
    }
    if (_refund_part) {
        ProductDetailInsuranceItem *item = [ProductDetailInsuranceItem item:@"ProductDetail_06" title:@"部分退"];
        if(item) [items addObject:item];
    }
    if (_appointment) {
        ProductDetailInsuranceItem *item = [ProductDetailInsuranceItem item:@"ProductDetail_07" title:@"需要预约"];
        if(item) [items addObject:item];
    }
    {
        NSString *title = [_age isNotNull]?_age:@"无年龄限制";
        ProductDetailInsuranceItem *item = [ProductDetailInsuranceItem item:@"ProductDetail_08" title:title];
        if(item) [items addObject:item];
    }
    
    if (ary && ![ary isKindOfClass:[NSNull class]]) {
        [ary enumerateObjectsUsingBlock:^(NSNumber  *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ProductDetailFacilitiesType type = (ProductDetailFacilitiesType)(obj.integerValue);
            switch (type) {
                case ProductDetailFacilitiesTypeWifi://= 1,//Wifi
                {
                    ProductDetailInsuranceItem *item = [ProductDetailInsuranceItem item:@"ProductDetail_09" title:@"有Wifi"];
                    if(item) [items addObject:item];
                }
                    break;
                case ProductDetailFacilitiesTypeCarPark://= 2,//停车场
                {
                    ProductDetailInsuranceItem *item = [ProductDetailInsuranceItem item:@"ProductDetail_10" title:@"有停车位"];
                    if(item) [items addObject:item];
                }
                    break;
                case ProductDetailFacilitiesTypeMBRoom://= 3,//母婴室
                {
                    ProductDetailInsuranceItem *item = [ProductDetailInsuranceItem item:@"ProductDetail_09" title:@"有母婴室"];
                    if(item) [items addObject:item];
                }
                    break;
                case ProductDetailFacilitiesTypeTeaRoom://= 4,//茶水间
                {
                    ProductDetailInsuranceItem *item = [ProductDetailInsuranceItem item:@"ProductDetail_09" title:@"有茶水间"];
                    if(item) [items addObject:item];
                }
                    break;
                case ProductDetailFacilitiesTypeSafetyProtection://= 5,//安全防护
                {
                    ProductDetailInsuranceItem *item = [ProductDetailInsuranceItem item:@"ProductDetail_09" title:@"有安全防护"];
                    if(item) [items addObject:item];
                }
                    break;
                case ProductDetailFacilitiesTypeFirstAidkit://= 6,//急救包
                {
                    ProductDetailInsuranceItem *item = [ProductDetailInsuranceItem item:@"ProductDetail_09" title:@"有急救包"];
                    if(item) [items addObject:item];
                }
                    break;
                case ProductDetailFacilitiesTypeAnteRoom://= 7,//休息室
                {
                    ProductDetailInsuranceItem *item = [ProductDetailInsuranceItem item:@"ProductDetail_09" title:@"有休息室"];
                    if(item) [items addObject:item];
                }
                    break;
                case ProductDetailFacilitiesTypeToilet://= 8,//卫生间
                {
                    ProductDetailInsuranceItem *item = [ProductDetailInsuranceItem item:@"ProductDetail_09" title:@"有卫生间"];
                    if(item) [items addObject:item];
                }
                    break;
                case ProductDetailFacilitiesTypeDiaperBed://= 9//尿布床
                {
                    ProductDetailInsuranceItem *item = [ProductDetailInsuranceItem item:@"ProductDetail_09" title:@"有尿布床"];
                    if(item) [items addObject:item];
                }
                    break;
            }
        }];
    }
    
    
    self.items = [NSArray arrayWithArray:items];
}
@end
