//
//  CollectProductCategoryItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/25.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectProductCategoryItem.h"

@implementation CollectProductCategoryItem
+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{@"productLst":[CollectProductItem class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    if (_productLst.count>0) {
        _firstItem = _productLst.firstObject;
        NSMutableArray *productList = [NSMutableArray arrayWithArray:_productLst];
        [productList removeObjectAtIndex:0];
        _items = [NSArray arrayWithArray:productList];
    }
    return YES;
}
@end
