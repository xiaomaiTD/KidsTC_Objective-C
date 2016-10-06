//
//  UIBarButtonItem+Category.h
//  KidsTC
//
//  Created by 詹平 on 16/7/16.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    UIBarButtonPositionNone,
    UIBarButtonPositionLeft,
    UIBarButtonPositionRight,
    UIBarButtonPositionRightCenter
} UIBarButtonPosition;

@interface UIBarButtonItem (Category)
+ (UIBarButtonItem *)itemWithImageName:(NSString *)imageName
                         highImageName:(NSString *)highImageName
                               postion:(UIBarButtonPosition)postion
                                target:(id)target
                                action:(SEL)action;
+ (UIBarButtonItem *)itemWithImagePostion:(UIBarButtonPosition)postion
                                   target:(id)target
                                   action:(SEL)action
                             andGetButton:(void(^)(UIButton *btn))getButton;
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title
                           postion:(UIBarButtonPosition)postion
                            target:(id)target
                            action:(SEL)action;
+ (UIBarButtonItem *)itemWithTitle:(NSString *)title
                           postion:(UIBarButtonPosition)postion
                            target:(id)target
                            action:(SEL)action
                      andGetButton:(void(^)(UIButton *btn))getButton;
@end
