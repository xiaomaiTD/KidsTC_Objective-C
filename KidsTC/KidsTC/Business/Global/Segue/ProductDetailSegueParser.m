//
//  ProductDetailSegueParser.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailSegueParser.h"
#import "NSString+Category.h"

@implementation ProductDetailSegueParser
+ (SegueModel *)segueModelWithProductType:(ProductDetailType)productType productId:(NSString *)productId channelId:(NSString *)channelId{
    SegueDestination dest = SegueDestinationNone;
    switch (productType) {
        case ProductDetailTypeTicket:
        {
            dest = SegueDestinationProductTicketDetail;
        }
            break;
        case ProductDetailTypeFree:
        {
            dest = SegueDestinationProductFreeDetail;
        }
            break;
        case ProductDetailTypeWholesale:
        {
            dest = SegueDestinationOrderWholesaleDetail;
        }
            break;
        default:
        {
            dest = SegueDestinationServiceDetail;
        }
            break;
    }
    if (![productId isNotNull]) return nil;
    if (![channelId isNotNull]) channelId = @"0";
    NSDictionary *param = @{@"pid":productId,
                            @"cid":channelId};
    return [SegueModel modelWithDestination:dest paramRawData:param];
}
@end
