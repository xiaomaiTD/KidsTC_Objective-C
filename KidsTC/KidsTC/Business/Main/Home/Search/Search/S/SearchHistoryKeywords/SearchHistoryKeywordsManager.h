//
//  SearchHistoryKeywordsManager.h
//  KidsTC
//
//  Created by zhanping on 6/28/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SearchHistoryKeywordsModel.h"
#import "GHeader.h"
@interface SearchHistoryKeywordsManager : NSObject
singleH(SearchHistoryKeywordsManager)
@property (nonatomic, strong) SearchHistoryKeywordsModel *model;
- (void)addSearchHistoryKeywords:(NSString *)searchHistoryKeywords searchType:(SearchType)searchType;
- (void)removeSearchHistoryKeywordsAtIndex:(NSUInteger)index searchType:(SearchType)searchType;
- (void)cleanUpHistoryWithSearchType:(SearchType)searchType;
@end
