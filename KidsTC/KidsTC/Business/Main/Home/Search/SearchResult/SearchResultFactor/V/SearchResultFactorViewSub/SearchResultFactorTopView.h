//
//  SearchResultFactorTopView.h
//  KidsTC
//
//  Created by zhanping on 6/29/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResultFactorShowModel.h"

@class SearchResultFactorTopView;

@protocol SearchResultFactorTopViewDelegate <NSObject>
- (void)searchResultFactorTopView:(SearchResultFactorTopView *)searchResultFactorTopView didClickOnBtn:(UIButton *)btn;
@end

@interface SearchResultFactorTopView : UIView
@property (nonatomic, strong) NSArray<SearchResultFactorTopItem *> *items;
@property (nonatomic, weak) id<SearchResultFactorTopViewDelegate> delegate;
- (void)setBtnTitles;
- (void)unselected;
@end
