//
//  UIBarButtonItem+Category.m
//  KidsTC
//
//  Created by 詹平 on 16/7/16.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "UIBarButtonItem+Category.h"
#import "Macro.h"
@interface UIBarButton :UIButton
@property (nonatomic, assign) UIBarButtonPosition postion;
@end
@implementation UIBarButton

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

- (UIEdgeInsets)alignmentRectInsets
{
    UIEdgeInsets insets;
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1){
        insets = UIEdgeInsetsZero;
    }else{
        
        switch (self.postion) {
            case UIBarButtonPositionNone:
            {
                insets = UIEdgeInsetsZero;
            }
                break;
            case UIBarButtonPositionLeft:
            {
                insets = UIEdgeInsetsMake(0, 6, 0, -6);
            }
                break;
            case UIBarButtonPositionRight:
            {
                self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
                insets = UIEdgeInsetsMake(0, -3, 0, 3);
            }
                break;
            case UIBarButtonPositionRightCenter:
            {
                insets = UIEdgeInsetsMake(0, -3, 0, 3);
            }
                break;
                
            default:
            {
                insets = UIEdgeInsetsZero;
            }
                break;
        }
    }
    return insets;
}
@end

@implementation UIBarButtonItem (Category)
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName
                         highImageName:(NSString *)highImageName
                               postion:(UIBarButtonPosition)postion
                                target:(id)target
                                action:(SEL)action
{
    UIBarButton *button = [[UIBarButton alloc] init];
    button.postion = postion;
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
    //CGSize size = button.currentImage.size;
    //button.bounds = CGRectMake(0, 0, size.width, size.height);
    button.bounds = CGRectMake(0, 0, 24, 24);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}
+ (UIBarButtonItem *)itemWithImagePostion:(UIBarButtonPosition)postion
                                   target:(id)target
                                   action:(SEL)action
                             andGetButton:(void(^)(UIButton *btn))getButton
{
    UIBarButton *button = [[UIBarButton alloc] init];
    button.postion = postion;
    //CGSize size = button.currentImage.size;
    //button.bounds = CGRectMake(0, 0, size.width, size.height);
    button.bounds = CGRectMake(0, 0, 24, 24);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    getButton(button);
    return item;
}
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title
                           postion:(UIBarButtonPosition)postion
                            target:(id)target
                            action:(SEL)action
{
    UIBarButton *button = [[UIBarButton alloc] init];
    button.postion = postion;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:COLOR_PINK_HIGHLIGHT forState:UIControlStateSelected];
    [button setTitle:title forState:UIControlStateNormal];
    UIFont *font = [UIFont systemFontOfSize:15];
    button.titleLabel.font = font;
    CGSize size = [button.currentTitle sizeWithAttributes:@{NSFontAttributeName:font}];
    button.bounds = CGRectMake(0, 0, size.width, 24);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title
                           postion:(UIBarButtonPosition)postion
                            target:(id)target
                            action:(SEL)action
                      andGetButton:(void(^)(UIButton *btn))getButton
{
    UIBarButton *button = [[UIBarButton alloc] init];
    button.postion = postion;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:COLOR_PINK_HIGHLIGHT forState:UIControlStateSelected];
    [button setTitle:title forState:UIControlStateNormal];
    UIFont *font = [UIFont systemFontOfSize:15];
    button.titleLabel.font = font;
    CGSize size = [button.currentTitle sizeWithAttributes:@{NSFontAttributeName:font}];
    button.bounds = CGRectMake(0, 0, size.width, 24);
    getButton(button);
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}
@end
