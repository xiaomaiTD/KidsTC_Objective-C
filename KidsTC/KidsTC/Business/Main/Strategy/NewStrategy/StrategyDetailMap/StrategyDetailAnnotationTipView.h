//
//  StrategyDetailAnnotationTipView.h
//  KidsTC
//
//  Created by zhanping on 8/20/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StrategyDetailAnnotationTipView;
@protocol StrategyDetailAnnotationTipViewDelegate <NSObject>
- (void)strategyDetailAnnotationTipViewDidClickOnGotoBtn:(StrategyDetailAnnotationTipView *)view;
@end


@protocol BMKAnnotation;
@interface StrategyDetailAnnotationTipView : UIView
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (nonatomic, assign) id<BMKAnnotation> annotation;
@property (nonatomic, weak) id<StrategyDetailAnnotationTipViewDelegate> delegate;
@end
