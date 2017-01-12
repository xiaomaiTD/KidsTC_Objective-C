//
//  RadishOrderDetailViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishOrderDetailViewController.h"
#import "GHeader.h"
#import "NSString+Category.h"
#import "OnlineCustomerService.h"
#import "SegueMaster.h"

#import "RadishOrderDetailModel.h"
#import "RadishOrderDetailView.h"

#include "CashierDeskViewController.h"
#import "WebViewController.h"
#import "OrderBookingViewController.h"
#import "CommentFoundingViewController.h"
#import "ServiceSettlementViewController.h"
#import "OrderRefundViewController.h"

@interface RadishOrderDetailViewController ()<RadishOrderDetailViewDelegate,CommentFoundingViewControllerDelegate,OrderRefundViewControllerDelegate>
@property (nonatomic, strong) RadishOrderDetailView *detailView;
@property (nonatomic, strong) RadishOrderDetailData *data;
@end

@implementation RadishOrderDetailViewController

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
    
    RadishOrderDetailView *detailView = [[RadishOrderDetailView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
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
    NSDictionary *param = @{@"orderNo":_orderId};
    [TCProgressHUD showSVP];
    [Request startWithName:@"GET_RADISH_ORDER_DETAIL" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        self.data = [RadishOrderDetailModel modelWithDictionary:dic].data;
        self.detailView.data = self.data;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [[iToast makeText:@"获取订单详情失败"] show];
        [self back];
    }];
}

#pragma mark - RadishOrderDetailViewDelegate

- (void)radishOrderDetailView:(RadishOrderDetailView *)view actionType:(RadishOrderDetailViewActionType)type value:(id)value {
    
    switch (type) {
        case RadishOrderDetailViewActionTypePay:/// 付款
        {
            [self payNow:value];
        }
            break;
        case RadishOrderDetailViewActionTypeCancelOrder:// 取消订单
        {
            [self cancleOrder:value];
        }
            break;
        case RadishOrderDetailViewActionTypeConnectService:// 联系客服
        {
            [self connectService:value];
        }
            break;
        case RadishOrderDetailViewActionTypeConnectSupplier:// 联系商家
        {
            [self connectSupplier:value];
        }
            break;
        case RadishOrderDetailViewActionTypeConsumeCode:// 取票码
        {
            [self consumeCode:value];
        }
            break;
        case RadishOrderDetailViewActionTypeReserve:// 我要预约
        {
            [self booking:value mustEdit:NO];
        }
            break;
        case RadishOrderDetailViewActionTypeCancelTip:// 取消提醒
        {
            [self tip:value want:NO];
        }
            break;
        case RadishOrderDetailViewActionTypeWantTip:// 活动提醒
        {
            [self tip:value want:YES];
        }
            break;
        case RadishOrderDetailViewActionTypeReminder:// 我要催单
        {
            [self reminder:value];
        }
            break;
        case RadishOrderDetailViewActionTypeConfirmDeliver:// 确认收货
        {
            [self confirmDeliver:value];
        }
            break;
        case RadishOrderDetailViewActionTypeEvaluate:// 评价
        {
            [self comment:value];
        }
            break;
        case RadishOrderDetailViewActionTypeBuyAgain:// 再次购买
        {
            [self buyAgain:value];
        }
            break;
        case RadishOrderDetailViewActionTypeComplaint:// 投诉
        {
            [self connectService:value];
        }
            break;
        case RadishOrderDetailViewActionTypeRefund://申请售后
        {
            [self refund:value];
        }
            break;
        case RadishOrderDetailViewActionTypeCountDownOver://倒计时结束
        {
            [self loadData];
        }
            break;
        case RadishOrderDetailViewActionTypeSegue://通用跳转
        {
            [self segue:value];
        }
            break;
        case RadishOrderDetailViewActionTypeDeliberCall://订单电话
        {
            [self call:value];
        }
            break;
        case RadishOrderDetailViewActionTypeBooking://我要预约
        {
            [self booking:value mustEdit:NO];
        }
            break;
        case RadishOrderDetailViewActionTypeBookingMustEdit://我要预约，编辑
        {
            [self booking:value mustEdit:YES];
        }
            break;
        case RadishOrderDetailViewActionTypeContact://联系商家
        {
            [self connectSupplier:value];
        }
            break;
        case RadishOrderDetailViewActionTypeShowRule://查看公告
        {
            [self showRule:value];
        }
            break;
    }
}


#pragma mark ================立即支付================

- (void)payNow:(id)value {
    
    CashierDeskViewController *controller = [[CashierDeskViewController alloc]initWithNibName:@"CashierDeskViewController" bundle:nil];
    controller.orderId = self.data.orderId;
    controller.orderKind = CashierDeskOrderKindService;
    controller.productType = ProductDetailTypeNormal;
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
        [self cancelOrderRequest:self.data.orderId];
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
    NSString *orderId = self.data.orderId;
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
    controller.orderNo = self.data.orderId;
    controller.mustEdit = mustEdit;
    controller.successBlock = ^void(){
        [self loadData];
    };
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark ================活动提醒================

- (void)tip:(id)value want:(BOOL)want {
    NSString *orderId = self.data.orderId;
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
    NSString *orderId = self.data.orderId;
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
    NSString *orderId = self.data.orderId;
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
    CommentFoundingViewController *controller = [[CommentFoundingViewController alloc] initWithCommentFoundingModel:[CommentFoundingModel modelFromRadishOrderDetailData:self.data]];
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark CommentFoundingViewControllerDelegate

- (void)commentFoundingViewControllerDidFinishSubmitComment:(CommentFoundingViewController *)vc {
    [self loadData];
}

#pragma mark ================再次购买================

- (void)buyAgain:(id)value {
    NSString *productid = self.data.serveId;
    NSString *storeno = @"";
    NSString *chid = self.data.channelId;
    productid = [productid isNotNull]?productid:@"";
    storeno = [storeno isNotNull]?storeno:@"";
    chid = [chid isNotNull]?chid:@"0";
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
    [self loadData];
    ServiceSettlementViewController *controller = [[ServiceSettlementViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)buyAgainFailure:(NSError *)error {
    [[iToast makeText:@"再次购买失败，请稍后再试"] show];
}

#pragma mark ================申请售后================

- (void)refund:(id)value {
    OrderRefundViewController *controller = [[OrderRefundViewController alloc] initWithOrderId:self.data.orderId];
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
