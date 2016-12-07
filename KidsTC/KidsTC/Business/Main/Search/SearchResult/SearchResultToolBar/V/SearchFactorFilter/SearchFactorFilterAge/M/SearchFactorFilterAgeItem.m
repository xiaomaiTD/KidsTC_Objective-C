//
//  SearchFactorFilterAgeItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/6.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchFactorFilterAgeItem.h"
#import "AreaAndAgeDataManager.h"

@implementation SearchFactorFilterAgeItem
+ (instancetype)itemWithTitle:(NSString *)title value:(NSString *)value {
    SearchFactorFilterAgeItem *item = [SearchFactorFilterAgeItem new];
    item.title = title;
    item.value = value;
    return item;
}
+ (NSArray<SearchFactorFilterAgeItem *> *)items {
    NSArray<AreaAndAgeListItem *> *ages = [AreaAndAgeDataManager shareAreaAndAgeDataManager].model.data.Age;
    NSMutableArray *items = [NSMutableArray array];
    [ages enumerateObjectsUsingBlock:^(AreaAndAgeListItem *obj, NSUInteger idx, BOOL *stop) {
        SearchFactorFilterAgeItem *item = [SearchFactorFilterAgeItem itemWithTitle:obj.Name value:obj.Value];
        if(item)[items addObject:item];
    }];
    return [NSArray arrayWithArray:items];
}
@end
