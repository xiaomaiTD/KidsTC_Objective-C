//
//  ProductOrderFreeDetailViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderFreeDetailViewController.h"
#import "GHeader.h"
#import "NSString+Category.h"
#import "OnlineCustomerService.h"
#import "SegueMaster.h"
#import "BuryPointManager.h"

#import "ProductOrderFreeDetailModel.h"
#import "ProductOrderFreeDetailLotteryModel.h"
#import "ProductOrderFreeDetailView.h"

#import "CashierDeskViewController.h"
#import "TCStoreDetailViewController.h"
#import "ServiceSettlementViewController.h"
#import "WebViewController.h"
#import "OrderBookingViewController.h"
#import "CommentFoundingViewController.h"
#import "OrderRefundViewController.h"
#import "ProductDetailCalendarViewController.h"
#import "ProductDetailAddressViewController.h"

@interface ProductOrderFreeDetailViewController ()<ProductOrderFreeDetailViewDelegate,CommentFoundingViewControllerDelegate,OrderRefundViewControllerDelegate>
@property (nonatomic, strong) ProductOrderFreeDetailView *detailView;
@property (nonatomic, strong) ProductOrderFreeDetailData *infoData;
@property (nonatomic, strong) NSArray<ProductOrderFreeDetailLotteryItem* > *lotteryData;
@property (nonatomic, assign) NSInteger page;
@end

@implementation ProductOrderFreeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![_orderId isNotNull]) {
        [[iToast makeText:@"订单编号为空"] show];
        [self back];
        return;
    }
    
    self.navigationItem.title = @"报名详情";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.naviTheme = NaviThemeWihte;
    
    self.pageId = 11009;
    self.trackParams = @{@"orderId":_orderId};
    
    ProductOrderFreeDetailView *detailView = [[ProductOrderFreeDetailView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    detailView.delegate = self;
    [self.view addSubview:detailView];
    self.detailView = detailView;
    
    [self loadData];
    
}

- (void)loadData {
    if (![_orderId isNotNull]) {
        [[iToast makeText:@"订单编号为空"] show];
        [self back];
        return;
    }
    NSDictionary *param = @{@"orderId":_orderId};
    [TCProgressHUD showSVP];
    [Request startWithName:@"GET_USER_ENROLL_DETAIL" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        ProductOrderFreeDetailData *data = [ProductOrderFreeDetailModel modelWithDictionary:dic].data;
        if (data) {
            [self loadDataSuccess:data];
        }else{
            [self loadDataFailure:nil];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self loadDataFailure:nil];
    }];
}

- (void)loadDataSuccess:(ProductOrderFreeDetailData *)data {
    self.infoData = data;
    self.detailView.infoData = data;
    [self.detailView reloadInfoData];
    if (data.freeType == FreeTypeLottery) {
        [self loadLottery:@(YES)];
    }
}

- (void)loadDataFailure:(NSError *)error {
    [[iToast makeText:@"获取报名详情失败"] show];
    [self back];
}

#pragma mark - ProductOrderFreeDetailViewDelegate

