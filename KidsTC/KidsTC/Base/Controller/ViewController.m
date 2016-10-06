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
#import "MTA.h"
#import "UMMobClick/MobClick.h"
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
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    //防止子类切换页面时造成crash
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.pageId.length>0) {
        [MTA trackPageViewBegin:self.pageId];
        [MobClick beginLogPageView:self.pageId];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (self.pageId.length>0) {
        [MTA trackPageViewEnd:self.pageId];
        [MobClick endLogPageView:self.pageId];
    }
}

- (BOOL)prefersStatusBarHidden{
    return self.navigationController==nil;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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
