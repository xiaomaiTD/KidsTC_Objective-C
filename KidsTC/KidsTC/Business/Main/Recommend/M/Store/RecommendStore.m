//
//  RecommendStore.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RecommendStore.h"
#import "NSString+Category.h"

@implementation RecommendStore
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"productLst":[RecommendStoreProduct class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    if ([_storeNo isNotNull]) {
        _segueModel = [SegueModel modelWithDestination:SegueDestinationStoreDetail paramRawData:@{@"sid":_storeNo}];
    }
    
    return YES;
}
@end
