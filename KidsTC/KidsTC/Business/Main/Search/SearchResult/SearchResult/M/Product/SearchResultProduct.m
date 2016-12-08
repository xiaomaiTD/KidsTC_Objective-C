//
//  SearchResultProduct.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchResultProduct.h"
#import "NSString+Category.h"

@implementation SearchResultProduct
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _bigImgRatio = _bigImgRatio>0?_bigImgRatio:0.6;
    if ([_serveId isNotNull]) {
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
        NSDictionary *param = @{@"pid":_serveId,
                                @"cid":_channelId,
                                @"type":@(_productType)};
        _segueModel = [SegueModel modelWithDestination:SegueDestinationServiceDetail paramRawData:param];
    }
    
    return YES;
}
@end
