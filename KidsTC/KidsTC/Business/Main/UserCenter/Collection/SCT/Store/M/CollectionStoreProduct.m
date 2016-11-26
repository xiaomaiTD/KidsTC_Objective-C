//
//  CollectionStoreProduct.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectionStoreProduct.h"
#import "NSString+Category.h"

@implementation CollectionStoreProduct
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
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
