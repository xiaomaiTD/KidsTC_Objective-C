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
    SearchResultViewActionTypeLoadData = 1,
} SearchResultViewActionType;

@class SearchResultView;
@protocol SearchResultViewDelegate <NSObject>
- (void)searchResultView:(SearchResultView *)view actionType:(SearchResultViewActionType)type value:(id)value;
@end

@interface SearchResultView : UIView
@property (nonatomic, strong) NSArray<SearchResultProduct *> *products;
@property (nonatomic, weak) id<SearchResultViewDelegate> delegate;
- (void)dealWithUI:(NSUInteger)loadCount;
@end
