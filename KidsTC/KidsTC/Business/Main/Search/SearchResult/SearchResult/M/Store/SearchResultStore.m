//
//  SearchResultStore.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/8.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchResultStore.h"
#import "NSString+Category.h"

@implementation SearchResultStore
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"products":[SearchResultStoreProduct class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    if ([_storeId isNotNull]) {
        _segueModel = [SegueModel modelWithDestination:SegueDestinationStoreDetail paramRawData:@{@"sid":_storeId}];
    }
    
    return YES;
}
@end
