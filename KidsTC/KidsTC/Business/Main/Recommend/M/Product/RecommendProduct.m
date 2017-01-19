//
//  RecommendProduct.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/20.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RecommendProduct.h"
#import "ProductDetailSegueParser.h"

@implementation RecommendProduct
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _segueModel = [ProductDetailSegueParser segueModelWithProductType:_productType productId:_productSysNo channelId:_channelId openGroupId:nil];
    return YES;
}
@end
