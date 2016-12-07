//
//  SearchFactorFilterCategoryItemLeft.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchFactorFilterCategoryItemLeft.h"
#import "CategoryDataManager.h"

@implementation SearchFactorFilterCategoryItemLeft
+ (instancetype)itemWithTitle:(NSString *)title icon:(NSString *)icon rightItems:(NSArray<SearchFactorFilterCategoryItemRight *> *)rightItems{
    SearchFactorFilterCategoryItemLeft *item = [SearchFactorFilterCategoryItemLeft new];
    item.title = title;
    item.icon = icon;
    item.rightItems = rightItems;
    return item;
}
+ (NSArray<SearchFactorFilterCategoryItemLeft *> *)leftItems {
    NSArray<CategoryListItem *> *categorys = [CategoryDataManager shareCategoryDataManager].model.data;
    NSMutableArray<SearchFactorFilterCategoryItemLeft *> *leftItems = [NSMutableArray array];
    [categorys enumerateObjectsUsingBlock:^(CategoryListItem *obj, NSUInteger idx, BOOL *stop) {
        NSMutableArray<SearchFactorFilterCategoryItemRight *> *rightItems = [NSMutableArray array];
        [obj.ScondCategory enumerateObjectsUsingBlock:^(CategoryListItem *obj, NSUInteger idx, BOOL *stop) {
            SearchFactorFilterCategoryItemRight *itemRight = [SearchFactorFilterCategoryItemRight itemWithTitle:obj.Name value:obj.SysNo];
            if(itemRight)[rightItems addObject:itemRight];
        }];
        SearchFactorFilterCategoryItemLeft *itemLeft = [SearchFactorFilterCategoryItemLeft itemWithTitle:obj.Name icon:obj.CategoryImg rightItems:rightItems];
        if (itemLeft) [leftItems addObject:itemLeft];
    }];
    return [NSArray arrayWithArray:leftItems];
}
@end
