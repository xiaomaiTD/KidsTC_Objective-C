//
//  SearchFactorFilterDataManager.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchFactorFilterDataManager.h"
#import "AreaAndAgeDataManager.h"
#import "CategoryDataManager.h"

@implementation SearchFactorFilterDataManager
singleM(SearchFactorFilterDataManager)
- (NSArray<NSArray<SearchFactorFilterDataItemLefe *> *> *)filters {
    if (!_filters) {
        
        NSArray<AreaAndAgeListItem *> *ages = [AreaAndAgeDataManager shareAreaAndAgeDataManager].model.data.Age;
        NSMutableArray *agesAry_right = [NSMutableArray array];
        [ages enumerateObjectsUsingBlock:^(AreaAndAgeListItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            SearchFactorFilterDataItemRight *ageItem_right = [SearchFactorFilterDataItemRight itemWithTitle:obj.Name value:obj.Value];
            if(ageItem_right)[agesAry_right addObject:ageItem_right];
        }];
        SearchFactorFilterDataItemLefe *ageItem_left = [SearchFactorFilterDataItemLefe itemWithTitle:@"年龄" items:agesAry_right];
        NSMutableArray<SearchFactorFilterDataItemLefe *> *agesAry_left = [NSMutableArray array];
        if (ageItem_left) [agesAry_left addObject:ageItem_left];
        
        NSArray<CategoryListItem *> *categorys = [CategoryDataManager shareCategoryDataManager].model.data;
        NSMutableArray<SearchFactorFilterDataItemLefe *> *categorysAry_left = [NSMutableArray array];
        [categorys enumerateObjectsUsingBlock:^(CategoryListItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSMutableArray *categorysAry_right = [NSMutableArray array];
            [obj.ScondCategory enumerateObjectsUsingBlock:^(CategoryListItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                SearchFactorFilterDataItemRight *categoryItem_right = [SearchFactorFilterDataItemRight itemWithTitle:obj.Name value:obj.SysNo];
                if(categoryItem_right)[categorysAry_right addObject:categoryItem_right];
            }];
            SearchFactorFilterDataItemLefe *categoryItem_left = [SearchFactorFilterDataItemLefe itemWithTitle:obj.Name items:categorysAry_right];
            if (categoryItem_left) [categorysAry_left addObject:categoryItem_left];
        }];
        
        NSMutableArray<NSArray<SearchFactorFilterDataItemLefe *> *> *filters = [NSMutableArray array];
        if (agesAry_left.count>0) [filters addObject:agesAry_left];
        if (categorysAry_left.count>0) [filters addObject:categorysAry_left];
        
        _filters = [NSArray arrayWithArray:filters];
    }
    return _filters;
}

@end
