//
//  StrategyToolBar.h
//  KidsTC
//
//  Created by zhanping on 7/11/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StrategyModel.h"
#import "StrategyToolBarScrollView.h"
@class StrategyToolBar;
@protocol StrategyToolBarDelegate <NSObject>
- (void)strategyToolBar:(StrategyToolBar *)strategyToolBar didSelectedIndex:(NSUInteger)index;
@end

@interface StrategyToolBar : UIView
@property (nonatomic, strong) NSArray<StrategyTypeListTagItem *> *tags;
@property (nonatomic, weak) id<StrategyToolBarDelegate> delegate;
- (void)changeTipPlaceWithSmallIndex:(NSUInteger)smallIndex
                            bigIndex:(NSUInteger)bigIndex
                            progress:(CGFloat)progress
                             animate:(BOOL)animate;
@end
