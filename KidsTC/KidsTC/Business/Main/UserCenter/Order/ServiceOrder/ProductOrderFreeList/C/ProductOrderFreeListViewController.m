//
//  ProductOrderFreeListViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/5.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderFreeListViewController.h"
#import "GHeader.h"
#import "NSString+Category.h"
#import "OnlineCustomerService.h"
#import "UIBarButtonItem+Category.h"
#import "SegueMaster.h"
#import "RecommendDataManager.h"

#import "ProductOrderFreeListModel.h"
#import "ProductOrderFreeListReplaceModel.h"
#import "ProductOrderFreeListView.h"

#import "CashierDeskViewController.h"
#import "ServiceSettlementViewController.h"
#import "OrderBookingViewController.h"
#import "CommentFoundingViewController.h"
#import "WebViewController.h"
#import "StoreDetailViewController.h"
#import "FlashServiceOrderListViewController.h"
#import "AppointmentOrderListViewController.h"
#import "ProductOrderFreeListViewController.h"
#import "NotificationCenterViewController.h"
#import "OrderRefundViewController.h"
#import "ProductOrderFreeDetailViewController.h"

@interface ProductOrderFreeListViewController ()<ProductOrderFreeListViewDelegate,CommentFoundingViewControllerDelegate,OrderRefundViewControllerDelegate>
@property (nonatomic, strong) ProductOrderFreeListView *listView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) ProductOrderFreeListItem *currentItem;
@end

