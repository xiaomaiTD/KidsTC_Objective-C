//
//  OrderListViewController.m
//  KidsTC
//
//  Created by 钱烨 on 7/8/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//

#import "OrderListViewController.h"

#import "CommentFoundingViewController.h"
#import "KTCPaymentService.h"
#import "OrderRefundViewController.h"
#import "CashierDeskViewController.h"
#import "OrderListViewModel.h"
#import "GHeader.h"
#import "ServiceOrderDetailViewController.h"
#import "BuryPointManager.h"
#import "NSString+Category.h"


@interface OrderListViewController () <OrderListViewDelegate, CommentFoundingViewControllerDelegate, OrderRefundViewControllerDelegate,ServiceOrderDetailViewControllerDelegate>

@property (weak, nonatomic) IBOutlet OrderListView *orderListView;

@property (nonatomic, strong) OrderListViewModel *viewModel;

@property (nonatomic, assign) OrderListType listType;

@property (nonatomic, assign) BOOL needRefresh;

@end

@implementation OrderListViewController

- (instancetype)initWithOrderListType:(OrderListType)type {
    self = [super initWithNibName:@"OrderListViewController" bundle:nil];
    if (self) {
        self.listType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageId = 11001;
    NSString *title;
    switch (self.listType) {
        case OrderListTypeAll:
        {
            title = @"全部订单";
        }
            break;
        case OrderListTypeWaitingPayment:
        {
            title = @"待支付订单";
        }
            break;
        case OrderListTypeWaitingUse:
        {
            title = @"待使用订单";
        }
            break;
        case OrderListTypeRefund:
        {
            title = @"退款订单";
        }
            break;
        default:
        {
            title = @"订单列表";
        }
            break;
    }
    self.navigationItem.title = title;
    
    self.orderListView.delegate = self;
    self.viewModel = [[OrderListViewModel alloc] initWithView:self.orderListView];
    [self.viewModel setOrderListType:self.listType];

    [TCProgressHUD showSVP];
    [self.viewModel startUpdateDataWithSucceed:^(NSDictionary *data) {
        [TCProgressHUD dismissSVP];
    } failure:^(NSError *error) {
        [TCProgressHUD dismissSVP];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.needRefresh) {
        [TCProgressHUD showSVP];
        [self.viewModel startUpdateDataWithSucceed:^(NSDictionary *data) {
            [TCProgressHUD dismissSVP];
        } failure:^(NSError *error) {
            [TCProgressHUD dismissSVP];
        }];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [TCProgressHUD dismissSVP];
}


#pragma mark OrderListViewDelegate

- (void)orderListViewDidPullDownToRefresh:(OrderListView *)listView {
    [self.viewModel startUpdateDataWithSucceed:nil failure:nil];
}

- (void)orderListViewDidPullUpToLoadMore:(OrderListView *)listView {
    [self.viewModel getMoreOrders];
}

- (void)orderListView:(OrderListView *)listView didSelectAtIndex:(NSUInteger)index {
    NSArray *modelArray = [self.viewModel orderModels];
    if ([modelArray count] > index) {
        OrderListModel *model = [modelArray objectAtIndex:index];
        ServiceOrderDetailViewController *controller = [[ServiceOrderDetailViewController alloc]init];
        controller.orderId = model.orderId;
        controller.delegate = self;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)orderListView:(OrderListView *)listView didClickedPayButtonAtIndex:(NSUInteger)index {
    OrderListModel *model = [self.viewModel.orderModels objectAtIndex:index];
    CashierDeskViewController *controller = [[CashierDeskViewController alloc]initWithNibName:@"CashierDeskViewController" bundle:nil];
    controller.orderId = model.orderId;
    controller.orderKind = CashierDeskOrderKindService;
    controller.resultBlock = ^void (BOOL needRefresh){
        self.needRefresh = needRefresh;
    };
    [self.navigationController pushViewController:controller animated:YES];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if ([model.orderId isNotNull]) {
        [params setValue:model.orderId forKey:@"orderId"];
    }
    [BuryPointManager trackEvent:@"event_skip_orderlist_pay" actionId:21601 params:params];
}

- (void)orderListView:(OrderListView *)listView didClickedCommentButtonAtIndex:(NSUInteger)index {
    OrderListModel *model = [self.viewModel.orderModels objectAtIndex:index];
    CommentFoundingViewController *controller = [[CommentFoundingViewController alloc] initWithCommentFoundingModel:[CommentFoundingModel modelFromServiceOrderModel:model]];
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)orderListView:(OrderListView *)listView didClickedReturnButtonAtIndex:(NSUInteger)index {
    OrderListModel *model = [self.viewModel.orderModels objectAtIndex:index];
    OrderRefundViewController *controller = [[OrderRefundViewController alloc] initWithOrderId:model.orderId];
    controller.delegate = self;
    [controller setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark CommentFoundingViewControllerDelegate

- (void)commentFoundingViewControllerDidFinishSubmitComment:(CommentFoundingViewController *)vc {
    [self.viewModel startUpdateDataWithSucceed:nil failure:nil];
}

#pragma mark OrderRefundViewControllerDelegate

- (void)orderRefundViewController:(OrderRefundViewController *)vc didSucceedWithRefundForOrderId:(NSString *)identifier {
    [self.viewModel startUpdateDataWithSucceed:nil failure:nil];
}

#pragma mark ServiceOrderDetailViewControllerDelegate

- (void)serviceOrderDetailStateChanged:(NSString *)orderId needRefresh:(BOOL)needRefresh {
    self.needRefresh = needRefresh;
}

@end
