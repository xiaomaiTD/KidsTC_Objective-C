//
//  NearbyFilterToolBarCategoryItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyFilterToolBarCategoryItem.h"
#import "CategoryDataManager.h"

@implementation NearbyFilterToolBarCategoryItem

+ (instancetype)itemWithTitle:(NSString *)title value:(NSString *)value {
    NearbyFilterToolBarCategoryItem *item = [NearbyFilterToolBarCategoryItem new];
    item.title = title;
    item.value = value;
    return item;
}

+ (NSArray<NearbyFilterToolBarCategoryItem *> *)items {
    NSArray<CategoryListItem *> *categorys = [CategoryDataManager shareCategoryDataManager].model.data;
    NSMutableArray<NearbyFilterToolBarCategoryItem *> *items = [NSMutableArray array];
    NearbyFilterToolBarCategoryItem *firstItem = [NearbyFilterToolBarCategoryItem itemWithTitle:@"全部分类" value:@""];
    if(firstItem) [items addObject:firstItem];
    [categorys enumerateObjectsUsingBlock:^(CategoryListItem *obj, NSUInteger idx, BOOL *stop) {
        NearbyFilterToolBarCategoryItem *item = [NearbyFilterToolBarCategoryItem itemWithTitle:obj.Name value:obj.SysNo];
        if(item)[items addObject:item];
    }];
    return items;
}

@end
