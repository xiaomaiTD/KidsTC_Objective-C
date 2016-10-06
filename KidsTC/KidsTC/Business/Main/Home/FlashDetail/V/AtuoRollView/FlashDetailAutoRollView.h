//
//  AutoRollView.h
//  AutoRollViewController
//
//  Created by 平 on 15/12/12.
//  Copyright © 2015年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlashDetailAutoRollViewCell.h"
@protocol FlashDetailAutoRollViewDelegate<NSObject>
-(void)didSelectPageAtIndex:(NSUInteger)index;
@end
@interface FlashDetailAutoRollView : UIView
@property (nonatomic,strong)NSArray *items;
@property (nonatomic,weak)id<FlashDetailAutoRollViewDelegate> delegate;
-(instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items delegate:(id<FlashDetailAutoRollViewDelegate>)delegate;
@end
