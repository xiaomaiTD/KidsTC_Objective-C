//
//  RadishProductOrderListViewController.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/5.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishProductOrderListViewController.h"
#import "UIBarButtonItem+Category.h"
#import "GHeader.h"
#import "NSString+Category.h"
#import "OnlineCustomerService.h"
#import "SegueMaster.h"
#import "AppBaseManager.h"
#import "RecommendDataManager.h"

#import "RadishProductOrderListModel.h"
#import "RadishProductOrderListReplaceModel.h"
#import "RadishProductOrderListView.h"

#import "CashierDeskViewController.h"
#import "ServiceSettlementViewController.h"
#import "OrderBookingViewController.h"
#import "CommentFoundingViewController.h"
#import "WebViewController.h"
#import "StoreDetailViewController.h"
#import "FlashServiceOrderListViewController.h"
#import "WholesaleOrderListViewController.h"
#import "AppointmentOrderListViewController.h"
#import "ProductOrderFreeListViewController.h"
#import "NotificationCenterViewController.h"
#import "OrderRefundViewController.h"
#import "ProductDetailTicketSelectSeatViewController.h"

@interface RadishProductOrderListViewController ()<RadishProductOrderListViewDelegate,CommentFoundingViewControllerDelegate,OrderRefundViewControllerDelegate>
@property (nonatomic, strong) RadishProductOrderListView *listView;
@property (nonatomic, strong) NSArray<RadishProductOrderListItem *> *items;
@property (nonatomic, strong) RadishProductOrderListItem *currentItem;
@property (nonatomic, assign) NSInteger page;
@end

@implementation RadishProductOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"萝卜订单";
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.pageId = 11303;
    
    RadishProductOrderListView *listView = [[RadishProductOrderListView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    listView.delegate = self;
    [self.view addSubview:listView];
    self.listView = listView;
}

#pragma mark - 更换单个Item

- (void)loadReplaceItem:(RadishProductOrderListItem *)item {
    
    NSString *orderId = item.orderNo;
    if (![orderId isNotNull]) {
        [[iToast makeText:@"订单编号为空"] show];
        return;
    }
    NSDictionary *param = @{@"orderNo":orderId};
    [Request startWithName:@"GET_RADISH_ORDER_LIST_ITEM" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        RadishProductOrderListItem *replaceItem = [RadishProductOrderListReplaceModel modelWithDictionary:dic].data;
        if (replaceItem) [self loadReplaceItemSuccess:replaceItem];
    } failure:nil];
}

- (void)loadReplaceItemSuccess:(RadishProductOrderListItem *)item {
    NSString *orderId = item.orderNo;
    if (![orderId isNotNull]) {
        return;
    }
    __block NSInteger index = -1;
    NSMutableArray<RadishProductOrderListItem *> *items = [NSMutableArray arrayWithArray:self.items];
    [items enumerateObjectsUsingBlock:^(RadishProductOrderListItem  * obj, NSUInteger idx, BOOL *stop) {
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
        self.listView.items = [NSArray arrayWithArray:items];
        [self.listView reloadData];
    }
}

#pragma mark - RadishProductOrderListViewDelegate

- (void)radishProductOrderListView:(RadishProductOrderListView *)view actionType:(RadishProductOrderListViewActionType)type value:(id)value {
    if ([value isKindOfClass:[RadishProductOrderListItem class]]) self.currentItem = value;
    switch (type) {
        case RadishProductOrderListViewActionTypePay:/// 付款
        {
            [self payNow:value];
        }
            break;
        case RadishProductOrderListViewActionTypeCancelOrder:/// 取消订单
        {
            [self cancleOrder:value];
        }
            break;
        case RadishProductOrderListViewActionTypeConnectService:/// 联系客服
        {
            [self connectService:value];
        }
            break;
        case RadishProductOrderListViewActionTypeConnectSupplier:/// 联系商家
        {
            [self connectSupplier:value];
        }
            break;
        case RadishProductOrderListViewActionTypeConsumeCode:/// 取票码
        {
            [self consumeCode:value];
        }
            break;
        case RadishProductOrderListViewActionTypeReserve:/// 我要预约
        {
            [self connectSupplier:value];
        }
            break;
        case RadishProductOrderListViewActionTypeCancelTip:/// 取消提醒
        {
            [self tip:value want:NO];
        }
            break;
        case RadishProductOrderListViewActionTypeWantTip:/// 活动提醒
        {
            [self tip:value want:YES];
        }
            break;
        case RadishProductOrderListViewActionTypeReminder:/// 我要催单
        {
            [self reminder:value];
        }
            break;
        case RadishProductOrderListViewActionTypeConfirmDeliver:/// 确认收货
        {
            [self confirmDeliver:value];
        }
            break;
        case RadishProductOrderListViewActionTypeEvaluate:/// 评价
        {
            [self comment:value];
        }
            break;
        case RadishProductOrderListViewActionTypeBuyAgain:/// 再次购买
        {
            [self buyAgain:value];
        }
            break;
        case RadishProductOrderListViewActionTypeComplaint:/// 投诉
        {
            [self connectService:value];
        }
            break;
        case RadishProductOrderListViewActionTypeRefund://申请退款
        {
            [self refund:value];
        }
            break;
        case RadishProductOrderListViewActionTypeCountDownOver://倒计时结束
        {
            [self loadReplaceItem:self.currentItem];
        }
            break;
        case RadishProductOrderListViewActionTypeStore://门店详情
        {
            [self storeInfo:value];
        }
            break;
        case RadishProductOrderListViewActionTypeSegue://通用跳转
        {
            [SegueMaster makeSegueWithModel:value fromController:self];
        }
            break;
        case RadishProductOrderListViewActionTypeCall://打电话
        {
            [self call:value];
        }
            break;
        case RadishProductOrderListViewActionTypeLoadData://加载数据
        {
            [self loadData:[value boolValue]];
        }
            break;
    }
}

#pragma mark ================立即支付================

- (void)payNow:(RadishProductOrderListItem *)item {
    
    CashierDeskViewController *controller = [[CashierDeskViewController alloc]initWithNibName:@"CashierDeskViewController" bundle:nil];
    controller.orderId = item.orderNo;
    controller.productType = ProductDetailTypeRadish;
    controller.resultBlock = ^void (BOOL needRefresh){
        if (needRefresh) [self loadReplaceItem:item];
    };
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark ================取消订单================

- (void)cancleOrder:(RadishProductOrderListItem *)item {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"" message:@"您真的要取消订单么？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"不取消了" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"忍痛取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self cancelOrderRequest:item.orderNo];
    }];
    [controller addAction:cancelAction];
    [controller addAction:confirmAction];
    [self presentViewController:controller animated:YES completion:nil];
    
}
- (void)cancelOrderRequest:(NSString *)orderId {
    if (![orderId isNotNull]) {
        [[iToast makeText:@"订单编号为空"] show];
        return;
    }
    NSDictionary *param = @{@"orderid":orderId};
    [Request startWithName:@"ORDER_CANCLE_ORDER" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [self cancelOrderSucceed:dic];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self cancelOrderFailed:error];
    }];
}
- (void)cancelOrderSucceed:(NSDictionary *)data {
    [[iToast makeText:@"取消订单成功"] show];
    [self loadReplaceItem:self.currentItem];
}
- (void)cancelOrderFailed:(NSError *)error {
    [[iToast makeText:@"取消订单失败"] show];
}

