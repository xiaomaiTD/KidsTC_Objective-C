//
//  MyTracksItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/30.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "MyTracksItem.h"
#import "NSString+Category.h"

@implementation MyTracksItem
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _picRatio = _picRatio<=0?0.6:_picRatio;
    _productName = [_productName isNotNull]?_productName:@"";
    _storeName = [_storeName isNotNull]?_storeName:@"";
    _distanceDesc = [_distanceDesc isNotNull]?_distanceDesc:@"";
    _validTimeDesc = [_validTimeDesc isNotNull]?_validTimeDesc:@"";
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
