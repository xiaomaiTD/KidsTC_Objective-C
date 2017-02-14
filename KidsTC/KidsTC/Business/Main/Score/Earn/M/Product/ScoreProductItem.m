//
//  ScoreProductItem.m
//  KidsTC
//
//  Created by 童成mac-dev1 on 2017/2/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreProductItem.h"
#import "ProductDetailSegueParser.h"

@implementation ScoreProductItem
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    if (_picRate<=0) _picRate = 0.6;
    _segueModel = [ProductDetailSegueParser segueModelWithProductType:_productRedirectType productId:_productNo channelId:_channelId openGroupId:nil];
    
    return YES;
}
@end
