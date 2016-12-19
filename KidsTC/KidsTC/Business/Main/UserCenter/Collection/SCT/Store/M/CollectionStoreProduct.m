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
            default:
            {
                NSDictionary *param = @{@"pid":_productSysNo,
                                        @"cid":_channelId};
                _segueModel = [SegueModel modelWithDestination:SegueDestinationServiceDetail paramRawData:param];
            }
                break;
        }
    }
    return YES;
}
@end
