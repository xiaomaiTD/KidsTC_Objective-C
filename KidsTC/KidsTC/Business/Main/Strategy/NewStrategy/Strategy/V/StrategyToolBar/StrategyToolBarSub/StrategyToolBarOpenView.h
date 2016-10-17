//
//  StrategyToolBarOpenView.h
//  KidsTC
//
//  Created by zhanping on 7/11/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StrategyToolBarScrollView.h"
#define MAX_ListCount 4 //最大列数
#define BTN_Hight 34 //按钮高度
#define BTN_Margin 12 //按钮的间距

@class StrategyToolBarOpenView;
@protocol StrategyToolBarOpenViewDelegate <NSObject>
- (void)strategyToolBarOpenView:(StrategyToolBarOpenView *)strategyToolBarOpenView didSelectedIndex:(NSUInteger)index;
@end

@interface StrategyToolBarOpenView : UIView
@property (nonatomic, weak) NSArray<NSString *> *tags;
@property (nonatomic, weak) UIButton *openBtn;
@property (nonatomic, weak) id<StrategyToolBarOpenViewDelegate> delegate;
- (void)selectedBtnIndex:(NSUInteger)index;
@end
