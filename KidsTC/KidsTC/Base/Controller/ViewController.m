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
        switch (_naviTheme) {
            case NaviThemePink:
            {
                _naviColor = COLOR_PINK;
            }
                break;
            case NaviThemeWihte:
            {
                _naviColor = [UIColor whiteColor];
            }
                break;
        }
    }
    return _naviColor;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.naviTheme = NaviThemePink;
    
    [NotificationCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [NotificationCenter addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    [NotificationCenter addObserver:self selector:@selector(reachabilityStatusChange:) name:kReachabilityStatusChangeNoti object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self setupNaviTheme:_naviTheme];
    
    [self checkNetWork];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    
    [TCProgressHUD dismissSVP];
    [TCProgressHUD dismiss];
    
    //防止子类切换页面时造成crash
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
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

- (void)setupNaviTheme:(NaviTheme)theme
{
    UIStatusBarStyle style;
    UIColor *titleColor;
    UIColor *normalColor, *highlightColor, *disabledColor;
    NSString *backImageName, *backHighImageName;
    switch (theme) {
        case NaviThemePink:
        {
            style = UIStatusBarStyleLightContent;
            
            titleColor = [UIColor whiteColor];
            
            normalColor = [UIColor whiteColor];
            highlightColor = COLOR_PINK_HIGHLIGHT;
            disabledColor = [UIColor lightGrayColor];
            
            [self removeNaviShadow];
            
            backImageName = @"navigation_back_n";
            backHighImageName = @"navigation_back_n";
        }
            break;
        case NaviThemeWihte:
        {
            style = UIStatusBarStyleDefault;
            
            titleColor = [UIColor blackColor];
            
            normalColor = [UIColor blackColor];
            highlightColor = [UIColor blackColor];
            disabledColor = [UIColor lightGrayColor];
            
            [self addNaviShadow];
            
            backImageName = @"navi_back_black";
            backHighImageName = @"navi_back_black";
        }
            break;
    }
    
    [[UIApplication sharedApplication] setStatusBarStyle:style animated:YES];
    
    [self setupNaviBar:titleColor];
    
    [self setupBarItems:self.navigationItem.rightBarButtonItems
            normalColor:normalColor
         highlightColor:highlightColor
          disabledColor:disabledColor];
    
    [self setupBarItems:self.navigationItem.leftBarButtonItems
            normalColor:normalColor
         highlightColor:highlightColor
          disabledColor:disabledColor];
    
    [self setNavigationBarColor];
    
    [self setupBackItem:backImageName highImageName:backHighImageName];
}

- (void)setupNaviBar:(UIColor *)titleColor
{
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    NSDictionary *textAttrs = @{NSForegroundColorAttributeName:titleColor,NSFontAttributeName:[UIFont systemFontOfSize:19]};
    [navigationBar setTitleTextAttributes:textAttrs];
}

- (void)setupBarItems:(NSArray<UIBarButtonItem *> *)items
          normalColor:(UIColor *)normalColor
       highlightColor:(UIColor *)highlightColor
        disabledColor:(UIColor *)disabledColor
{
    [items enumerateObjectsUsingBlock:^(UIBarButtonItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDictionary *textAttrs = @{NSForegroundColorAttributeName:normalColor,NSFontAttributeName:[UIFont systemFontOfSize:15]};
        [obj setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
        
        NSDictionary *highTextAttrs = @{NSForegroundColorAttributeName:highlightColor};
        [obj setTitleTextAttributes:highTextAttrs forState:UIControlStateHighlighted];
        
        NSDictionary *disableTextAttrs = @{NSForegroundColorAttributeName:disabledColor};
        [obj setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
        
    }];
}

- (void)addNaviShadow {
//    CALayer *layer = self.navigationController.navigationBar.layer;
//    layer.shadowColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
//    layer.shadowOffset = CGSizeMake(0, 4);
//    layer.shadowRadius = 2;
//    layer.shadowOpacity = 0.5;
}

- (void)removeNaviShadow {
//    CALayer *layer = self.navigationController.navigationBar.layer;
//    layer.shadowColor = [UIColor clearColor].CGColor;
//    layer.shadowOffset = CGSizeZero;
//    layer.shadowRadius = 0;
//    layer.shadowOpacity = 0;
}

- (void)setNavigationBarColor{
    if (self.navigationController) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:self.naviColor] forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)setupBackItem:(NSString *)imageName
        highImageName:(NSString *)highImageName
{
    if (self.navigationController.viewControllers.count > 1) {
        self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImagePostion:UIBarButtonPositionLeft target:self action:@selector(back) andGetButton:^(UIButton *btn) {
            [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            [btn setImage:[UIImage imageNamed:highImageName] forState:UIControlStateHighlighted];
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
            btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
            self.backBtn = btn;
        }];
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
    [NotificationCenter removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [NotificationCenter removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [NotificationCenter removeObserver:self name:kReachabilityStatusChangeNoti object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark Notification
- (void)keyboardWillShow:(NSNotification *)noti {
    NSDictionary *info = [noti userInfo];
    _keyboardHeight = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
}

- (void)keyboardWillDisappear:(NSNotification *)noti {
}

- (void)reachabilityStatusChange:(NSNotification *)noti {
    [self checkNetWork];
}

- (void)checkNetWork {
    if (!_showFailurePage) {
        return;
    }
    [self loadDataFailureAction:YES];
}

- (void)loadDataFailureAction:(BOOL)needCheckNetwork{
    
    if (needCheckNetwork) {
        AFNetworkReachabilityStatus status = [ReachabilityManager shareReachabilityManager].status;
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
            {
                [self showFailureView];
            }
                break;
            default:break;
        }
    }else{
        [self showFailureView];
    }
}

- (void)showFailureView {
    [[FailureViewManager shareFailureViewManager] showType:FailureViewTypeLoadData
                                                    inView:self.view
                                               actionBlock:^(FailureViewManagerActionType type, id obj) {
                                                   switch (type) {
                                                       case FailureViewManagerActionTypeWebView:
                                                       {
                                                           if (self.failurePageActionBlock) {
                                                               self.failurePageActionBlock();
                                                           }
                                                       }
                                                           break;
                                                       case FailureViewManagerActionTypeRefrech:
                                                       {
                                                           if (self.failurePageActionBlock) {
                                                               self.failurePageActionBlock();
                                                           }
                                                       }
                                                           break;
                                                       case FailureViewManagerActionTypeCheckNetwork:
                                                       {
                                                            [self checkNetWork];
                                                       }
                                                           break;
                                                   }
                                               }];
}

@end
