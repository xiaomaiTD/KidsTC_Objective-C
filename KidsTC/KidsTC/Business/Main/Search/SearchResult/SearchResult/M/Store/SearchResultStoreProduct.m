//
//  SearchResultStoreProduct.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/8.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchResultStoreProduct.h"
#import "NSString+Category.h"

@implementation SearchResultStoreProduct
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    if ([_ProductSysNo isNotNull]) {
        if (![_ChannelId isNotNull]) _ChannelId = @"0";
        switch (_ProductType) {
            case ProductDetailTypeNormal:
            case ProductDetailTypeTicket:
            case ProductDetailTypeFree:
                break;
            default:
            {
                _ProductType = ProductDetailTypeNormal;
            }
                break;
        }
        NSDictionary *param = @{@"pid":_ProductSysNo,
                                @"cid":_ChannelId,
                                @"type":@(_ProductType)};
        _segueModel = [SegueModel modelWithDestination:SegueDestinationServiceDetail paramRawData:param];
    }
    
    return YES;
}
@end
