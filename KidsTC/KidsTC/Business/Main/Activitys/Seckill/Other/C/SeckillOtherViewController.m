//
//  SeckillOtherViewController.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/11.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "SeckillOtherViewController.h"
#import "SegueMaster.h"
#import "SeckillOtherView.h"
#import "TabBarController.h"

@interface SeckillOtherViewController ()<SeckillOtherViewDelegate>
@property (weak, nonatomic) IBOutlet SeckillOtherView *otherView;
@end

@implementation SeckillOtherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor clearColor];
    self.otherView.data = self.data;
    self.otherView.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.otherView show];
}

#pragma mark - SeckillOtherViewDelegate

- (void)seckillOtherView:(SeckillOtherView *)view actionType:(SeckillOtherViewActionType)type value:(id)value {
    switch (type) {
        case SeckillOtherViewActionTypeDidSelectItem:
        {
            [self didSelectItem:value];
        }
            break;
        case SeckillOtherViewActionTypeDidHide:
        {
            [self hide];
        }
            break;
    }
}

- (void)didSelectItem:(id)value {
    if (![value isKindOfClass:[SeckillOtherFloorItem class]]) {
        return;
    }
    SeckillOtherFloorItem *item = value;
    UINavigationController *navi = [TabBarController shareTabBarController].selectedViewController;
    UIViewController *controller = navi.topViewController;
    [SegueMaster makeSegueWithModel:item.content.segueModel fromController:controller];
    [self hide];
}

- (void)hide {
    [self.otherView hide:^(BOOL finish) {
        [self back];
    }];
}

@end
