//
//  MyTracksItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/30.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "MyTracksItem.h"
#import "NSString+Category.h"
#import "ProductDetailSegueParser.h"

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
            {
                NSDictionary *param = @{@"pid":_productSysNo,
                                        @"cid":_channelId};
                _segueModel = [SegueModel modelWithDestination:SegueDestinationServiceDetail paramRawData:param];
            }
                break;
            case ProductDetailTypeTicket:
            {
                NSDictionary *param = @{@"pid":_productSysNo,
                                        @"cid":_channelId};
                _segueModel = [SegueModel modelWithDestination:SegueDestinationProductTicketDetail paramRawData:param];
            }
                break;
            case ProductDetailTypeFree:
            {
                NSDictionary *param = @{@"pid":_productSysNo,
                                        @"cid":_channelId};
                _segueModel = [SegueModel modelWithDestination:SegueDestinationProductFreeDetail paramRawData:param];
            }
                break;
            case ProductDetailTypeWholesale:
            {
                
            }
                break;
            default:
            {
                NSDictionary *param = @{@"pid":_productSysNo,
                                        @"cid":_channelId};
                _segueModel = [SegueModel modelWithDestination:SegueDestinationServiceDetail paramRawData:param];
            }
                break;
        }
    }
    _segueModel = [ProductDetailSegueParser segueModelWithProductType:_productType productId:_productSysNo channelId:_channelId];
    return YES;
}
@end
