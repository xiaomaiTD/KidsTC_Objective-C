//
//  StrategyAutoRollView.h
//  StrategyAutoRollViewController
//
//  Created by 平 on 15/12/12.
//  Copyright © 2015年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StrategyAutoRollCell.h"
@protocol StrategyAutoRollViewDelegate<NSObject>
-(void)didSelectPageAtIndex:(NSUInteger)index;
@end
@interface StrategyAutoRollView : UIView
@property (nonatomic,strong)NSArray *items;
@property (nonatomic,weak)id<StrategyAutoRollViewDelegate> delegate;
-(instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items delegate:(id<StrategyAutoRollViewDelegate>)delegate;
@end