#pragma mark ================联系客服================

- (void)connectService:(RadishProductOrderListItem *)item {
    NSString *str = [OnlineCustomerService onlineCustomerServiceLinkUrlString];
    WebViewController *controller = [[WebViewController alloc]init];
    controller.urlString = str;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark ================联系商家================

- (void)connectSupplier:(RadishProductOrderListItem *)item {
    NSArray *phones = item.supplierPhones;
    if (phones && phones.count == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", phones[0]]]];
    }else if (phones && phones.count > 1){
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"请选择客服电话" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        for (NSString *phone in phones) {
            UIAlertAction *phoneAction = [UIAlertAction actionWithTitle:phone style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", phone]]];
            }];
            [controller addAction:phoneAction];
        }
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [controller addAction:cancelAction];
        [self presentViewController:controller animated:YES completion:nil];
    }else{
        [[iToast makeText:@"该商家暂无联系方式，您可以选择联系客服"] show];
    }
}

#pragma mark ================获取消费码================

- (void)consumeCode:(RadishProductOrderListItem *)item{
    NSString *orderId = item.orderNo;
    if (![orderId isNotNull]) {
        [[iToast makeText:@"订单编号为空"] show];
        return;
    }
    NSDictionary *param = @{@"orderId":orderId};
    [Request startWithName:@"ORDER_SEND_CONSUME_CODE" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [[iToast makeText:@"消费码已发到您的手机，请注意查收"] show];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSString *msg = @"获取消费码失败";
        NSString *errMsg = [NSString stringWithFormat:@"%@",error.userInfo[@"data"]];
        if ([errMsg isNotNull]) {
            msg = errMsg;
        }
        [[iToast makeText:msg] show];
    }];
}

#pragma mark ================我要预约================

- (void)booking:(RadishProductOrderListItem *)item {
    
    OrderBookingViewController *controller = [[OrderBookingViewController alloc]init];
    controller.orderNo = item.orderNo;
    controller.mustEdit = NO;
    controller.successBlock = ^void(){
        [self loadReplaceItem:item];
    };
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark ================活动提醒================

- (void)tip:(RadishProductOrderListItem *)item want:(BOOL)want {
    NSString *orderId = item.orderNo;
    if (![orderId isNotNull]) {
        [[iToast makeText:@"订单编号为空"] show];
        return;
    }
    OrderRemindType type = want?OrderRemindTypeTip:OrderRemindTypeCancle;
    NSDictionary *param = @{@"orderId":orderId,
                            @"type":@(type)};
    [Request startWithName:@"ORDER_REMIND" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        NSString *msg = want?@"提醒成功":@"已取消提醒";
        [[iToast makeText:msg] show];
        [self loadReplaceItem:item];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSString *msg = want?@"设置提醒失败，请稍后再试":@"取消提醒失败，请稍后再试";
        [[iToast makeText:msg] show];
    }];
}

