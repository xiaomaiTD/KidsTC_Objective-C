//
//  SearchHistoryKeywordsManager.m
//  KidsTC
//
//  Created by zhanping on 6/28/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "SearchHistoryKeywordsManager.h"
#import "NSString+Category.h"
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

- (void)addSearchHistoryKeywords:(NSString *)keywords {
    SearchHotKeywordsItem *item = [SearchHotKeywordsItem new];
    item.name = keywords;
    [self addSearchHistoryItem:item];
}

- (void)addSearchHistoryItem:(SearchHotKeywordsItem *)item{
    if (![item.name isNotNull]) {
        return;
    }
    [self.model.history enumerateObjectsUsingBlock:^(SearchHotKeywordsItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([item.name isEqualToString:obj.name]) {
            [self.model.history removeObjectAtIndex:idx];
        }
    }];
    [self.model.history insertObject:item atIndex:0];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.model];
    NSString *filePath = FILE_CACHE_PATH(SearchHistoryKeywordsFileName);
    [data writeToFile:filePath atomically:YES];
}

- (void)removeSearchHistoryAtIndex:(NSUInteger)index{
    if (self.model.history.count>index) {
        [self.model.history removeObjectAtIndex:index];
    }
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.model];
    NSString *filePath = FILE_CACHE_PATH(SearchHistoryKeywordsFileName);
    [data writeToFile:filePath atomically:YES];
}

- (void)cleanUpHistory{
    [self.model.history removeAllObjects];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.model];
    NSString *filePath = FILE_CACHE_PATH(SearchHistoryKeywordsFileName);
    [data writeToFile:filePath atomically:YES];
}


@end
