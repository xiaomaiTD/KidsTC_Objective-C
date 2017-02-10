//
//  TCStoreDetailProductPackageItem.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "TCStoreDetailProductPackageItem.h"
#import "ProductDetailSegueParser.h"

@implementation TCStoreDetailProductPackageItem
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    _segueModel = [ProductDetailSegueParser segueModelWithProductType:_productRedirectType productId:_productNo channelId:_channelId openGroupId:nil];
    
    return YES;
}
@end
