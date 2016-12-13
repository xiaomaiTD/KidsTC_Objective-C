//
//  NearbyCategoryToolBarItem.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/2.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyCategoryToolBarItem.h"
#import "CategoryDataManager.h"

@implementation NearbyCategoryToolBarItem
+ (instancetype)itemWithTitle:(NSString *)title value:(NSString *)value {
    NearbyCategoryToolBarItem *item = [NearbyCategoryToolBarItem new];
    item.title = title;
    item.value = value;
    return item;
}

+ (NSArray<NearbyCategoryToolBarItem *> *)items {
    NSArray<CategoryListItem *> *categorys = [CategoryDataManager shareCategoryDataManager].model.data;
    NSMutableArray<NearbyCategoryToolBarItem *> *items = [NSMutableArray array];
    NearbyCategoryToolBarItem *firstItem = [NearbyCategoryToolBarItem itemWithTitle:@"全部分类" value:@""];
    if(firstItem) [items addObject:firstItem];
    [categorys enumerateObjectsUsingBlock:^(CategoryListItem *obj, NSUInteger idx, BOOL *stop) {
        NearbyCategoryToolBarItem *item = [NearbyCategoryToolBarItem itemWithTitle:[NSString stringWithFormat:@"%@",obj.Name] value:[NSString stringWithFormat:@"%@",obj.SysNo]];
        if(item)[items addObject:item];
    }];
    return items;
}
@end
