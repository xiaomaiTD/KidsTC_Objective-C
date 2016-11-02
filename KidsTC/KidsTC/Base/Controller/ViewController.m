//
//  ViewController.m
//  KidsTC
//
//  Created by 詹平 on 16/7/16.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "ViewController.h"
#import "Macro.h"
#import "UIImage+Category.h"
#import "UIBarButtonItem+Category.h"
#import "BuryPointManager.h"
#import "NSString+Category.h"
#import "TCProgressHUD.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize naviColor = _naviColor;

- (void)setNaviColor:(UIColor *)naviColor{
    _naviColor = naviColor;
    [self setNavigationBarColor];
}

- (UIColor *)naviColor{
    if (!_naviColor) {
        _naviColor = COLOR_PINK;
    }
    return _naviColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupBackItem];
    
    //keyboard
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [self setNavigationBarColor];
    }
    
    [self setupNavigationBarTheme];
    [self setupBarButtonItemTheme];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    
    [TCProgressHUD dismissSVP];
    [TCProgressHUD dismiss];
    
    //防止子类切换页面时造成crash
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    
    [self setupNavigationBarTheme];
    [self setupBarButtonItemTheme];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.pageId>0) {
        if (![_pageUid isNotNull]) {
            _pageUid = [NSString stringWithFormat:@"%zd%zd",_pageId,[self getRandomNumber:100000 to:999999]];
        }
        [BuryPointManager trackBegin:_pageId pageUid:_pageUid pageName:_pageName params:_trackParams];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (self.pageId>0 && [_pageUid isNotNull]) {
        [BuryPointManager trackEnd:_pageId pageUid:_pageUid pageName:_pageName params:_trackParams];
    }
}

- (void)setupNavigationBarTheme
{
    UINavigationBar *appearance = self.navigationController.navigationBar;
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:19];
    [appearance setTitleTextAttributes:textAttrs];
}

- (void)setupBarButtonItemTheme
{
    [self.navigationItem.rightBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
        textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
        textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
        [obj setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
        
        NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
        highTextAttrs[NSForegroundColorAttributeName] = COLOR_PINK_HIGHLIGHT;
        [obj setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
        
        NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
        disableTextAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
        [obj setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    }];
    
    [self.navigationItem.leftBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
        textAttrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
        textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
        [obj setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
        
        NSMutableDictionary *highTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
        highTextAttrs[NSForegroundColorAttributeName] = COLOR_PINK_HIGHLIGHT;
        [obj setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
        
        NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionaryWithDictionary:textAttrs];
        disableTextAttrs[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
        [obj setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    }];
}

- (int)getRandomNumber:(int)from to:(int)to{
    return (int)(from + arc4random() % (to - from + 1));
}

- (BOOL)prefersStatusBarHidden{
    return self.navigationController==nil;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)dealloc{
    TCLog(@"%@挂掉了...",NSStringFromClass([self class]));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -

- (void)setNavigationBarColor{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:self.naviColor] forBarMetrics:UIBarMetricsDefault];
}

- (void)setupBackItem{
    if (self.navigationController.viewControllers.count > 1) {
        self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navigation_back_n"
                                                                     highImageName:@"navigation_back_h"
                                                                           postion:UIBarButtonPositionLeft
                                                                            target:self
                                                                            action:@selector(back)];
        self.hidesBottomBarWhenPushed = YES;
    }
}

- (void)back{
    if (self.navigationController.viewControllers.count>1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark Keyboard Notification
- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    _keyboardHeight = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
}

- (void)keyboardWillDisappear:(NSNotification *)notification {
}

@end
