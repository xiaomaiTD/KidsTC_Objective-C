//
//  SearchHistoryKeywordsManager.m
//  KidsTC
//
//  Created by zhanping on 6/28/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "SearchHistoryKeywordsManager.h"
static NSString *const SearchHistoryKeywordsFileName = @"SearchHistoryKeywords";

@implementation SearchHistoryKeywordsManager
singleM(SearchHistoryKeywordsManager)

- (SearchHistoryKeywordsModel *)model{
    if (!_model) {
        NSString *filePath = FILE_CACHE_PATH(SearchHistoryKeywordsFileName);
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        if (data) {
           _model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
    }
    if (!_model) {
        _model = [[SearchHistoryKeywordsModel alloc]init];
    }
    return _model;
}

- (void) addSearchHistoryKeywords:(NSString *)searchHistoryKeywords searchType:(SearchType)searchType{
    if (searchHistoryKeywords.length<=0) {
        return;
    }
    switch (searchType) {
        case SearchType_Product:
        {
            [self.model.product enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isEqualToString:searchHistoryKeywords]) {
                    [self.model.product removeObjectAtIndex:idx];
                }
            }];
            [self.model.product insertObject:searchHistoryKeywords atIndex:0];
        }
            break;
        case SearchType_Store:
        {
            [self.model.store enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isEqualToString:searchHistoryKeywords]) {
                    [self.model.store removeObjectAtIndex:idx];
                }
            }];
            [self.model.store insertObject:searchHistoryKeywords atIndex:0];
        }
            break;
        case SearchType_Article:
        {
            [self.model.article enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isEqualToString:searchHistoryKeywords]) {
                    [self.model.article removeObjectAtIndex:idx];
                }
            }];
            [self.model.article insertObject:searchHistoryKeywords atIndex:0];
        }
            break;
        default:
            break;
    }
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.model];
    NSString *filePath = FILE_CACHE_PATH(SearchHistoryKeywordsFileName);
    [data writeToFile:filePath atomically:YES];
}

- (void)removeSearchHistoryKeywordsAtIndex:(NSUInteger)index searchType:(SearchType)searchType{
    switch (searchType) {
        case SearchType_Product:
        {
            if (self.model.product.count>index) {
                [self.model.product removeObjectAtIndex:index];
            }
        }
            break;
        case SearchType_Store:
        {
            if (self.model.store.count>index) {
                [self.model.store removeObjectAtIndex:index];
            }
        }
            break;
        case SearchType_Article:
        {
            if (self.model.article.count>index) {
                [self.model.article removeObjectAtIndex:index];
            }
        }
            break;
        default:
            break;
    }
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.model];
    NSString *filePath = FILE_CACHE_PATH(SearchHistoryKeywordsFileName);
    [data writeToFile:filePath atomically:YES];
}

- (void)cleanUpHistoryWithSearchType:(SearchType)searchType{
    
    switch (searchType) {
        case SearchType_Product:
        {
            [self.model.product removeAllObjects];
        }
            break;
        case SearchType_Store:
        {
            [self.model.store removeAllObjects];
        }
            break;
        case SearchType_Article:
        {
            [self.model.article removeAllObjects];
        }
            break;
        default:
            break;
    }
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.model];
    NSString *filePath = FILE_CACHE_PATH(SearchHistoryKeywordsFileName);
    [data writeToFile:filePath atomically:YES];
}


@end
