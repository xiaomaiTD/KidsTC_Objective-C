//
//  RadishSettlementViewController.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/5.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishSettlementViewController.h"
#import "GHeader.h"

#import "RadishSettlementView.h"
#import "RadishSettlementModel.h"

@interface RadishSettlementViewController ()<RadishSettlementViewDelegate>
@property (nonatomic, strong) RadishSettlementView *settlementView;
@property (nonatomic, strong) RadishSettlementData *data;
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
    
    [self loadData];
}

- (void)loadData {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    //[param setObject:@"" forKey:@"userAddress"];
    [param setObject:@(1) forKey:@"buyNum"];
    //[param setObject:@"" forKey:@"place"];
    //[param setObject:@"" forKey:@"storeNo"];
    [TCProgressHUD showSVP];
    [Request startWithName:@"GET_RADISH_ORDER_CONFIRM" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        RadishSettlementData *data = [RadishSettlementModel modelWithDictionary:dic].data;
        [self loadDataSuccess:data];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self loadDataFailure:error];
    }];
}

- (void)loadDataSuccess:(RadishSettlementData *)data{
    _data = data;
    self.settlementView.data = data;
    
}

- (void)loadDataFailure:(NSError *)error {
    [[iToast makeText:@"商品信息查询失败"] show];
    [self back];
}

#pragma mark - RadishSettlementViewDelegate

- (void)radishSettlementView:(RadishSettlementView *)view actionType:(RadishSettlementViewActionType)type value:(id)value {
    
}

@end
