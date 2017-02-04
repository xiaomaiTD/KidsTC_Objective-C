//
//  FlashBuyProductDetailPromotionLink.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/22.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "FlashBuyProductDetailPromotionLink.h"

@implementation FlashBuyProductDetailPromotionLink
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    _segueModel = [SegueModel modelWithDestination:_linkType paramRawData:_params];
    
    return YES;
}
@end
