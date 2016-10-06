//
//  HomeCountDownMoreTitleCell.h
//  appDelegate
//
//  Created by ling on 16/7/19.
//  Copyright © 2016年 潘灵. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeBaseCell.h"
@class HomeFloorsItem;

@interface CountdownView : UIView

@end

@interface SubTitleView : UIView

@end

@interface HomeCountDownMoreTitleCell : HomeBaseCell

- (void)stopCountDown;

@end
