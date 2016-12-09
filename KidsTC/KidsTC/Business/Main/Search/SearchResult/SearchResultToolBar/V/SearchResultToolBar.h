//
//  SearchResultToolBar.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

extern CGFloat const kSearchResultToolBarH;

typedef enum : NSUInteger {
    SearchResultToolBarActionTypeBtnClicked = 1,
    SearchResultToolBarActionTypeDidSelectParam,
    SearchResultToolBarActionTypeDidSelectProduct,
    SearchResultToolBarActionTypeDidSelectStore,
} SearchResultToolBarActionType;
@class SearchResultToolBar;
@protocol SearchResultToolBarDelegate <NSObject>
- (void)searchResultToolBar:(SearchResultToolBar *)toolBar actionType:(SearchResultToolBarActionType)type value:(id)value;
@end

@interface SearchResultToolBar : UIView
@property (nonatomic, strong) NSDictionary *insetParam;
@property (nonatomic, weak) id<SearchResultToolBarDelegate> delegate;
@property (nonatomic, assign) SearchType searchType;
@end
