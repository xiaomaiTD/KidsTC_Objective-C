//
//  TipButton.h
//  KidsTC
//
//  Created by zhanping on 7/28/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    TipButtonBadgeTypeNum,
    TipButtonBadgeTypeIcon
} TipButtonBadgeType;

@interface TipButton : UIButton
@property (nonatomic, weak) UILabel *tipLabel;
@property (nonatomic, assign) TipButtonBadgeType badgeType;
@property (nonatomic, assign) NSUInteger badgeValue;
@end
