//
//  ProductOrderTicketDetailViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderTicketDetailViewController.h"
#import "NSString+Category.h"
#import "GHeader.h"
#import "OnlineCustomerService.h"
#import "SegueMaster.h"
#import "BuryPointManager.h"

#import "ProductOrderTicketDetailModel.h"
#import "ProductOrderTicketDetailView.h"

#include "CashierDeskViewController.h"
#import "WebViewController.h"
#import "OrderBookingViewController.h"
#import "CommentFoundingViewController.h"
#import "ServiceSettlementViewController.h"
#import "OrderRefundViewController.h"
#import "ProductDetailTicketSelectSeatViewController.h"
#import "ProductDetailAddressViewController.h"

@interface ProductOrderTicketDetailViewController ()<ProductOrderTicketDetailViewDelegate,CommentFoundingViewControllerDelegate,OrderRefundViewControllerDelegate>
@property (nonatomic, strong) ProductOrderTicketDetailView *detailView;
@property (nonatomic, strong) ProductOrderTicketDetailData *data;
@end

@implementation ProductOrderTicketDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![_orderId isNotNull]) {
        [[iToast makeText:@"订单编号为空"] show];
        [self back];
        return;
    }
    
    self.navigationItem.title = @"订单详情";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.naviTheme = NaviThemeWihte;
    
    ProductOrderTicketDetailView *detailView = [[ProductOrderTicketDetailView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
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
    [Request startWithName:@"GET_TICKET_PRODUCT_ORDER_DETAIL" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        self.data = [ProductOrderTicketDetailModel modelWithDictionary:dic].data;
        self.detailView.data = self.data;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [[iToast makeText:@"获取订单详情失败"] show];
        [self back];
    }];
}

#pragma mark - ProductOrderTicketDetailViewDelegate

- (void)productOrderTicketDetailView:(ProductOrderTicketDetailView *)view actionType:(ProductOrderTicketDetailViewActionType)type value:(id)value {
    
    switch (type) {
        case ProductOrderTicketDetailViewActionTypePay:/// 付款
        {
            [self payNow:value];
        }
            break;
        case ProductOrderTicketDetailViewActionTypeCancelOrder:// 取消订单
        {
            [self cancleOrder:value];
        }
            break;
        case ProductOrderTicketDetailViewActionTypeConnectService:// 联系客服
        {
            [self connectService:value];
        }
            break;
        case ProductOrderTicketDetailViewActionTypeConnectSupplier:// 联系商家
        {
            [self connectSupplier:value];
        }
            break;
        case ProductOrderTicketDetailViewActionTypeConsumeCode:// 取票码
        {
            [self consumeCode:value];
        }
            break;
        case ProductOrderTicketDetailViewActionTypeReserve:// 我要预约
        {
            [self booking:value mustEdit:NO];
        }
            break;
        case ProductOrderTicketDetailViewActionTypeCancelTip:// 取消提醒
        {
            [self tip:value want:NO];
        }
            break;
        case ProductOrderTicketDetailViewActionTypeWantTip:// 活动提醒
        {
            [self tip:value want:YES];
        }
            break;
        case ProductOrderTicketDetailViewActionTypeReminder:// 我要催单
        {
            [self reminder:value];
        }
            break;
        case ProductOrderTicketDetailViewActionTypeConfirmDeliver:// 确认收货
        {
            [self confirmDeliver:value];
        }
            break;
        case ProductOrderTicketDetailViewActionTypeEvaluate:// 评价
        {
            [self comment:value];
        }
            break;
        case ProductOrderTicketDetailViewActionTypeBuyAgain:// 再次购买
        {
            [self buyAgain:value];
        }
            break;
        case ProductOrderTicketDetailViewActionTypeComplaint:// 投诉
        {
            [self connectService:value];
        }
            break;
        case ProductOrderTicketDetailViewActionTypeRefund://申请售后
        {
            [self refund:value];
        }
            break;
        case ProductOrderTicketDetailViewActionTypeCountDownOver://倒计时结束
        {
            [self loadData];
        }
            break;
        case ProductOrderTicketDetailViewActionTypeSegue://通用跳转
        {
            [self segue:value];
        }
            break;
        case ProductOrderTicketDetailViewActionTypeDeliberCall://订单电话
        {
            [self call:value];
        }
            break;
        case ProductOrderTicketDetailViewActionTypeAddress://地址
        {
            [self address:value];
        }
            break;
        case ProductOrderTicketDetailViewActionTypeContact://联系商家
        {
            [self connectSupplier:value];
        }
            break;
        case ProductOrderTicketDetailViewActionTypeShowRule://查看公告
        {
            [self showRule:value];
        }
            break;
    }
}

