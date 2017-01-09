//
//  RadishMallViewController.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/5.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishMallViewController.h"

#import "RadishMallView.h"

@interface RadishMallViewController ()<RadishMallViewDelegate>
@property (nonatomic, strong) RadishMallView *mallView;
@end

@implementation RadishMallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"每日种萝卜";
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    RadishMallView *mallView = [[RadishMallView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    mallView.delegate = self;
    [self.view addSubview:mallView];
    self.mallView = mallView;
}

#pragma mark - RadishMallViewDelegate

- (void)radishMallView:(RadishMallView *)view actionType:(RadishMallViewActionType)type value:(id)value {
    switch (type) {
        case RadishMallViewActionTypeSegue:
        {
            
        }
            break;
            
        default:
            break;
    }
}

@end
