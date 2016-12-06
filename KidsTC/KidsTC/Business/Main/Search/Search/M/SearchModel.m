//
//  SearchModel.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/6.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchModel.h"

@implementation SearchModel
singleM(SearchModel)

- (NSArray<SearchSectionItem *> *)sections {
        
    NSMutableArray<SearchSectionItem *> *sections = [NSMutableArray array];
    
    //热搜关键字
    {
        NSMutableArray<SearchRowItem *> *section00 = [NSMutableArray array];
        SearchHotKeywordsData *data = [SearchHotKeywordsManager shareSearchHotKeywordsManager].model.data;
        NSArray<SearchHotKeywordsItem *> *location = data.location;
        NSArray<SearchHotKeywordsItem *> *store = data.store;
        NSArray<SearchHotKeywordsItem *> *product = data.product;
        
        if (location.count>0) {
            SearchRowItem *item = [SearchRowItem rowItemWithType:SearchRowItemTypeHotKey icon:@"search_address" items:location];
            if (item) [section00 addObject:item];
        }
        
        if (store.count>0) {
            SearchRowItem *item = [SearchRowItem rowItemWithType:SearchRowItemTypeHotKey icon:@"search_store" items:store];
            if (item) [section00 addObject:item];
        }
        
        if (product.count>0) {
            SearchRowItem *item = [SearchRowItem rowItemWithType:SearchRowItemTypeHotKey icon:@"search_balloon" items:product];
            if (item) [section00 addObject:item];
        }
        
        if (section00.count>0) {
            SearchSectionItem *sectionOO_item = [SearchSectionItem sectionItemWithTitle:@"" rows:section00];
            if(sectionOO_item)[sections addObject:sectionOO_item];
        }
    }
    
    //搜索历史
    {
        NSArray<SearchHotKeywordsItem *> *history = [SearchHistoryKeywordsManager shareSearchHistoryKeywordsManager].model.history;
        
        NSMutableArray<SearchRowItem *> *section01 = [NSMutableArray array];
        [history enumerateObjectsUsingBlock:^(SearchHotKeywordsItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj) {
                SearchRowItem *item = [SearchRowItem rowItemWithType:SearchRowItemTypeLocal icon:@"search_history" items:@[obj]];
                if (item) [section01 addObject:item];
            }
        }];
        if (section01.count>0) {
            self.isHasHistory = YES;
            SearchSectionItem *sectionO1_item = [SearchSectionItem sectionItemWithTitle:@"搜索历史" rows:section01];
            if(sectionO1_item)[sections addObject:sectionO1_item];
        }else{
            self.isHasHistory = NO;
        }
    }
    
    _sections = [NSArray arrayWithArray:sections];
    
    return _sections;
}




@end
