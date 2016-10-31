//
//  NavigationController.m
//  KidsTC
//
//  Created by 詹平 on 16/7/15.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "NavigationController.h"
#import "UIImage+Category.h"
#import "UIBarButtonItem+Category.h"
#import "Macro.h"

@interface NavigationController ()

@end

@implementation NavigationController

#pragma mark - override

+ (void)initialize
{
    [self setupNavigationBarTheme];
    
    [self setupBarButtonItemTheme];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    //self.hidesBarsOnSwipe = YES;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count>0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:YES];
}

#pragma mark - helpers

+ (void)setupNavigationBarTheme
{
    UINavigationBar *appearance = [UINavigationBar appearance];
    [appearance setBackgroundImage:[UIImage imageWithColor:COLOR_PINK] forBarMetrics:UIBarMetricsDefault];
    [appearance setShadowImage:[UIImage new]];
    [appearance setTranslucent:YES];
    [appearance setBarStyle:UIBarStyleDefault];
    [appearance setTintColor:[UIColor whiteColor]];
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:19];
    [appearance setTitleTextAttributes:textAttrs];
}

+ (void)setupBarButtonItemTheme
{
    UIBarButtonItem *appearance = [UIBarButtonItem appearance];
    
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    [appearance setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    highTextAttrs[NSForegroundColorAttributeName] = COLOR_PINK_HIGHLIGHT;
    [appearance setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
    
    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [appearance setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
}


#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
