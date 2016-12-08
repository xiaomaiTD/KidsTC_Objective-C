//
//  SearchResultView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResultProduct.h"

#define kSearchResultViewPageCount 10

typedef enum : NSUInteger {
    SearchResultProductViewShowTypeSmall = 1,//小图模式
    SearchResultProductViewShowTypeLarge,//大图模式
} SearchResultProductViewShowType;

typedef enum : NSUInteger {
    SearchResultViewActionTypeLoadData = 1,
    SearchResultViewActionTypeSegue,
} SearchResultViewActionType;

@class SearchResultView;
@protocol SearchResultViewDelegate <NSObject>
- (void)searchResultView:(SearchResultView *)view actionType:(SearchResultViewActionType)type value:(id)value;
@end

@interface SearchResultView : UIView
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, weak) id<SearchResultViewDelegate> delegate;
@property (nonatomic, assign) SearchResultProductViewShowType showType;
@property (nonatomic, assign) SearchType searchType;
- (void)dealWithUI:(NSUInteger)loadCount;
- (void)beginRefreshing;
- (void)reloadData;
@end
