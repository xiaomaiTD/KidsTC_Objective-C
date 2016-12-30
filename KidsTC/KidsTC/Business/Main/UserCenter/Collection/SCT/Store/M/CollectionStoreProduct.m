//
//  CollectionStoreProduct.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectionStoreProduct.h"
#import "NSString+Category.h"
#import "ProductDetailSegueParser.h"

@implementation CollectionStoreProduct
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _segueModel = [ProductDetailSegueParser segueModelWithProductType:_productType productId:_productSysNo channelId:_channelId openGroupId:nil];
    return YES;
}
@end
