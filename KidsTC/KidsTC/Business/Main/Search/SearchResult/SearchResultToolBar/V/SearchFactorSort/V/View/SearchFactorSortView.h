//
//  SearchFactorSortView.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchFactorSortDataManager.h"

@class SearchFactorSortView;
@protocol SearchFactorSortViewDelegate <NSObject>
- (void)searchFactorSortView:(SearchFactorSortView *)view didSelectItem:(SearchFactorSortDataItem *)item;
@end

@interface SearchFactorSortView : UIView
@property (nonatomic, weak) id<SearchFactorSortViewDelegate> delegate;
- (CGFloat)contentHeight;
- (void)selectFirstItem;
@end
