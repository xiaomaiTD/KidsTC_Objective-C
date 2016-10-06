//
//  SearchResultFactorShowModel.m
//  KidsTC
//
//  Created by zhanping on 6/29/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "SearchResultFactorShowModel.h"
#import <UIKit/UIKit.h>
@implementation SearchResultFactorItem

- (instancetype)initWithTitle:(NSString *)title value:(NSString *)value{
    self = [super init];
    if (self) {
        self.title = title;
        self.value = value;
    }
    return self;
}

+(SearchResultFactorItem *)itemWithTitle:(NSString *)title value:(NSString *)value{
    return [[self alloc] initWithTitle:title value:value];
}

+(SearchResultFactorItem *)itemWithTitle:(NSString *)title subArrays:(NSArray<NSArray<SearchResultFactorItem *> *> *)subArrays{
    SearchResultFactorItem *item = [self itemWithTitle:title value:nil];
    item.subArrays = subArrays;
    return item;
}


/**
 *  获取第一个选中的IndexPath
 *
 *  @param item 当前的父item
 *
 *  @return 第一个选中的IndexPath
 */
+ (NSIndexPath *)firstSelectedSubItemIndexPath:(SearchResultFactorItem *)item{
    NSArray<NSArray<SearchResultFactorItem *> *> *sectionArray = item.subArrays;
    for (int section = 0; section<sectionArray.count; section++) {
        NSArray<SearchResultFactorItem *> *rowArray = sectionArray[section];
        for (int row = 0; row<rowArray.count; row++) {
            SearchResultFactorItem *subItem = rowArray[row];
            if (subItem.selected) {
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
                return indexPath;
            }
        }
    }
    return nil;
}

+ (SearchResultFactorItem *)firstSelectedSubItem:(SearchResultFactorItem *)item{
    NSArray<NSArray<SearchResultFactorItem *> *> *sectionArray = item.subArrays;
    for (int section = 0; section<sectionArray.count; section++) {
        NSArray<SearchResultFactorItem *> *rowArray = sectionArray[section];
        for (int row = 0; row<rowArray.count; row++) {
            SearchResultFactorItem *subItem = rowArray[row];
            if (subItem.selected) {
                return subItem;
            }
        }
    }
    return nil;
}
@end

@implementation SearchResultFactorTopItem

@end

@implementation SearchResultFactorShowModel

- (instancetype)initWithShowItems:(NSArray<SearchResultFactorTopItem *> *)items{
    self = [super init];
    if (self) {
        self.items = items;
    }
    return self;
}

+(instancetype)modelWithShowItems:(NSArray<SearchResultFactorTopItem *> *)items{
    return [[self alloc]initWithShowItems:items];
}
@end