- (void)productOrderFreeDetailView:(ProductOrderFreeDetailView *)view
                        actionType:(ProductOrderFreeDetailViewActionType)type
                             value:(id)value
{
    switch (type) {
        case ProductOrderFreeDetailViewActionTypePay:/// 付款
        {
            [self payNow:value];
        }
            break;
        case ProductOrderFreeDetailViewActionTypeCancelOrder:/// 取消订单
        {
            [self cancleOrder:value];
        }
            break;
        case ProductOrderFreeDetailViewActionTypeConnectService:/// 联系客服
        {
            [self connectService:value];
        }
            break;
        case ProductOrderFreeDetailViewActionTypeConnectSupplier:/// 联系商家
        {
            [self connectSupplier:value];
        }
            break;
        case ProductOrderFreeDetailViewActionTypeConsumeCode:/// 取票码
        {
            [self consumeCode:value];
        }
            break;
        case ProductOrderFreeDetailViewActionTypeReserve:/// 我要预约
        {
            [self booking:value];
        }
            break;
        case ProductOrderFreeDetailViewActionTypeCancelTip:/// 取消提醒
        {
            [self tip:value want:NO];
        }
            break;
        case ProductOrderFreeDetailViewActionTypeWantTip:/// 活动提醒
        {
            [self tip:value want:YES];
        }
            break;
        case ProductOrderFreeDetailViewActionTypeReminder:/// 我要催单
        {
            [self reminder:value];
        }
            break;
        case ProductOrderFreeDetailViewActionTypeConfirmDeliver:/// 确认收货
        {
            [self confirmDeliver:value];
        }
            break;
        case ProductOrderFreeDetailViewActionTypeEvaluate:/// 评价
        {
            [self comment:value];
        }
            break;
        case ProductOrderFreeDetailViewActionTypeBuyAgain:/// 再次购买
        {
            [self buyAgain:value];
        }
            break;
        case ProductOrderFreeDetailViewActionTypeComplaint:/// 投诉
        {
            [self connectService:value];
        }
            break;
        case ProductOrderFreeDetailViewActionTypeRefund://申请售后
        {
            [self refund:value];
        }
            break;
        case ProductOrderFreeDetailViewActionTypeCountDownOver://倒计时结束
        {
            [self loadData];
        }
            break;
        case ProductOrderFreeDetailViewActionTypeSegue://通用跳转
        {
            [self segue:value];
        }
            break;
        case ProductOrderFreeDetailViewActionTypeStore:
        {
            [self storeInfo:value];
        }
            break;
        case ProductOrderFreeDetailViewActionTypeAddress:
        {
            [self address:value];
        }
            break;
        case ProductOrderFreeDetailViewActionTypeDate:
        {
            [self date:value];
        }
            break;
        case ProductOrderFreeDetailViewActionTypeMoreLottery:
        {
            [self loadLottery:value];
        }
            break;
        case ProductOrderFreeDetailViewActionTypeShowRule:
        {
            [self showRule:value];
        }
            break;
    }
}

#pragma mark ================立即支付================

- (void)payNow:(ProductOrderFreeDetailData *)data {
    CashierDeskViewController *controller = [[CashierDeskViewController alloc]initWithNibName:@"CashierDeskViewController" bundle:nil];
    controller.orderId = data.orderNo;
    controller.productType = ProductDetailTypeFree;
    controller.resultBlock = ^void (BOOL needRefresh){
        if (needRefresh) [self loadData];
    };
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark ================取消订单================

- (void)cancleOrder:(ProductOrderFreeDetailData *)data {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"" message:@"您真的要取消订单么？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"不取消了" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"忍痛取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self cancelOrderRequest:data.orderNo];
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
    
}
- (void)cancelOrderFailed:(NSError *)error {
    [[iToast makeText:@"取消订单失败"] show];
}

#pragma mark ================联系客服================

