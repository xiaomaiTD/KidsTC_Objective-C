//
//  SearchResultFactorShowModelManager.m
//  KidsTC
//
//  Created by zhanping on 6/29/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "SearchResultFactorShowModelManager.h"
#import "AreaAndAgeDataManager.h"
#import "CategoryDataManager.h"

#define product_sotre_title @"title"
#define product_sotre_value @"value"

@interface SearchResultFactorShowModelManager ()
@property (nonatomic, strong) AreaAndAgeModel *areaAndAgeModel;
@property (nonatomic, strong) CategoryModel *categoryModel;
@end

@implementation SearchResultFactorShowModelManager

static SearchResultFactorShowModelManager *_manager;
+(instancetype)shareManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc]init];
    });
    return _manager;
}

- (void)loadSearchResultFactorDataCallBack:(SearchResultFactorDataCallBackBlock)callBack{
    
    self.areaAndAgeModel = [AreaAndAgeDataManager shareAreaAndAgeDataManager].model;
    self.categoryModel = [CategoryDataManager shareCategoryDataManager].model;
    
    SearchResultFactorShowModel *productFactorShowModel = [self productFactorShowModel];
    SearchResultFactorShowModel *storeFactorShowModel = [self storeFactorShowModel];
    if (callBack) {
        callBack(productFactorShowModel,storeFactorShowModel);
    }
}

/**
 *  1.地区
 */
- (SearchResultFactorTopItem *)arreItem{
    
    NSMutableArray<AreaAndAgeListItem *> *Addr = [NSMutableArray arrayWithArray:self.areaAndAgeModel.data.Addr];
    AreaAndAgeListItem *item = [AreaAndAgeListItem itemWithName:@"全部区域" value:@""];
    [Addr insertObject:item atIndex:0];
    __block NSMutableArray<SearchResultFactorItem *> *subItems = [NSMutableArray<SearchResultFactorItem *> array];
    [Addr enumerateObjectsUsingBlock:^(AreaAndAgeListItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SearchResultFactorItem *factorItem = [SearchResultFactorItem itemWithTitle:obj.Name value:obj.Value];
        if (idx == 0) {
            factorItem.selected = YES;
            factorItem.makeSureSelected = YES;
        }
        [subItems addObject:factorItem];
    }];
    
    NSArray<NSArray<SearchResultFactorItem *> *> *subArrays = [NSArray<NSArray<SearchResultFactorItem *> *> arrayWithObject:subItems];
    
    SearchResultFactorTopItem *arreItem = (SearchResultFactorTopItem *)[SearchResultFactorTopItem itemWithTitle:@"地区" subArrays:subArrays];
    arreItem.type = SearchResultFactorTopItemTypeArea;
    return arreItem;
}

/**
 *  3.筛选
 */
- (SearchResultFactorItem *)filterItem{
    
    NSArray *ageItems = [NSMutableArray arrayWithObject:[self ageItem]];
    
    NSArray *categoryItems = [self categoryItems];
    
    NSArray<NSArray<SearchResultFactorItem *> *> *subArrays = [NSArray<NSArray<SearchResultFactorItem *> *> arrayWithObjects:ageItems, categoryItems, nil];
    
    SearchResultFactorTopItem *filterItem = (SearchResultFactorTopItem *)[SearchResultFactorTopItem itemWithTitle:@"筛选" subArrays:subArrays];
    filterItem.type = SearchResultFactorTopItemTypeFilter;
    return filterItem;
}

/**
 *  人群
 */
- (SearchResultFactorItem *)ageItem{
    
    NSArray<AreaAndAgeListItem *> *Age = self.areaAndAgeModel.data.Age;
    
    __block NSMutableArray<SearchResultFactorItem *> *subItems = [NSMutableArray<SearchResultFactorItem *> array];
    [Age enumerateObjectsUsingBlock:^(AreaAndAgeListItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [subItems addObject:[SearchResultFactorItem itemWithTitle:obj.Name value:obj.Value]];
    }];
    
    NSArray<NSArray<SearchResultFactorItem *> *> *subArrays = [NSArray<NSArray<SearchResultFactorItem *> *> arrayWithObject:subItems];
    
    SearchResultFactorItem *ageItem = [SearchResultFactorItem itemWithTitle:@"人群" subArrays:subArrays];
    return ageItem;
}

/**
 *  categoryItems
 *
 *  @return categoryItems
 */
-(NSMutableArray<SearchResultFactorItem *> *)categoryItems{
    
    NSArray<CategoryListItem *> *data = self.categoryModel.data;
    NSMutableArray<SearchResultFactorItem *> *categoryItems = [self categoryItemsWithCategoryListItem:data];
    return categoryItems;
}

