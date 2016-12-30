//
//  CollectProductItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/25.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectProductItem.h"
#import "NSString+Category.h"
#import "ProductDetailSegueParser.h"

@implementation CollectProductItem
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"productCategory":[CollectProductCategory class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    _imgRatio = _imgRatio<=0?0.6:_imgRatio;
    _segueModel = [ProductDetailSegueParser segueModelWithProductType:_productType productId:_productSysNo channelId:_channelId openGroupId:nil];
    return YES;
}
@end
