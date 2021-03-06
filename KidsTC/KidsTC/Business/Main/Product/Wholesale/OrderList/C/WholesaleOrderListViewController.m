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
#import "NSString+Category.h"

#import "WholesaleOrderListModel.h"
#import "WholesaleOrderListReplaceModel.h"
#import "WholesaleOrderListView.h"
#import "CommonShareViewController.h"
#import "WebViewController.h"
#import "CashierDeskViewController.h"
#import "CommentFoundingViewController.h"

@interface WholesaleOrderListViewController ()<WholesaleOrderListViewDelegate,CommentFoundingViewControllerDelegate>
@property (nonatomic, strong) WholesaleOrderListView *listView;
@property (nonatomic, strong) NSArray<WholesaleOrderListItem *> *data;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic,strong) WholesaleOrderListItem *currentItem;
@end

@implementation WholesaleOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"拼团订单";
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    WholesaleOrderListView *listView = [[WholesaleOrderListView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    listView.delegate = self;
    [self.view addSubview:listView];
    self.listView = listView;
}

#pragma mark - 更换单个Item

- (void)loadReplaceItem:(WholesaleOrderListItem *)item {
    
    NSString *orderId = item.orderNo;
    if (![orderId isNotNull]) {
        [[iToast makeText:@"订单编号为空"] show];
        return;
    }
    NSDictionary *param = @{@"orderNo":orderId};
    
    [Request startWithName:@"GET_USER_FIGHT_GROUP_ORDER_ITEM" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        WholesaleOrderListItem *replaceItem = [WholesaleOrderListReplaceModel modelWithDictionary:dic].data;
        if (replaceItem) [self loadReplaceItemSuccess:replaceItem];
    } failure:nil];
}

- (void)loadReplaceItemSuccess:(WholesaleOrderListItem *)item {
    NSString *orderId = item.orderNo;
    if (![orderId isNotNull]) {
        return;
    }
    __block NSInteger index = -1;
    NSMutableArray<WholesaleOrderListItem *> *items = [NSMutableArray arrayWithArray:self.data];
    [items enumerateObjectsUsingBlock:^(WholesaleOrderListItem  * obj, NSUInteger idx, BOOL *stop) {
        if ([obj.orderNo isNotNull]) {
            if ([obj.orderNo isEqualToString:orderId]) {
                index = idx;
                *stop = YES;
            }
        }
    }];
    if (index>=0) {
        [items removeObjectAtIndex:index];
        [items insertObject:item atIndex:index];
        self.data = [NSArray arrayWithArray:items];
        self.listView.items = self.data;
        [self.listView reloadData];
    }
}

#pragma mark - WholesaleOrderListViewDelegate

- (void)wholesaleOrderListView:(WholesaleOrderListView *)view actionType:(WholesaleOrderListViewActionType)type value:(id)value {
    if ([value isKindOfClass:[WholesaleOrderListItem class]]) self.currentItem = value;
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
        case WholesaleOrderListViewActionTypeConsumeCode://消费码
        {
            [self consumeCode:value];
        }
            break;
        case WholesaleOrderListViewActionTypeComment://评论
        {
            [self comment:value];
        }
            break;
        case WholesaleOrderListViewActionTypeCountDownOver://倒计时结束
        {
            [self countDownOver:value];
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
        CashierDeskViewController *controller = [[CashierDeskViewController alloc] initWithNibName:@"CashierDeskViewController" bundle:nil];
        controller.orderId = item.orderNo;
        controller.productId = item.fightGroupSysNo;
        controller.openGroupId = item.fightGroupOpenGroupSysNo;
        controller.productType = ProductDetailTypeWholesale;
        controller.resultBlock = ^(BOOL success){
            if(success)[self loadReplaceItem:self.currentItem];
        };
        [self.navigationController pushViewController:controller animated:YES];
    }];
}

#pragma mark 消费码
- (void)consumeCode:(id)value {
    if (![value isKindOfClass:[WholesaleOrderListItem class]]) return;
    WholesaleOrderListItem *item = value;
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        NSString *orderId = item.orderNo;
        if (![orderId isNotNull]) {
            [[iToast makeText:@"订单编号为空"] show];
            return;
        }
        NSDictionary *param = @{@"orderId":orderId};
        [TCProgressHUD showSVP];
        [Request startWithName:@"ORDER_SEND_CONSUME_CODE" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
            [TCProgressHUD dismissSVP];
            [[iToast makeText:@"消费码已发到您的手机，请注意查收"] show];
            [self loadReplaceItem:self.currentItem];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [TCProgressHUD dismissSVP];
            NSString *msg = @"获取消费码失败";
            NSString *errMsg = [NSString stringWithFormat:@"%@",error.userInfo[@"data"]];
            if ([errMsg isNotNull]) {
                msg = errMsg;
            }
            [[iToast makeText:msg] show];
        }];
    }];
}

#pragma mark 评论
- (void)comment:(id)value {
    if (![value isKindOfClass:[WholesaleOrderListItem class]]) return;
    WholesaleOrderListItem *item = value;
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        CommentFoundingViewController *controller = [[CommentFoundingViewController alloc] initWithCommentFoundingModel:[CommentFoundingModel modelFromWholesaleOrderListItem:item]];
        controller.delegate = self;
        [self.navigationController pushViewController:controller animated:YES];
    }];
}

#pragma mark CommentFoundingViewControllerDelegate

- (void)commentFoundingViewControllerDidFinishSubmitComment:(CommentFoundingViewController *)vc {
    [self loadReplaceItem:self.currentItem];
}

#pragma mark CountDownOver

- (void)countDownOver:(id)value {
    [self loadReplaceItem:self.currentItem];
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
