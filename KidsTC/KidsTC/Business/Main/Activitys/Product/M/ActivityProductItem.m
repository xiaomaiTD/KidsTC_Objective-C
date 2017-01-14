//
//  ActivityProductItem.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ActivityProductItem.h"
#import "ProductDetailSegueParser.h"

@implementation ActivityProductItem
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if (_ratio<=0) _ratio = 0.6;
    _segueModel = [ProductDetailSegueParser segueModelWithProductType:_productRedirect productId:_productNo channelId:_channelId openGroupId:nil];
    return YES;
}
@end