- (void)connectService:(ProductOrderFreeDetailData *)data {
    NSString *str = [OnlineCustomerService onlineCustomerServiceLinkUrlString];
    WebViewController *controller = [[WebViewController alloc]init];
    controller.urlString = str;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark ================联系商家================

- (void)connectSupplier:(ProductOrderFreeDetailData *)data {
    NSArray *phones = data.supplierPhones;
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

- (void)consumeCode:(ProductOrderFreeDetailData *)data {
    NSString *orderId = data.orderNo;
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

- (void)booking:(ProductOrderFreeDetailData *)data {
    OrderBookingViewController *controller = [[OrderBookingViewController alloc]init];
    controller.orderNo = data.orderNo;
    controller.mustEdit = NO;
    controller.successBlock = ^void(){
        [self loadData];
    };
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark ================活动提醒================

- (void)tip:(ProductOrderFreeDetailData *)data want:(BOOL)want {
    NSString *orderId = data.orderNo;
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
        [self loadData];
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
        [self loadData];
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

- (void)confirmDeliver:(ProductOrderListItem *)item {
    NSString *orderId = item.orderNo;
    if (![orderId isNotNull]) {
        [[iToast makeText:@"订单编号为空"] show];
        return;
    }
    NSDictionary *param = @{@"orderId":orderId};
    [Request startWithName:@"CONFIRM_ORDER_DELIVER_RECEIVED" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [[iToast makeText:@"确认收货成功"] show];
        [self loadData];
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

- (void)comment:(ProductOrderFreeDetailData *)data{
    CommentFoundingViewController *controller = [[CommentFoundingViewController alloc] initWithCommentFoundingModel:[CommentFoundingModel modelFromProductOrderFreeDetailData:data]];
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark CommentFoundingViewControllerDelegate

- (void)commentFoundingViewControllerDidFinishSubmitComment:(CommentFoundingViewController *)vc {
    [self loadData];
}

#pragma mark ================再次购买================

- (void)buyAgain:(ProductOrderFreeDetailData *)data {
    [[iToast makeText:@"免费商品不支持再次购买哦"] show];
}

#pragma mark ================申请售后================

- (void)refund:(ProductOrderFreeDetailData *)data {
    OrderRefundViewController *controller = [[OrderRefundViewController alloc] initWithOrderId:data.orderNo];
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark OrderRefundViewControllerDelegate

- (void)orderRefundViewController:(OrderRefundViewController *)vc didSucceedWithRefundForOrderId:(NSString *)identifier {
    [self loadData];
}

#pragma mark ================通用跳转================

- (void)segue:(id)value {
    [SegueMaster makeSegueWithModel:value fromController:self];
}

#pragma mark ================门店详情================

- (void)storeInfo:(ProductOrderFreeDetailData *)data {
    TCStoreDetailViewController *controller = [[TCStoreDetailViewController alloc] init];
    controller.storeId = data.storeInfo.storeId;

    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark ================位置信息================

- (void)address:(ProductOrderFreeDetailData *)data {
    NSArray<ProductDetailAddressSelStoreModel *> *places = [ProductDetailAddressSelStoreModel modelsWithProductOrderFreeDetailStore:data.storeInfo];
    if (places.count<1) {
        return;
    }
    ProductDetailAddressViewController *controller = [[ProductDetailAddressViewController alloc] init];
    controller.placeType = data.placeType;
    controller.places = places;
    [self.navigationController pushViewController:controller animated:YES];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *orderId = self.infoData.orderNo;
    if ([orderId isNotNull]) {
        [params setObject:orderId forKey:@"orderId"];
    }
    [BuryPointManager trackEvent:@"event_skip_order_address" actionId:21616 params:params];
}

#pragma mark ================活动时间================

- (void)date:(ProductOrderFreeDetailData *)data {
    ProductDetailCalendarViewController *controller = [[ProductDetailCalendarViewController alloc] init];
    controller.times = data.time.times;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark ================获取中奖名单================
- (void)loadLottery:(id)value {
    if (![value respondsToSelector:@selector(boolValue)]) {
        return;
    }
    BOOL refresh = [value boolValue];
    
    if (![_orderId isNotNull]) {
        return;
    }
    NSDictionary *param = @{@"page":@(++self.page),
                            @"pageCount":@(TCPAGECOUNT),
                            @"orderId":_orderId};
    [Request startWithName:@"GET_ENROLL_PRIZE_PAGE" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        ProductOrderFreeDetailLotteryModel *model = [ProductOrderFreeDetailLotteryModel modelWithDictionary:dic];
        if (refresh) {
            self.lotteryData = model.data;
        }else{
            NSMutableArray *lotteryData = [NSMutableArray arrayWithArray:self.lotteryData];
            [lotteryData addObjectsFromArray:self.lotteryData];
            self.lotteryData = [NSArray arrayWithArray:lotteryData];
        }
        self.detailView.lotteryData = self.lotteryData;
        [self.detailView reloadLotteryData:model.data.count];
    } failure:nil];
}

#pragma mark ================查看公告================

- (void)showRule:(id)valure {
    NSString *str = self.infoData.noticePageUrl;
    if ([str isNotNull]) {
        WebViewController *controller = [[WebViewController alloc] init];
        controller.urlString = str;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

@end