#pragma mark ================立即支付================

- (void)payNow:(id)value {
    
    CashierDeskViewController *controller = [[CashierDeskViewController alloc]initWithNibName:@"CashierDeskViewController" bundle:nil];
    controller.orderId = self.data.orderNo;
    controller.productType = ProductDetailTypeTicket;
    controller.resultBlock = ^void (BOOL needRefresh){
        if (needRefresh) [self loadData];
    };
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark ================取消订单================

- (void)cancleOrder:(id)value {
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"" message:@"您真的要取消订单么？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"不取消了" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"忍痛取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self cancelOrderRequest:self.data.orderNo];
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
    [self loadData];
}
- (void)cancelOrderFailed:(NSError *)error {
    [[iToast makeText:@"取消订单失败"] show];
}

#pragma mark ================联系客服================

- (void)connectService:(id)value {
    NSString *str = [OnlineCustomerService onlineCustomerServiceLinkUrlString];
    WebViewController *controller = [[WebViewController alloc]init];
    controller.urlString = str;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark ================联系商家================

- (void)connectSupplier:(id)value {
    NSArray *phones = self.data.supplierPhones;
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

- (void)consumeCode:(id)value{
    NSString *orderId = self.data.orderNo;
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

- (void)booking:(id)value mustEdit:(BOOL)mustEdit{
    OrderBookingViewController *controller = [[OrderBookingViewController alloc]init];
    controller.orderNo = self.data.orderNo;
    controller.mustEdit = mustEdit;
    controller.successBlock = ^void(){
        [self loadData];
    };
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark ================活动提醒================

- (void)tip:(id)value want:(BOOL)want {
    NSString *orderId = self.data.orderNo;
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

- (void)reminder:(id)value {
    NSString *orderId = self.data.orderNo;
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

- (void)confirmDeliver:(id)value {
    NSString *orderId = self.data.orderNo;
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

- (void)comment:(id)value{
    CommentFoundingViewController *controller = [[CommentFoundingViewController alloc] initWithCommentFoundingModel:[CommentFoundingModel modelFromProductOrderTicketDetailData:self.data]];
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark CommentFoundingViewControllerDelegate

- (void)commentFoundingViewControllerDidFinishSubmitComment:(CommentFoundingViewController *)vc {
    [self loadData];
}

#pragma mark ================再次购买================

- (void)buyAgain:(id)value {
    NSString *productid = self.data.productNo;
    NSString *chid = self.data.chId;
    productid = [productid isNotNull]?productid:@"";
    chid = [chid isNotNull]?chid:@"0";
    ProductDetailTicketSelectSeatViewController *controller = [[ProductDetailTicketSelectSeatViewController alloc] initWithNibName:@"ProductDetailTicketSelectSeatViewController" bundle:nil];
    controller.productId = productid;
    controller.channelId = chid;
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)buyAgainSuccess:(id)value {
    [self loadData];
    ServiceSettlementViewController *controller = [[ServiceSettlementViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)buyAgainFailure:(NSError *)error {
    [[iToast makeText:@"再次购买失败，请稍后再试"] show];
}

#pragma mark ================申请售后================

- (void)refund:(id)value {
    OrderRefundViewController *controller = [[OrderRefundViewController alloc] initWithOrderId:self.data.orderNo];
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

#pragma mark ================拨打电话================

- (void)call:(id)valure {
    if ([valure isNotNull]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", valure]]];
    }
}

#pragma mark ================跳转地址================

- (void)address:(id)value {
    NSArray<ProductDetailAddressSelStoreModel *> *places = [ProductDetailAddressSelStoreModel modelsWithProductOrderTicketDetailData:_data];
    if (places.count<1) {
        return;
    }
    ProductDetailAddressViewController *controller = [[ProductDetailAddressViewController alloc] init];
    controller.placeType = PlaceTypePlace;
    controller.places = places;
    [self.navigationController pushViewController:controller animated:YES];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *orderId = self.data.orderNo;
    if ([orderId isNotNull]) {
        [params setObject:orderId forKey:@"orderId"];
    }
    [BuryPointManager trackEvent:@"event_skip_order_address" actionId:21616 params:params];
}

#pragma mark ================查看公告================

- (void)showRule:(id)valure {
    NSString *str = self.data.noticePageUrl;
    if ([str isNotNull]) {
        WebViewController *controller = [[WebViewController alloc] init];
        controller.urlString = str;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

@end
