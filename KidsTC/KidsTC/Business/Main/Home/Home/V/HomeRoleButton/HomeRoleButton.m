//
//  HomeRoleButton.m
//  KidsTC
//
//  Created by zhanping on 8/2/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "HomeRoleButton.h"

#define HOME_ROLE_IMAGE_SIZE 11

#define HOME_ROLE_TITLE_IMAGE_MARGIN 2

#define HOME_ROLE_TITLE_FONT [UIFont systemFontOfSize:15]

@implementation HomeRoleButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = HOME_ROLE_TITLE_FONT;
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:COLOR_PINK forState:UIControlStateHighlighted];
        [self setTitleColor:COLOR_PINK forState:UIControlStateSelected];
        self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    return self;
}

- (UIEdgeInsets)alignmentRectInsets
{
    return UIEdgeInsetsMake(0, -8, 0, 8);
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageY = (CGRectGetHeight(contentRect)-HOME_ROLE_IMAGE_SIZE)*0.5;
    return CGRectMake(CGRectGetWidth(contentRect)-HOME_ROLE_IMAGE_SIZE, imageY, HOME_ROLE_IMAGE_SIZE, HOME_ROLE_IMAGE_SIZE);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleW = CGRectGetWidth(contentRect)-HOME_ROLE_IMAGE_SIZE;
    return CGRectMake(0, 0, titleW, CGRectGetHeight(contentRect));
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    NSDictionary *att = @{NSFontAttributeName:HOME_ROLE_TITLE_FONT};
    CGFloat titleW = [title sizeWithAttributes:att].width+HOME_ROLE_TITLE_IMAGE_MARGIN;
    CGRect frame = self.frame;
    frame.size.width = titleW+HOME_ROLE_IMAGE_SIZE;
    self.frame = frame;
}

+ (instancetype)btnWithImageName:(NSString *)imageName
                   highImageName:(NSString *)highImageName
                          target:(id)target
                          action:(SEL)action
{
    HomeRoleButton *btn = [[HomeRoleButton alloc]initWithFrame:CGRectMake(0, 0, 24, 24)];
    [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setNeedsLayout];
    [btn layoutIfNeeded];
    return btn;
}

@end
