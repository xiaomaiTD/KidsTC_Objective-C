//
//  WholesaleOrderDetailViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleOrderDetailViewController.h"
#import "UIBarButtonItem+Category.h"

#import "WholesaleOrderDetailView.h"

@interface WholesaleOrderDetailViewController ()
@property (nonatomic, strong) WholesaleOrderDetailView *orderDetailView;
@end

@implementation WholesaleOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"拼团";
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    WholesaleOrderDetailView *orderDetailView = [[WholesaleOrderDetailView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    [self.view addSubview:orderDetailView];
    self.orderDetailView = orderDetailView;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImagePostion:UIBarButtonPositionRight target:self action:@selector(rightBarButtonItemAction:) andGetButton:^(UIButton *btn) {
        [btn setImageEdgeInsets:UIEdgeInsetsMake(3, 3, 3, 3)];
        [btn setImage:[UIImage imageNamed:@"wholesale_share"] forState:UIControlStateNormal];
    }];
}

- (void)rightBarButtonItemAction:(UIButton *)btn {
    TCLog(@"");
}

@end
