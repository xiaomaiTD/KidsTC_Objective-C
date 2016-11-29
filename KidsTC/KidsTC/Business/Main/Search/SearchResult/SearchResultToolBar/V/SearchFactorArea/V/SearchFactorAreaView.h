//
//  SearchFactorAreaView.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchFactorAreaDataManager.h"

@class SearchFactorAreaView;
@protocol SearchFactorAreaViewDelegate <NSObject>
- (void)searchFactorAreaView:(SearchFactorAreaView *)view didSelectItem:(SearchFactorAreaDataItem *)item;
@end

@interface SearchFactorAreaView : UIView
@property (nonatomic, weak) id<SearchFactorAreaViewDelegate> delegate;
- (CGFloat)contentHeight;
@end
