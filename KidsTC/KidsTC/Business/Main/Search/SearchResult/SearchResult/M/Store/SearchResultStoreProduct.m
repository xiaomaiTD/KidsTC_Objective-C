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
    
    if ([_serveId isNotNull]) {
        if (![_channelId isNotNull]) _channelId = @"0";
        switch (_productSearchType) {
            case ProductDetailTypeNormal:
            case ProductDetailTypeTicket:
            case ProductDetailTypeFree:
                break;
            default:
            {
                _productSearchType = ProductDetailTypeNormal;
            }
                break;
        }
        NSDictionary *param = @{@"pid":_serveId,
                                @"cid":_channelId,
                                @"type":@(_productSearchType)};
        _segueModel = [SegueModel modelWithDestination:SegueDestinationServiceDetail paramRawData:param];
    }
    
    return YES;
}
@end
