//
//  NearbyCalendarToolBarCategoryItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyCalendarToolBarCategoryItem.h"
#import "CategoryDataManager.h"

@implementation NearbyCalendarToolBarCategoryItem

+ (instancetype)itemWithTitle:(NSString *)title value:(NSString *)value {
    NearbyCalendarToolBarCategoryItem *item = [NearbyCalendarToolBarCategoryItem new];
    item.title = title;
    item.value = value;
    return item;
}

+ (NSArray<NearbyCalendarToolBarCategoryItem *> *)items {
    NSArray<CategoryListItem *> *categorys = [CategoryDataManager shareCategoryDataManager].model.data;
    NSMutableArray<NearbyCalendarToolBarCategoryItem *> *items = [NSMutableArray array];
    NearbyCalendarToolBarCategoryItem *firstItem = [NearbyCalendarToolBarCategoryItem itemWithTitle:@"全部分类" value:@""];
    if(firstItem) [items addObject:firstItem];
    [categorys enumerateObjectsUsingBlock:^(CategoryListItem *obj, NSUInteger idx, BOOL *stop) {
        NearbyCalendarToolBarCategoryItem *item = [NearbyCalendarToolBarCategoryItem itemWithTitle:obj.Name value:obj.SysNo];
        if(item)[items addObject:item];
    }];
    return items;
}

@end
