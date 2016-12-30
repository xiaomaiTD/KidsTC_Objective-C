//
//  SearchResultStoreProduct.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/8.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchResultStoreProduct.h"
#import "NSString+Category.h"
#import "ProductDetailSegueParser.h"

@implementation SearchResultStoreProduct
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _segueModel = [ProductDetailSegueParser segueModelWithProductType:_productSearchType productId:_serveId channelId:_channelId openGroupId:nil];
    return YES;
}
@end
