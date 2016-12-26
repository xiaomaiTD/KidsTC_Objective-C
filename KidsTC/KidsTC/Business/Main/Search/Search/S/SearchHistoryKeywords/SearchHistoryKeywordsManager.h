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
#import "SearchHotKeywordsItem.h"

@interface SearchHistoryKeywordsManager : NSObject
singleH(SearchHistoryKeywordsManager)
@property (nonatomic, strong) SearchHistoryKeywordsModel *model;
- (void)addSearchHistoryKeywords:(NSString *)keywords;
- (void)addSearchHistoryItem:(SearchHotKeywordsItem *)item;
- (void)removeSearchHistoryAtIndex:(NSUInteger)index;
- (void)cleanUpHistory;
@end
