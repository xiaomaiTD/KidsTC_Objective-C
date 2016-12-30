//
//  MyTracksItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/30.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "MyTracksItem.h"
#import "NSString+Category.h"
#import "ProductDetailSegueParser.h"

@implementation MyTracksItem
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    _picRatio = _picRatio<=0?0.6:_picRatio;
    _productName = [_productName isNotNull]?_productName:@"";
    _storeName = [_storeName isNotNull]?_storeName:@"";
    _distanceDesc = [_distanceDesc isNotNull]?_distanceDesc:@"";
    _validTimeDesc = [_validTimeDesc isNotNull]?_validTimeDesc:@"";
    _segueModel = [ProductDetailSegueParser segueModelWithProductType:_productType productId:_productSysNo channelId:_channelId openGroupId:nil];
    return YES;
}
@end
