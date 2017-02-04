//
//  RadishOrderDetailDeliverItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishOrderDetailDeliverItem.h"

@implementation RadishOrderDetailDeliverItem
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _segueModel = [SegueModel modelWithDestination:_linkType paramRawData:_linkParams];
    return YES;
}
@end
