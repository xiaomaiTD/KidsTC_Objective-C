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
    NSMutableArray<SearchFactorSortDataItem *> *items = [NSMutableArray array];
    SearchFactorSortDataItem *intelligence = [SearchFactorSortDataItem itemWithImg:@"search_toolBar_sort_intelligence" title:@"智能排序" value:@"1"];
    SearchFactorSortDataItem *star = [SearchFactorSortDataItem itemWithImg:@"search_toolBar_sort_star" title:@"按星级排序" value:@"7"];
    SearchFactorSortDataItem *price_up = [SearchFactorSortDataItem itemWithImg:@"search_toolBar_sort_price_up" title:@"价格从低到高" value:@"4"];
    SearchFactorSortDataItem *price_down = [SearchFactorSortDataItem itemWithImg:@"search_toolBar_sort_price_down" title:@"价格从高到低" value:@"5"];
    if (intelligence) [items addObject:intelligence];
    if (star) [items addObject:star];
    if (price_up) [items addObject:price_up];
    if (price_down) [items addObject:price_down];
    return [NSArray arrayWithArray:items];
}
@end
