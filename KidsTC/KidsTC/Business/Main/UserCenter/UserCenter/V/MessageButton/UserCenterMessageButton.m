//
//  UserCenterMessageButton.m
//  KidsTC
//
//  Created by 詹平 on 16/7/28.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "UserCenterMessageButton.h"

@interface UserCenterMessageButton ()
@end

@implementation UserCenterMessageButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    return self;
}

- (UIEdgeInsets)alignmentRectInsets
{
    return UIEdgeInsetsMake(0, -6, 0, 6);
}

+ (instancetype)btnWithImageName:(NSString *)imageName
                   highImageName:(NSString *)highImageName
                          target:(id)target
                          action:(SEL)action
{
    UserCenterMessageButton *btn = [[UserCenterMessageButton alloc]initWithFrame:CGRectMake(0, 0, 24, 24)];
    btn.badgeType = TipButtonBadgeTypeIcon;
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.tipLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    btn.tipLabel.layer.borderWidth = LINE_H;
    return btn;
}


@end
