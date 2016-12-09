//
//  SearchHotKeywordsItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/6.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchHotKeywordsItem.h"
#import "NSString+Category.h"

@implementation SearchHotKeywordsItem
+ (instancetype)itemWithName:(NSString *)name {
    SearchHotKeywordsItem *item = [SearchHotKeywordsItem new];
    item.name = name;
    item.searchType = SearchTypeProduct;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if ([name isNotNull]) {
        [param setObject:name forKey:kSearchKey_words];
    }
    item.search_parms = [NSDictionary dictionaryWithDictionary:param];
    return item;
}
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    if ([_name isNotNull]) {
        NSMutableDictionary *search_params = [NSMutableDictionary dictionaryWithDictionary:_search_parms];
        [search_params setObject:_name forKey:kSearchKey_words];
        _search_parms = [NSDictionary dictionaryWithDictionary:search_params];
    }
    
    return YES;
}
@end
