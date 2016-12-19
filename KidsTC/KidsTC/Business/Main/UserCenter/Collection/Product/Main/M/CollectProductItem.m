//
//  CollectProductItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/25.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectProductItem.h"
#import "NSString+Category.h"

@implementation CollectProductItem
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"productCategory":[CollectProductCategory class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    _imgRatio = _imgRatio<=0?0.6:_imgRatio;
    
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
