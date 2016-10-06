//
//  HotKeyView.h
//  KidsTC
//
//  Created by zhanping on 6/28/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchHotKeywordsModel.h"

@class SearchHotKeywordsView;
@protocol SearchHotKeywordsViewDelegate <NSObject>
- (void)searchHotKeywordsView:(SearchHotKeywordsView *)searchHotKeywordsView didClickBtnIndex:(NSUInteger)index;
@end

@interface SearchHotKeywordsView : UIView
@property (nonatomic, weak) id<SearchHotKeywordsViewDelegate> delegate;
- (void)setSearchHotKeywordsList:(NSArray<SearchHotKeywordsListItem *> *)SearchHotKeywordsList hasSearchHistory:(BOOL)hasSearchHistory;
@end
