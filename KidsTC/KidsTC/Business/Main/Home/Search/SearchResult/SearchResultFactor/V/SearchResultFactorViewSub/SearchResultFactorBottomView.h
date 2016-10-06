//
//  SearchResultFactorBottomView.h
//  KidsTC
//
//  Created by zhanping on 6/30/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    SearchResultFactorBottomViewClickType_CleanUp=1,
    SearchResultFactorBottomViewClickType_MakeSure
} SearchResultFactorBottomViewClickType;

@class SearchResultFactorBottomView;

@protocol SearchResultFactorBottomViewDelegate <NSObject>
- (void)searchResultFactorBottomView:(SearchResultFactorBottomView *)searchResultFactorBottomView didClickOnBtnType:(SearchResultFactorBottomViewClickType)type;
@end

@interface SearchResultFactorBottomView : UIView
@property (nonatomic, weak) id<SearchResultFactorBottomViewDelegate> delegate;
@end
