//
//  StrategyTableHeaderView.h
//  KidsTC
//
//  Created by zhanping on 6/12/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StrategyModel.h"

@class StrategyTableHeaderView;
@protocol StrategyTableHeaderViewDelegate <NSObject>
- (void)strategyTableHeaderView:(StrategyTableHeaderView *)strategyTableHeaderView didClickBannerAtIndex:(NSUInteger)index;
- (void)strategyTableHeaderView:(StrategyTableHeaderView *)strategyTableHeaderView didClickTagPicAtIndex:(NSUInteger)index;
@end


@interface StrategyTableHeaderView : UIView
@property (nonatomic, strong) StrategyShowHeader *header;
@property (nonatomic, weak) id<StrategyTableHeaderViewDelegate> delegate;
@end
