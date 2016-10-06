//
//  SearchTypeItem.m
//  KidsTC
//
//  Created by 詹平 on 16/6/29.
//  Copyright © 2016年 KidsTC. All rights reserved.
//

#import "SearchTypeItem.h"


@implementation SearchTypeItem

- (instancetype)initWithSearchType:(SearchType)searchType placeHolder:(NSString *)placeHolder searchTypeTitle:(NSString *)searchTypeTitle{
    self = [super init];
    if (self) {
        self.searchType = searchType;
        self.searchTypeTitle = searchTypeTitle;
        self.placeHolder = placeHolder;
    }
    return self;
}

+(SearchTypeItem *)searchTypeItemWithSearchType:(SearchType)searchType placeHolder:(NSString *)placeHolder searchTypeTitle:(NSString *)searchTypeTitle{
    return [[self alloc]initWithSearchType:searchType placeHolder:placeHolder searchTypeTitle:searchTypeTitle];
}

+(NSArray<SearchTypeItem *> *)searchTypeItemArrayWith:(SearchHotKeywordsModel *)searchHotKeywordsModel{
    NSMutableArray<SearchTypeItem *> *array = [NSMutableArray array];
    SearchHotKeywordsData *data = searchHotKeywordsModel.data;
    
    NSArray<SearchHotKeywordsListProductOrStoreItem *> *product = data.product;
    NSArray<SearchHotKeywordsListProductOrStoreItem *> *store = data.store;
    NSArray<SearchHotKeywordsListArticleItem *> *article = data.article;
    
    SearchHotKeywordsListItem *productItem = product.firstObject;
    SearchHotKeywordsListItem *storeItem = store.firstObject;
    SearchHotKeywordsListItem *articleItem = article.firstObject;
    
    NSString *productTitle = @"服务";
    NSString *storeTitle = @"门店";
    NSString *articleTitle = @"资讯";
    
    NSString *productPlaceHolder = productItem.name;
    if (productPlaceHolder.length<=0) {
        productPlaceHolder = [NSString stringWithFormat:@"请输入%@搜索关键字",productTitle];
    }
    NSString *storePlaceHolder = storeItem.name;
    if (storePlaceHolder.length<=0) {
        storePlaceHolder = [NSString stringWithFormat:@"请输入%@搜索关键字",storeTitle];
    }
    NSString *articlePlaceHolder = articleItem.name;
    if (articlePlaceHolder.length<=0) {
        articlePlaceHolder = [NSString stringWithFormat:@"请输入%@搜索关键字",articleTitle];
    }
    
    SearchTypeItem *searchTypeProductItem = [SearchTypeItem searchTypeItemWithSearchType:SearchType_Product placeHolder:productPlaceHolder searchTypeTitle:productTitle];
    SearchTypeItem *searchTypeStoreItem = [SearchTypeItem searchTypeItemWithSearchType:SearchType_Store placeHolder:storePlaceHolder searchTypeTitle:storeTitle];
    SearchTypeItem *searchTypeArticleItem = [SearchTypeItem searchTypeItemWithSearchType:SearchType_Article placeHolder:articlePlaceHolder searchTypeTitle:articleTitle];
    
    [array addObject:searchTypeProductItem];
    [array addObject:searchTypeStoreItem];
    [array addObject:searchTypeArticleItem];
    
    return array;
}
@end
