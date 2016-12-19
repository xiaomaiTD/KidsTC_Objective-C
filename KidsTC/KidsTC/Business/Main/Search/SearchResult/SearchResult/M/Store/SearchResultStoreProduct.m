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
            {
                NSDictionary *param = @{@"pid":_serveId,
                                        @"cid":_channelId};
                _segueModel = [SegueModel modelWithDestination:SegueDestinationServiceDetail paramRawData:param];
            }
                break;
            case ProductDetailTypeTicket:
            {
                NSDictionary *param = @{@"pid":_serveId,
                                        @"cid":_channelId};
                _segueModel = [SegueModel modelWithDestination:SegueDestinationProductTicketDetail paramRawData:param];
            }
                break;
            case ProductDetailTypeFree:
            {
                NSDictionary *param = @{@"pid":_serveId,
                                        @"cid":_channelId};
                _segueModel = [SegueModel modelWithDestination:SegueDestinationProductFreeDetail paramRawData:param];
            }
                break;
            default:
            {
                NSDictionary *param = @{@"pid":_serveId,
                                        @"cid":_channelId};
                _segueModel = [SegueModel modelWithDestination:SegueDestinationServiceDetail paramRawData:param];
            }
                break;
        }
    }
    
    return YES;
}
@end