- (NSMutableArray<SearchResultFactorItem *> *)categoryItemsWithCategoryListItem:(NSArray<CategoryListItem *> *)categoryListItem{
    
    __block NSMutableArray<SearchResultFactorItem *> *categoryItems = [NSMutableArray<SearchResultFactorItem *> array];
    [categoryListItem enumerateObjectsUsingBlock:^(CategoryListItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SearchResultFactorItem *showItem = [SearchResultFactorItem itemWithTitle:obj.Name value:obj.SysNo];
        [categoryItems addObject:showItem];
        
        if (obj.ScondCategory.count>0) {
            NSArray<CategoryListItem *> *ScondCategory = obj.ScondCategory;
            NSMutableArray<SearchResultFactorItem *> *categoryItems = [self categoryItemsWithCategoryListItem:ScondCategory];//此处递归
            NSArray<NSArray<SearchResultFactorItem *> *> *subArrays = [NSArray<NSArray<SearchResultFactorItem *> *> arrayWithObject:categoryItems];
            showItem.subArrays = subArrays;
        }
    }];
    
    return categoryItems;
}


#pragma mark - product

- (SearchResultFactorShowModel *)productFactorShowModel{
    
    NSArray<SearchResultFactorTopItem *> *array = [NSArray<SearchResultFactorTopItem *> arrayWithObjects:self.arreItem, self.productSortItem, self.filterItem, nil];
    
    return [SearchResultFactorShowModel modelWithShowItems:array];
}

/**
 *  2. 排序 - 服务
 */
- (SearchResultFactorTopItem *)productSortItem{
    NSArray<NSDictionary *> *productSortDicts = [self productSortDicts];
    __block NSMutableArray<SearchResultFactorItem *> *subItems = [NSMutableArray<SearchResultFactorItem *> array];
    [productSortDicts enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SearchResultFactorItem *factorItem = [SearchResultFactorItem itemWithTitle:obj[product_sotre_title] value:obj[product_sotre_value]];
        if (idx == 0) {
            factorItem.selected = YES;
            factorItem.makeSureSelected = YES;
        }
        [subItems addObject:factorItem];
    }];
    NSArray<NSArray<SearchResultFactorItem *> *> *subArrays = [NSArray<NSArray<SearchResultFactorItem *> *> arrayWithObject:subItems];
    SearchResultFactorTopItem *productSortItem = (SearchResultFactorTopItem *)[SearchResultFactorTopItem itemWithTitle:@"排序" subArrays:subArrays];
    productSortItem.type = SearchResultFactorTopItemTypeSort;
    return productSortItem;
}

- (NSArray<NSDictionary *> *)productSortDicts{
    NSDictionary *dic0 = @{product_sotre_title:@"智能排序",product_sotre_value:@"1"};
    NSDictionary *dic1 = @{product_sotre_title:@"按销量排序",product_sotre_value:@"8"};
    NSDictionary *dic2 = @{product_sotre_title:@"按星级排序",product_sotre_value:@"7"};
    NSDictionary *dic3 = @{product_sotre_title:@"价格从低到高",product_sotre_value:@"4"};
    NSDictionary *dic4 = @{product_sotre_title:@"价格从高到低",product_sotre_value:@"5"};
    return [NSArray<NSDictionary *> arrayWithObjects:dic0, dic1, dic2, dic3, dic4, nil];
}

#pragma mark - store

- (SearchResultFactorShowModel *)storeFactorShowModel{
    
    NSArray<SearchResultFactorTopItem *> *array = [NSArray<SearchResultFactorTopItem *> arrayWithObjects:self.arreItem, self.storeSortItem, self.filterItem, nil];
    
    return [SearchResultFactorShowModel modelWithShowItems:array];
}

/**
 *  2. 排序 - 门店
 */
- (SearchResultFactorItem *)storeSortItem{
    
    
    
    NSArray<NSDictionary *> *storeSortDicts = [self storeSortDicts];
    __block NSMutableArray<SearchResultFactorItem *> *subItems = [NSMutableArray<SearchResultFactorItem *> array];
    [storeSortDicts enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        SearchResultFactorItem *factorItem = [SearchResultFactorItem itemWithTitle:obj[product_sotre_title] value:obj[product_sotre_value]];
        if (idx == 0) {
            factorItem.selected = YES;
            factorItem.makeSureSelected = YES;
        }
        [subItems addObject:factorItem];
    }];
    NSArray<NSArray<SearchResultFactorItem *> *> *subArrays = [NSArray<NSArray<SearchResultFactorItem *> *> arrayWithObject:subItems];
    SearchResultFactorTopItem *storeSortItem = (SearchResultFactorTopItem *)[SearchResultFactorTopItem itemWithTitle:@"排序" subArrays:subArrays];
    storeSortItem.type = SearchResultFactorTopItemTypeSort;
    return storeSortItem;
}

- (NSArray<NSDictionary *> *)storeSortDicts{
    NSDictionary *dic0 = @{product_sotre_title:@"智能排序",product_sotre_value:@"1"};
    NSDictionary *dic1 = @{product_sotre_title:@"按星级排序",product_sotre_value:@"5"};
    NSDictionary *dic2 = @{product_sotre_title:@"离我最近",product_sotre_value:@"6"};
    return [NSArray<NSDictionary *> arrayWithObjects:dic0, dic1, dic2, nil];
}

@end
