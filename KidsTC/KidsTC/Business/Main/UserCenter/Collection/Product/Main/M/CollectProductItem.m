//
//  CollectProductItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/25.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectProductItem.h"
#import "NSString+Category.h"

@implementation CollectProductItem
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"productCategory":[CollectProductCategory class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    _imgRatio = _imgRatio<=0?0.6:_imgRatio;
    
    if ([_productSysNo isNotNull]) {
        if (![_channelId isNotNull]) _channelId = @"0";
        switch (_productType) {
            case ProductDetailTypeNormal:
            case ProductDetailTypeTicket:
            case ProductDetailTypeFree:
                break;
            default:
            {
                _productType = ProductDetailTypeNormal;
            }
                break;
        }
        NSDictionary *param = @{@"pid":_productSysNo,
                                @"cid":_channelId,
                                @"type":@(_productType)};
        _segueModel = [SegueModel modelWithDestination:SegueDestinationServiceDetail paramRawData:param];
    }
    
    return YES;
}
@end
