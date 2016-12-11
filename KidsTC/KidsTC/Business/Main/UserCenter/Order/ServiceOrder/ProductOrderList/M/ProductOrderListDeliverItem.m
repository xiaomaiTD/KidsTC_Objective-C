//
//  ProductOrderListDeliverItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/9.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderListDeliverItem.h"

@implementation ProductOrderListDeliverItem
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    _segueModel = [SegueModel modelWithDestination:_linkType paramRawData:_linkParams];
    
    return YES;
}
@end
