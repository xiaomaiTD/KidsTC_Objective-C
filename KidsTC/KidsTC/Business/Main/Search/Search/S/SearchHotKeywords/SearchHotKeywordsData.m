//
//  SearchHotKeywordsData.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/6.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchHotKeywordsData.h"

@implementation SearchHotKeywordsData
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{@"location" : [SearchHotKeywordsItem class],
             @"product"  : [SearchHotKeywordsItem class],
             @"store"    : [SearchHotKeywordsItem class]};
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    [_location enumerateObjectsUsingBlock:^(SearchHotKeywordsItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.searchType = SearchTypeProduct;
    }];
    [_product enumerateObjectsUsingBlock:^(SearchHotKeywordsItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.searchType = SearchTypeProduct;
    }];
    [_store enumerateObjectsUsingBlock:^(SearchHotKeywordsItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.searchType = SearchTypeStore;
    }];
    return YES;
}
@end
