//
//  WholesaleSettlementViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleSettlementViewController.h"
#import "UIBarButtonItem+Category.h"

#import "WholesaleSettlementView.h"

@interface WholesaleSettlementViewController ()
@property (nonatomic, strong) WholesaleSettlementView *settlementView;
@end

@implementation WholesaleSettlementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"拼团";
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    WholesaleSettlementView *settlementView = [[WholesaleSettlementView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    [self.view addSubview:settlementView];
    self.settlementView = settlementView;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImagePostion:UIBarButtonPositionRight target:self action:@selector(rightBarButtonItemAction:) andGetButton:^(UIButton *btn) {
        [btn setImageEdgeInsets:UIEdgeInsetsMake(3, 3, 3, 3)];
        [btn setImage:[UIImage imageNamed:@"wholesale_share"] forState:UIControlStateNormal];
    }];
}

- (void)rightBarButtonItemAction:(UIButton *)btn {
    TCLog(@"");
}

@end
