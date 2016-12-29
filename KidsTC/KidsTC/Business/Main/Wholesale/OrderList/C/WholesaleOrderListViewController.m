//
//  WholesaleOrderListViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleOrderListViewController.h"
#import "GHeader.h"
#import "RecommendDataManager.h"
#import "SegueMaster.h"
#import "OnlineCustomerService.h"

#import "WholesaleOrderListModel.h"
#import "WholesaleOrderListView.h"
#import "CommonShareViewController.h"
#import "WebViewController.h"
#import "WholesaleSettlementViewController.h"

@interface WholesaleOrderListViewController ()<WholesaleOrderListViewDelegate>
@property (nonatomic, strong) WholesaleOrderListView *listView;
@property (nonatomic, strong) NSArray<WholesaleOrderListItem *> *data;
@property (nonatomic, assign) NSInteger page;
@end

@implementation WholesaleOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"拼团";
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    WholesaleOrderListView *listView = [[WholesaleOrderListView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    listView.delegate = self;
    [self.view addSubview:listView];
    self.listView = listView;
}

#pragma mark - WholesaleOrderListViewDelegate

- (void)wholesaleOrderListView:(WholesaleOrderListView *)view actionType:(WholesaleOrderListViewActionType)type value:(id)value {
    switch (type) {
        case WholesaleOrderListViewActionTypeConnectService://在线客服
        {
            [self connectService:value];
        }
            break;
        case WholesaleOrderListViewActionTypeInvite://邀请好友
        {
            [self share:value];
        }
            break;
        case WholesaleOrderListViewActionTypeShare://分享
        {
            [self share:value];
        }
            break;
        case WholesaleOrderListViewActionTypePay://支付
        {
            [self pay:value];
        }
            break;
        case WholesaleOrderListViewActionTypeCountDownOver://倒计时结束
        {
            [self loadData:@(YES)];
        }
            break;
        case WholesaleOrderListViewActionTypeSegue:
        {
            [SegueMaster makeSegueWithModel:value fromController:self];
        }
            break;
        case WholesaleOrderListViewActionTypeLoadData://加载数据
        {
            [self loadData:value];
        }
            break;
    }
}

#pragma mark 在线客服

- (void)connectService:(id)value {
    NSString *str = [OnlineCustomerService onlineCustomerServiceLinkUrlString];
    WebViewController *controller = [[WebViewController alloc]init];
    controller.urlString = str;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark 分享

- (void)share:(id)value {
    if (![value isKindOfClass:[WholesaleOrderListItem class]]) return;
    WholesaleOrderListItem *item = value;
    CommonShareViewController *controller = [CommonShareViewController instanceWithShareObject:item.shareObject sourceType:KTCShareServiceTypeWholesale];
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark 我要组团

- (void)pay:(id)value {
    if (![value isKindOfClass:[WholesaleOrderListItem class]]) return;
    WholesaleOrderListItem *item = value;
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        WholesaleSettlementViewController *controller = [[WholesaleSettlementViewController alloc] init];
        controller.productId = item.fightGroupSysNo;
        controller.openGroupId = item.fightGroupOpenGroupSysNo;
        [self.navigationController pushViewController:controller animated:YES];
    }];
}

#pragma mark 加载数据

- (void)loadData:(id)value {
    if (![value respondsToSelector:@selector(boolValue)]) return;
    BOOL refresh = [value boolValue];
    if (!self.listView.noMoreOrderListData) {
        self.page = refresh?1:++self.page;
        NSDictionary *param = @{@"page":@(self.page),
                                @"pageCount":@(TCPAGECOUNT)};
        [Request startWithName:@"GET_USER_FIGHT_GROUP_ORDERS" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
            NSArray<WholesaleOrderListItem *> *data = [WholesaleOrderListModel modelWithDictionary:dic].data;
            if (refresh) {
                self.data = [NSArray arrayWithArray:data];
            }else{
                NSMutableArray *ary = [NSMutableArray arrayWithArray:self.data];
                [ary addObjectsFromArray:data];
                self.data = [NSArray arrayWithArray:ary];
            }
            self.listView.items = self.data;
            [self.listView dealWithUI:data.count isRecommend:NO];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [self.listView dealWithUI:0 isRecommend:NO];
        }];
    }else{
        [[RecommendDataManager shareRecommendDataManager] loadRecommendProductType:RecommendProductTypeOrderList refresh:refresh pageCount:TCPAGECOUNT productNos:nil successBlock:^(NSArray<RecommendProduct *> *data) {
            [self.listView dealWithUI:data.count isRecommend:YES];
        } failureBlock:^(NSError *error) {
            [self.listView dealWithUI:0 isRecommend:YES];
        }];
    }
}

@end
