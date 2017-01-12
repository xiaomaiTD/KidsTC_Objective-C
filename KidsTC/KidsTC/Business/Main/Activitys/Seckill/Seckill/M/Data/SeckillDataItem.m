//
//  SeckillDataItem.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/11.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "SeckillDataItem.h"
#import "ProductDetailSegueParser.h"

@implementation SeckillDataItem
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"advertisement":[SeckillDataBanner class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _segueModel = [ProductDetailSegueParser segueModelWithProductType:_productType productId:_productNo channelId:_channelId openGroupId:nil];
    return YES;
}
@end
