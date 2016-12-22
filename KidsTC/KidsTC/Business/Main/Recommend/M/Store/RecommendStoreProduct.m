//
//  RecommendStoreProduct.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RecommendStoreProduct.h"

@implementation RecommendStoreProduct
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    NSString *pid = [NSString stringWithFormat:@"%@",_productSysNo];
    NSString *cid = [NSString stringWithFormat:@"%@",_channelId];
    SegueDestination destination = SegueDestinationServiceDetail;
    NSDictionary *param = @{@"pid":pid,@"cid":cid};
    switch (_productType) {
        case ProductDetailTypeTicket:
        {
            destination = SegueDestinationProductTicketDetail;
        }
            break;
        case ProductDetailTypeFree:
        {
            destination = SegueDestinationProductFreeDetail;
        }
            break;
        default:
        {
            destination = SegueDestinationServiceDetail;
        }
            break;
    }
    _segueModel = [SegueModel modelWithDestination:destination paramRawData:param];
    return YES;
}
@end
