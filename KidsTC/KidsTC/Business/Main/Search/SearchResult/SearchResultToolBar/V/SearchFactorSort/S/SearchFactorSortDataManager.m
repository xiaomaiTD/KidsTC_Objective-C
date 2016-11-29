//
//  SearchFactorSortDataManager.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchFactorSortDataManager.h"

@implementation SearchFactorSortDataManager
singleM(SearchFactorSortDataManager)
- (NSArray<SearchFactorSortDataItem *> *)items {
    if (!_items) {
        SearchFactorSortDataItem *intelligence = [SearchFactorSortDataItem itemWithImg:@"search_toolBar_sort_intelligence" title:@"智能排序" value:@""];
        SearchFactorSortDataItem *star = [SearchFactorSortDataItem itemWithImg:@"search_toolBar_sort_star" title:@"按星级排序" value:@""];
        SearchFactorSortDataItem *price_up = [SearchFactorSortDataItem itemWithImg:@"search_toolBar_sort_price_up" title:@"价格从低到高" value:@""];
        SearchFactorSortDataItem *price_down = [SearchFactorSortDataItem itemWithImg:@"search_toolBar_sort_price_down" title:@"价格从高到低" value:@""];
        _items = @[intelligence,star,price_up,price_down];
    }
    return _items;
}
@end
