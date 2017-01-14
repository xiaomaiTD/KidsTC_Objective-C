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
+ (SegueModel *)segueModelWithProductType:(ProductDetailType)productType
                                productId:(NSString *)productId
                                channelId:(NSString *)channelId
                              openGroupId:(NSString *)openGroupId
{
    if (![productId isNotNull]) return nil;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:productId forKey:@"pid"];
    SegueDestination dest = SegueDestinationNone;
    switch (productType) {
        case ProductDetailTypeTicket:
        {
            dest = SegueDestinationProductTicketDetail;
            if (![channelId isNotNull]) channelId = @"0";
            [params setObject:channelId forKey:@"cid"];
        }
            break;
        case ProductDetailTypeFree:
        {
            dest = SegueDestinationProductFreeDetail;
            if (![channelId isNotNull]) channelId = @"0";
            [params setObject:channelId forKey:@"cid"];
        }
            break;
        case ProductDetailTypeWholesale:
        {
            dest = SegueDestinationOrderWholesaleDetail;
            if ([openGroupId isNotNull]) {
                [params setObject:openGroupId forKey:@"gid"];
            }
        }
            break;
        case ProductDetailTypeRadish:
        {
            dest = SegueDestinationProductRadishDetail;
            if (![channelId isNotNull]) channelId = @"0";
            [params setObject:channelId forKey:@"cid"];
        }
            break;
        case ProductDetailTypeFalsh:
        {
            dest = SegueDestinationFlashDetail;
        }
            break;
        default:
        {
            dest = SegueDestinationServiceDetail;
            if (![channelId isNotNull]) channelId = @"0";
            [params setObject:channelId forKey:@"cid"];
        }
            break;
    }
    return [SegueModel modelWithDestination:dest paramRawData:params];
}
@end
