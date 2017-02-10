//
//  TCStoreDetailNearbyProduct.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/9.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "TCStoreDetailNearbyProduct.h"
#import "ProductDetailSegueParser.h"

@implementation TCStoreDetailNearbyProduct
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"fullCut":[NSString class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    _segueModel = [ProductDetailSegueParser segueModelWithProductType:_productSearchType productId:_serveId channelId:_channelId openGroupId:nil];
    
    return YES;
}
@end
