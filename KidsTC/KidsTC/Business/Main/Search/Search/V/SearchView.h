//
//  SearchView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/6.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum : NSUInteger {
    SearchViewActionTypeDidSelectItem = 1,//点击某一个item
    SearchViewActionTypeDeleteHistoryItem,//删除某一条历史记录
    SearchViewActionTypeCleanUpHistory,//清除历史记录
} SearchViewActionType;

@class SearchView;
@protocol SearchViewDelegate <NSObject>
- (void)searchView:(SearchView *)view actionType:(SearchViewActionType)type value:(id)value;
@end

@interface SearchView : UIView
@property (nonatomic, weak) id<SearchViewDelegate> delegate;
- (void)reloadData;
@end
