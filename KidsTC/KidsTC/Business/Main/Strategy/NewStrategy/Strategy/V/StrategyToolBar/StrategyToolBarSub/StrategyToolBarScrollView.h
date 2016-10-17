//
//  StrategyToolBarScrollView.h
//  KidsTC
//
//  Created by zhanping on 7/11/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>

#define StrategyToolBarScrollViewHeight 40
@class StrategyToolBarScrollView;
@protocol StrategyToolBarScrollViewDelegate <NSObject>
- (void)strategyToolBarScrollView:(StrategyToolBarScrollView *)strategyToolBarScrollView didSelectedIndex:(NSUInteger)index;
@end

@interface StrategyToolBarScrollView : UIScrollView
@property (nonatomic, strong) NSArray<NSString *> *tags;
@property (nonatomic, weak) UIButton *selectedBtn;
@property (nonatomic, weak) id<StrategyToolBarScrollViewDelegate> clickDelegate;
- (void)changeTipPlaceWithSmallIndex:(NSUInteger)smallIndex
                            bigIndex:(NSUInteger)bigIndex
                            progress:(CGFloat)progress
                             animate:(BOOL)animate;
@end
