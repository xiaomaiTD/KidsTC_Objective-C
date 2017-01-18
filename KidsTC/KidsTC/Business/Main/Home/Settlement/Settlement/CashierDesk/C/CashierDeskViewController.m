//
//  CashierDeskViewController.m
//  KidsTC
//
//  Created by zhanping on 8/17/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "CashierDeskViewController.h"
#import "GHeader.h"
#import "KTCPaymentService.h"
#import "SettlementResultNewViewController.h"
#import "NavigationController.h"
#import "NSString+Category.h"
#import "WeChatManager.h"

@interface CashierDeskViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *orderIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderPriceLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;
@property (weak, nonatomic) IBOutlet UIButton *aliBtn;
@property (weak, nonatomic) IBOutlet UIButton *weChatBtn;
@property (nonatomic, strong) CashierDeskModel *model;
@end

@implementation CashierDeskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageId = 11007;
    if ([self.orderId isNotNull]) {
        self.trackParams = @{@"orderId":_orderId};
    }else{
        [[iToast makeText:@"订单编号为空"] show];
        [self back];
        return;
    }
    
    self.navigationItem.title = @"收银台";
    self.contentView.hidden = YES;
    self.HLineConstraintHeight.constant = LINE_H;
    self.orderPriceLabel.textColor = COLOR_PINK;
    self.aliBtn.layer.cornerRadius = 8;
    self.aliBtn.layer.masksToBounds = YES;
    self.weChatBtn.layer.cornerRadius = 8;
    self.weChatBtn.layer.masksToBounds = YES;
    
    self.weChatBtn.enabled = [WeChatManager sharedManager].isOnline;
    NSString *weChatTitle = [WeChatManager sharedManager].isOnline?@" 微信支付":@" 微信(未安装)";
    [self.weChatBtn setTitle:weChatTitle forState:UIControlStateNormal];
    
    [self loadPayInfo];
}

#pragma mark - loadPayInfo

- (void)loadPayInfo{
    NSDictionary *param = @{@"orderId":self.orderId,
                            @"orderKind":@(self.orderKind)};
    [TCProgressHUD showSVP];
    [Request startWithName:@"ORDER_GET_PAY_CHANNEL" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        CashierDeskModel *model = [CashierDeskModel modelWithDictionary:dic];
        if (model.data) {
            [self loadPayInfoSuccess:model];
        }else{
            [self loadPayInfoFailure:nil];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self loadPayInfoFailure:error];
    }];
}

- (void)loadPayInfoSuccess:(CashierDeskModel *)model{
    self.model = model;
}

- (void)setModel:(CashierDeskModel *)model{
    _model = model;
    self.contentView.hidden = NO;
    CashierDeskOrder *order = model.data.order;
    self.orderIdLabel.text = order.orderNo;
    self.orderPriceLabel.text = order.payMoney;
    
    CashierDeskPayChannel *payChannel = model.data.payChannel;
    self.aliBtn.enabled = payChannel.ali>0;
    self.weChatBtn.enabled = payChannel.WeChat>0 ;
    
    self.aliBtn.tag = PayTypeAli;
    self.weChatBtn.tag = PayTypeWeChat;
}

- (void)loadPayInfoFailure:(NSError *)error {
    NSString *errMsg = @"获取闪购支付信息失败，请重新尝试";
    NSString *text = error.userInfo[@"data"];
    if ([text isKindOfClass:[NSString class]] && [text length] > 0) errMsg = text;
    [[iToast makeText:errMsg] show];
    [self back];
}


- (IBAction)action:(UIButton *)sender {
    CashierDeskOrder *order = self.model.data.order;
    PayType payType = (PayType)sender.tag;
    if (payType == order.payType) {
        [self payNow];
    }else{
        [self changePayType:payType];
    }
}

#pragma mark - changePayType

- (void)changePayType:(PayType)payType{
    NSDictionary *param = @{@"orderId":self.orderId,
                            @"payType":@(payType),
                            @"orderKind":@(self.orderKind)};
    [TCProgressHUD showSVP];
    [Request startWithName:@"ORDER_CHANGE_PAY_CHANNEL" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        CashierDeskChangePayTypeData *data = [CashierDeskChangePayTypeModel modelWithDictionary:dic].data;
        if (data) {
            [self changePayTypeSuccess:data];
        }else{
            [self changePayTypeFailure:nil];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self changePayTypeFailure:error];
    }];
}

- (void)changePayTypeSuccess:(CashierDeskChangePayTypeData *)data {
    CashierDeskOrder *order = self.model.data.order;
    order.payType = data.payType;
    order.payInfo = data.payInfo;
    [self payNow];
}

- (void)changePayTypeFailure:(NSError *)error {
    NSString *errMsg = @"获取闪购支付信息失败，请重新尝试";
    NSString *text = error.userInfo[@"data"];
    if ([text isKindOfClass:[NSString class]] && [text length] > 0) errMsg = text;
    [[iToast makeText:errMsg] show];
}

#pragma mark - payNow

- (void)payNow{
    
    CashierDeskOrder *order = self.model.data.order;
    NSString *orderId = order.orderNo;
    PayInfo *payInfo = order.payInfo;
    [KTCPaymentService startPay:payInfo succeed:^{
        [self settlementPaid:YES orderId:orderId];
        if (self.resultBlock) self.resultBlock(YES);
        [[iToast makeText:@"结算成功"] show];
    } failure:^(NSError *error) {
        //[self settlementPaid:NO orderId:orderId];
        NSString *errMsg = @"结算失败";
        NSString *text = [[error userInfo] objectForKey:kErrMsgKey];
        if ([text isKindOfClass:[NSString class]] && [text length] > 0) errMsg = text;
        [[iToast makeText:errMsg] show];
    }];
}

#pragma mark - 结算结果
- (void)settlementPaid:(BOOL)paid orderId:(NSString *)orderId{
    SettlementResultNewViewController *controller = [[SettlementResultNewViewController alloc]initWithNibName:@"SettlementResultNewViewController" bundle:nil];
    controller.paid = paid;
    controller.orderId = orderId;
    controller.productType = self.productType;
    if (self.orderKind == CashierDeskOrderKindService) {
        controller.type = SettlementResultTypeService;
    }else {
        controller.type = SettlementResultTypeFlash;
    }
    controller.productId = self.productId;
    controller.openGroupId = self.openGroupId;
    NavigationController *navi = [[NavigationController alloc]initWithRootViewController:controller];
    [self presentViewController:navi animated:YES completion:^{
        [self.navigationController popViewControllerAnimated:NO];
    }];
}
@end
