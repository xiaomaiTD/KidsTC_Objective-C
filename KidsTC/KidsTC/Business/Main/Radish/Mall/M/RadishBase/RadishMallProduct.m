//
//  RadishMallProduct.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/12.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishMallProduct.h"
#import "NSString+Category.h"

@implementation RadishMallProduct
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if (_ratio<=0) {
        _ratio = 0.6;
    }
    if ([_radishSysNo isNotNull]) {
        if (![_channelId isNotNull]) {
            _channelId = @"0";
        }
        NSDictionary *param = @{@"pid":_radishSysNo,
                                @"cid":_channelId};
        _segueModel = [SegueModel modelWithDestination:SegueDestinationProductRadishDetail paramRawData:param];
    }
    return YES;
}
@end