#pragma mark ================我要催单================

- (void)reminder:(RadishProductOrderListItem *)item {
    NSString *orderId = item.orderNo;
    if (![orderId isNotNull]) {
        [[iToast makeText:@"订单编号为空"] show];
        return;
    }
    NSDictionary *param = @{@"orderId":orderId};
    [Request startWithName:@"URGE_ORDER" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [[iToast makeText:@"催单成功"] show];
        [self loadReplaceItem:item];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSString *msg = @"催单失败";
        NSString *errMsg = [NSString stringWithFormat:@"%@",error.userInfo[@"data"]];
        if ([errMsg isNotNull]) msg = errMsg;
        [[iToast makeText:msg] show];
    }];
}

#pragma mark ================确认收货================

- (void)confirmDeliver:(RadishProductOrderListItem *)item {
    NSString *orderId = item.orderNo;
    if (![orderId isNotNull]) {
        [[iToast makeText:@"订单编号为空"] show];
        return;
    }
    NSDictionary *param = @{@"orderId":orderId};
    [Request startWithName:@"CONFIRM_ORDER_DELIVER_RECEIVED" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [[iToast makeText:@"确认收货成功"] show];
        [self loadReplaceItem:item];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSString *msg = @"确认收货失败";
        NSString *errMsg = [NSString stringWithFormat:@"%@",error.userInfo[@"data"]];
        if ([errMsg isNotNull]) {
            msg = errMsg;
        }
        [[iToast makeText:msg] show];
    }];
}

#pragma mark ================发表评论================

- (void)comment:(RadishProductOrderListItem *)item{
    CommentFoundingViewController *controller = [[CommentFoundingViewController alloc] initWithCommentFoundingModel:[CommentFoundingModel modelFromRadishProductOrderListItem:item]];
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark CommentFoundingViewControllerDelegate

- (void)commentFoundingViewControllerDidFinishSubmitComment:(CommentFoundingViewController *)vc {
    [self loadReplaceItem:self.currentItem];
}

#pragma mark ================再次购买================

- (void)buyAgain:(RadishProductOrderListItem *)item {
    
    NSString *productid = item.productNo;
    NSString *chid = item.chId;
    productid = [productid isNotNull]?productid:@"";
    chid = [chid isNotNull]?chid:@"0";
    NSString *storeno = @"";
    storeno = [storeno isNotNull]?storeno:@"";
    NSDictionary *param = @{@"productid":productid,
                            @"storeno":storeno,
                            @"chid":chid,
                            @"buynum":@(1)};
    [TCProgressHUD showSVP];
    [Request startWithName:@"SHOPPINGCART_SET_V2" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        [self buyAgainSuccess:nil];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self buyAgainFailure:error];
    }];
}

- (void)buyAgainSuccess:(id)value {
    [self loadReplaceItem:self.currentItem];
    ServiceSettlementViewController *controller = [[ServiceSettlementViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)buyAgainFailure:(NSError *)error {
    [[iToast makeText:@"再次购买失败，请稍后再试"] show];
}

#pragma mark ================申请售后================

- (void)refund:(RadishProductOrderListItem *)item {
    OrderRefundViewController *controller = [[OrderRefundViewController alloc] initWithOrderId:item.orderNo];
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark OrderRefundViewControllerDelegate

- (void)orderRefundViewController:(OrderRefundViewController *)vc didSucceedWithRefundForOrderId:(NSString *)identifier {
    [self loadReplaceItem:self.currentItem];
}

#pragma mark ================门店详情================

- (void)storeInfo:(RadishProductOrderListItem *)item {
    StoreDetailViewController *controller = [[StoreDetailViewController alloc] initWithStoreId:item.storeNo];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark ================拨打电话================

- (void)call:(id)valure {
    if ([valure isNotNull]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", valure]]];
    }
}

#pragma mark ================加载数据================

- (void)loadData:(BOOL)refresh {
    if (!self.listView.noMoreOrderListData) {
        self.page = refresh?1:++self.page;
        NSDictionary *param = @{@"page":@(self.page),
                                @"pageCount":@(RadishProductOrderListPageCount)};
        [Request startWithName:@"GET_RADISH_ORDER_LIST" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
            RadishProductOrderListModel *model = [RadishProductOrderListModel modelWithDictionary:dic];
            if (refresh) {
                self.items = model.data;
            }else{
                NSMutableArray *items = [NSMutableArray arrayWithArray:self.items];
                [items addObjectsFromArray:model.data];
                self.items = [NSArray arrayWithArray:items];
            }
            self.listView.items = self.items;
            [self.listView dealWithUI:model.data.count isRecommend:NO];
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
