//
//  SearchResultProduct.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchResultProduct.h"
#import "NSString+Category.h"
#import "ProductDetailSegueParser.h"

@implementation SearchResultProduct
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _bigImgRatio = _bigImgRatio>0?_bigImgRatio:0.6;
    _segueModel = [ProductDetailSegueParser segueModelWithProductType:_productSearchType productId:_serveId channelId:_channelId openGroupId:nil];
    return YES;
}
@end