@implementation ProductOrderFreeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    switch (_type) {
        case FreeTypeFreeActivity:
        {
            self.navigationItem.title = @"活动报名";
        }
            break;
        case FreeTypeLottery:
        {
            self.navigationItem.title = @"我的抽奖";
        }
            break;
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.naviTheme = NaviThemeWihte;
    
    self.pageId = 11008;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"ProductOrderList_message" highImageName:@"ProductOrderList_message" postion:UIBarButtonPositionRight target:self action:@selector(message)];
    
    ProductOrderFreeListView *listView = [[ProductOrderFreeListView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    listView.delegate = self;
    [self.view addSubview:listView];
    self.listView = listView;
}

- (void)message {
    NotificationCenterViewController *controller = [[NotificationCenterViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - 更换单个Item

- (void)loadReplaceItem:(ProductOrderFreeListItem *)item {
    
    NSString *orderId = item.orderNo;
    if (![orderId isNotNull]) {
        [[iToast makeText:@"订单编号为空"] show];
        return;
    }
    NSDictionary *param = @{@"orderId":orderId};
    
    [Request startWithName:@"GET_FREE_ORDER_ITEM" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        ProductOrderFreeListItem *replaceItem = [ProductOrderFreeListReplaceModel modelWithDictionary:dic].data;
        if (replaceItem) [self loadReplaceItemSuccess:replaceItem];
    } failure:nil];
}

- (void)loadReplaceItemSuccess:(ProductOrderFreeListItem *)item {
    NSString *orderId = item.orderNo;
    if (![orderId isNotNull]) {
        return;
    }
    __block NSInteger index = -1;
    NSMutableArray<ProductOrderFreeListItem *> *items = [NSMutableArray arrayWithArray:self.items];
    [items enumerateObjectsUsingBlock:^(ProductOrderFreeListItem  * obj, NSUInteger idx, BOOL *stop) {
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

#pragma mark - ProductOrderFreeListViewDelegate

- (void)productOrderFreeListView:(ProductOrderFreeListView *)view actionType:(ProductOrderFreeListViewActionType)type value:(id)value {
    if ([value isKindOfClass:[ProductOrderFreeListItem class]]) self.currentItem = value;
    switch (type) {
        case ProductOrderFreeListViewActionTypePay:/// 付款
        {
            [self payNow:value];
        }
            break;
        case ProductOrderFreeListViewActionTypeCancelOrder:/// 取消订单
        {
            [self cancleOrder:value];
        }
            break;
        case ProductOrderFreeListViewActionTypeConnectService:/// 联系客服
        {
            [self connectService:value];
        }
            break;
        case ProductOrderFreeListViewActionTypeConnectSupplier:/// 联系商家
        {
            [self connectSupplier:value];
        }
            break;
        case ProductOrderFreeListViewActionTypeConsumeCode:/// 取票码
        {
            [self consumeCode:value];
        }
            break;
        case ProductOrderFreeListViewActionTypeReserve:/// 我要预约
        {
            [self connectSupplier:value];
        }
            break;
        case ProductOrderFreeListViewActionTypeCancelTip:/// 取消提醒
        {
            [self tip:value want:NO];
        }
            break;
        case ProductOrderFreeListViewActionTypeWantTip:/// 活动提醒
        {
            [self tip:value want:YES];
        }
            break;
        case ProductOrderFreeListViewActionTypeReminder:/// 我要催单
        {
            [self reminder:value];
        }
            break;
        case ProductOrderFreeListViewActionTypeConfirmDeliver:/// 确认收货
        {
            [self confirmDeliver:value];
        }
            break;
        case ProductOrderFreeListViewActionTypeEvaluate:/// 评价
        {
            [self comment:value];
        }
            break;
        case ProductOrderFreeListViewActionTypeBuyAgain:/// 再次购买
        {
            [self buyAgain:value];
        }
            break;
        case ProductOrderFreeListViewActionTypeComplaint:/// 投诉
        {
            [self connectService:value];
        }
            break;
        case ProductOrderFreeListViewActionTypeRefund://申请售后
        {
            [self refund:value];
        }
            break;
        case ProductOrderFreeListViewActionTypeStore://门店详情
        {
            [self storeInfo:value];
        }
            break;
        case ProductOrderFreeListViewActionTypeLoadData://加载数据
        {
            [self loadData:[value boolValue]];
        }
            break;
        case ProductOrderFreeListViewActionTypeSegue://报名详情
        {
            [self segue:value];
        }
            break;
    }
}

#pragma mark ================立即支付================

- (void)payNow:(ProductOrderFreeListItem *)item {
    CashierDeskViewController *controller = [[CashierDeskViewController alloc]initWithNibName:@"CashierDeskViewController" bundle:nil];
    controller.orderId = item.orderNo;
    controller.orderKind = CashierDeskOrderKindService;
    controller.productType = ProductDetailTypeFree;
    controller.resultBlock = ^void (BOOL needRefresh){
        if(needRefresh)[self loadReplaceItem:self.currentItem];
    };
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark ================取消订单================

- (void)cancleOrder:(ProductOrderFreeListItem *)item {
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

- (void)connectService:(ProductOrderFreeListItem *)item {
    NSString *str = [OnlineCustomerService onlineCustomerServiceLinkUrlString];
    WebViewController *controller = [[WebViewController alloc]init];
    controller.urlString = str;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark ================联系商家================

- (void)connectSupplier:(ProductOrderFreeListItem *)item {
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

- (void)consumeCode:(ProductOrderFreeListItem *)item {
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

- (void)booking:(ProductOrderFreeListItem *)item {
    OrderBookingViewController *controller = [[OrderBookingViewController alloc]init];
    controller.orderNo = item.orderNo;
    controller.mustEdit = NO;
    controller.successBlock = ^void(){
        [self loadReplaceItem:self.currentItem];
    };
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark ================活动提醒================

- (void)tip:(ProductOrderFreeListItem *)item want:(BOOL)want {
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

- (void)reminder:(ProductOrderFreeListItem *)item {
    NSString *orderId = item.orderNo;
    if (![orderId isNotNull]) {
        [[iToast makeText:@"订单编号为空"] show];
        return;
    }
    NSDictionary *param = @{@"orderId":orderId};
    [Request startWithName:@"URGE_ORDER" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [[iToast makeText:@"催单成功"] show];
        [self loadReplaceItem:self.currentItem];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSString *msg = @"催单失败";
        NSString *errMsg = [NSString stringWithFormat:@"%@",error.userInfo[@"data"]];
        if ([errMsg isNotNull]) {
            msg = errMsg;
        }
        [[iToast makeText:msg] show];
    }];
}

#pragma mark ================确认收货================

- (void)confirmDeliver:(ProductOrderFreeListItem *)item {
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

- (void)comment:(ProductOrderFreeListItem *)item{
    CommentFoundingViewController *controller = [[CommentFoundingViewController alloc] initWithCommentFoundingModel:[CommentFoundingModel modelFromProductOrderFreeListItem:item]];
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark CommentFoundingViewControllerDelegate

- (void)commentFoundingViewControllerDidFinishSubmitComment:(CommentFoundingViewController *)vc {
    [self loadReplaceItem:self.currentItem];
}

#pragma mark ================再次购买================

- (void)buyAgain:(ProductOrderFreeListItem *)item {
    [[iToast makeText:@"免费商品不支持再次购买哦"] show];
}

#pragma mark ================申请售后================

- (void)refund:(ProductOrderFreeListItem *)item {
    OrderRefundViewController *controller = [[OrderRefundViewController alloc] initWithOrderId:item.orderNo];
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark OrderRefundViewControllerDelegate

- (void)orderRefundViewController:(OrderRefundViewController *)vc didSucceedWithRefundForOrderId:(NSString *)identifier {
    [self loadReplaceItem:self.currentItem];
}

#pragma mark ================门店详情================

- (void)storeInfo:(ProductOrderFreeListItem *)item {
    StoreDetailViewController *controller = [[StoreDetailViewController alloc] initWithStoreId:item.storeInfo.storeId];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark ================加载数据================

- (void)loadData:(BOOL)refresh {
    
    if (!self.listView.noMoreOrderListData) {
        self.page = refresh?1:++self.page;
        NSDictionary *param = @{@"page":@(self.page),
                                @"pageCount":@(ProductOrderFreeListPageCount),
                                @"type":@(self.type)};
        [Request startWithName:@"GET_USER_ENROLL_LIST" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
            ProductOrderFreeListModel *model = [ProductOrderFreeListModel modelWithDictionary:dic];
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

#pragma mark ================通用跳转================

- (void)segue:(id)value {
    [SegueMaster makeSegueWithModel:value fromController:self];
}

@end
