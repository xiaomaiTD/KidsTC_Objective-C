//
//  RadishSettlementViewController.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/5.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishSettlementViewController.h"

#import "RadishSettlementView.h"

@interface RadishSettlementViewController ()<RadishSettlementViewDelegate>
@property (nonatomic, strong) RadishSettlementView *settlementView;
@end

@implementation RadishSettlementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"结算";
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    RadishSettlementView *settlementView = [[RadishSettlementView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    settlementView.delegate = self;
    [self.view addSubview:settlementView];
    self.settlementView = settlementView;
    
}


#pragma mark - RadishSettlementViewDelegate

- (void)radishSettlementView:(RadishSettlementView *)view actionType:(RadishSettlementViewActionType)type value:(id)value {
    
}

@end
