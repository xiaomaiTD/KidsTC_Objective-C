//
//  RadishProductOrderListDeliverItem.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/6.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishProductOrderListDeliverItem.h"

@implementation RadishProductOrderListDeliverItem
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _segueModel = [SegueModel modelWithDestination:_linkType paramRawData:_linkParams];
    return YES;
}
@end
