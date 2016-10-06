//
//  ServiceOrderDetailViewController.m
//  KidsTC
//
//  Created by zhanping on 8/15/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ServiceOrderDetailViewController.h"
#import "GHeader.h"
#import "NSString+Category.h"
#import "UIBarButtonItem+Category.h"
#import "OnlineCustomerService.h"
#import "GuideManager.h"

#import "ServiceOrderDetailBaseCell.h"
#import "ServiceOrderDetailAddressCell.h"
#import "ServiceOrderDetailServiceInfoCell.h"
#import "ServiceOrderDetailStoreInfoCell.h"
#import "ServiceOrderDetailInsuranceCell.h"
#import "ServiceOrderDetailBookingFailureCell.h"
#import "ServiceOrderDetailBookingCell.h"
#import "ServiceOrderDetailPayInfoCell.h"
#import "ServiceOrderDetailTotalPayInfoCell.h"
#import "SreviceOrderDetailRemarksCell.h"
#import "ServiceOrderDetailOrderInfoCell.h"
#import "ServiceOrderDetailRefundTipCell.h"
#import "ServiceOrderDetailRefundInfoCell.h"
#import "ServiceOrderDetailPayTipCell.h"
#import "ServiceOrderDetailCountDownCell.h"

#import "ServiceOrderDetailRemindView.h"
#import "ServiceOrderDetailToolBar.h"

#import "ServiceOrderDetailModel.h"

#import "ServiceDetailViewController.h"
#import "StoreDetailViewController.h"
#import "CashierDeskViewController.h"
#import "OrderRefundViewController.h"
#import "CommentFoundingViewController.h"
#import "WebViewController.h"
#import "OrderBookingViewController.h"
#import "ServiceSettlementViewController.h"

#import "MTA.h"
#import "UMMobClick/MobClick.h"



#define TOOLBAR_HEIGHT 64

@interface ServiceOrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource,ServiceOrderDetailBaseCellDelegate,ServiceOrderDetailToolBarDelegate,OrderRefundViewControllerDelegate,CommentFoundingViewControllerDelegate,ServiceOrderDetailRemindViewDelegate>
@property (nonatomic, weak  ) UITableView                       *tableView;
@property (nonatomic, weak  ) ServiceOrderDetailToolBar         *toolBar;
@property (nonatomic, strong) ServiceOrderDetailAddressCell     *addressCell;
@property (nonatomic, strong) ServiceOrderDetailServiceInfoCell *serviceInfoCell;
@property (nonatomic, strong) ServiceOrderDetailStoreInfoCell   *storeInfoCell;
@property (nonatomic, strong) ServiceOrderDetailInsuranceCell   *insuranceCell;
@property (nonatomic, strong) ServiceOrderDetailBookingFailureCell *bookingFailureCell;
@property (nonatomic, strong) ServiceOrderDetailBookingCell     *bookingCell;
@property (nonatomic, strong) SreviceOrderDetailRemarksCell     *remarksCell;
@property (nonatomic, strong) ServiceOrderDetailOrderInfoCell   *orderInfoCell;
@property (nonatomic, strong) ServiceOrderDetailRefundTipCell   *refundTipCell;
@property (nonatomic, strong) ServiceOrderDetailPayTipCell      *payTipCell;
@property (nonatomic, strong) ServiceOrderDetailCountDownCell   *countDownCell;

@property (nonatomic, strong) NSMutableArray<NSMutableArray<ServiceOrderDetailBaseCell *> *> *sections;
@property (nonatomic, strong) ServiceOrderDetailModel *model;

@property (nonatomic, strong) ServiceOrderDetailRemindView *headerView;
@property (nonatomic, strong) UIBarButtonItem *contactBarButtonItem;
@end

@implementation ServiceOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"订单详情";
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tableView.estimatedRowHeight = 44.0f;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    _headerView = [self viewWithNib:@"ServiceOrderDetailRemindView"];
    _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 70);
    _headerView.delegate = self;
    
    ServiceOrderDetailToolBar *toolBar = [self viewWithNib:@"ServiceOrderDetailToolBar"];
    toolBar.frame = CGRectMake(0, SCREEN_HEIGHT-TOOLBAR_HEIGHT, SCREEN_WIDTH, TOOLBAR_HEIGHT);
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
    _toolBar = toolBar;
    
    [self prepareCells];
    
    [self loadOrderDetailSuccess:nil faliure:nil];
    
    self.contactBarButtonItem = [UIBarButtonItem itemWithImageName:@"icon_connect_serve" highImageName:@"icon_connect_serve" postion:UIBarButtonPositionRight target:self action:@selector(rightBarButtonItemAction)];
}

- (void)rightBarButtonItemAction{

    BOOL onLine = [OnlineCustomerService serviceIsOnline];
    if (onLine) {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"请选择客服类型" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *onlineAction = [UIAlertAction actionWithTitle:@"在线客服" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self contectOnlineCustomerService];
        }];
        [controller addAction:onlineAction];
        NSArray *phones = self.model.data.supplierPhones;
        if (phones && phones.count>0) {
            UIAlertAction *phoneAction = [UIAlertAction actionWithTitle:@"电话热线" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self makePhoneCallToCS];
            }];
            [controller addAction:phoneAction];
        }
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [controller addAction:cancelAction];
        
        [self presentViewController:controller animated:YES completion:nil];
    }else{
        [self makePhoneCallToCS];
    }
}

- (void)contectOnlineCustomerService {
    WebViewController *controller = [[WebViewController alloc] init];
    controller.urlString = [OnlineCustomerService onlineCustomerServiceLinkUrlString];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)prepareCells{
    
    _addressCell              = [self viewWithNib:@"ServiceOrderDetailAddressCell"];
    _serviceInfoCell          = [self viewWithNib:@"ServiceOrderDetailServiceInfoCell"];
    _serviceInfoCell.delegate = self;
    _storeInfoCell            = [self viewWithNib:@"ServiceOrderDetailStoreInfoCell"];
    _storeInfoCell.delegate   = self;
    _insuranceCell            = [self viewWithNib:@"ServiceOrderDetailInsuranceCell"];
    _bookingFailureCell       = [self viewWithNib:@"ServiceOrderDetailBookingFailureCell"];
    _bookingFailureCell.delegate = self;
    _bookingCell              = [self viewWithNib:@"ServiceOrderDetailBookingCell"];
    _bookingCell.delegate     = self;
    _remarksCell              = [self viewWithNib:@"SreviceOrderDetailRemarksCell"];
    _orderInfoCell            = [self viewWithNib:@"ServiceOrderDetailOrderInfoCell"];
    _orderInfoCell.delegate   = self;
    _refundTipCell            = [self viewWithNib:@"ServiceOrderDetailRefundTipCell"];
    _payTipCell               = [self viewWithNib:@"ServiceOrderDetailPayTipCell"];
}

- (id)viewWithNib:(NSString *)nib{
    return [[NSBundle mainBundle] loadNibNamed:nib owner:self options:nil].firstObject;
}

#pragma mark - loadOrderDetail

- (void)loadOrderDetailSuccess:(void(^)())success faliure:(void(^)())faliure{
    [TCProgressHUD showSVP];
    NSDictionary *param = @{@"orderId":self.orderId};
    [Request startWithName:@"ORDER_GET_ORDER_DETAIL" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        [self loadOrderDetailSuccess:[ServiceOrderDetailModel modelWithDictionary:dic]];
        if (success) success();
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self loadOrderDetailFailure:error];
        if (faliure) faliure();
    }];
}

- (void)loadOrderDetailSuccess:(ServiceOrderDetailModel *)model {
    self.model = model;
}

- (void)loadOrderDetailFailure:(NSError *)error {
    self.navigationItem.rightBarButtonItem = nil;
    NSString *errMsg = @"获取订单信息失败";
    if (error.userInfo) {
        NSString *msg = [error.userInfo objectForKey:@"data"];
        if ([msg isKindOfClass:[NSString class]] && [msg length] > 0) errMsg = msg;
    }
    [[iToast makeText:errMsg] show];
    [self back];
}

- (void)setModel:(ServiceOrderDetailModel *)model{
    _model = model;
    self.navigationItem.rightBarButtonItem = self.contactBarButtonItem;
    if ([model.data.noticePageUrl isNotNull]) {
        _tableView.tableHeaderView = _headerView;
    }else{
        [self nilTableHeaderView];
    }
    if (model.data.canShowButton) {
        [[GuideManager shareGuideManager] checkGuideWithTarget:self type:GuideTypeOrderDetail resultBlock:nil];
    }
    [self setupSections:model];
    _toolBar.data = model.data;
    _tableView.contentInset = UIEdgeInsetsMake(64, 0, self.toolBar.hidden?0:TOOLBAR_HEIGHT, 0);
    _tableView.scrollIndicatorInsets = _tableView.contentInset;
    [_tableView reloadData];
}

- (void)setupSections:(ServiceOrderDetailModel *)model {
    ServiceOrderDetailData *data = model.data;
    
    NSMutableArray *sections = [NSMutableArray array];
    
    //1.收货地址
    if (data.userAddress) {
        NSMutableArray *section00 = [NSMutableArray array];
        [section00 addObject:_addressCell];
        [sections addObject:section00];
    }
    //2.服务信息、门店信息、福利
    NSMutableArray *section01 = [NSMutableArray array];
    [section01 addObject:_serviceInfoCell];
    if (data.storeInfo) {
        [section01 addObject:_storeInfoCell];
    }
    if (data.insurance.canShow) {
        [section01 addObject:_insuranceCell];
    }
    if (section01.count>0) {
        [sections addObject:section01];
    }
    
    //在线预约信息
    NSMutableArray *sectionForBooking = [NSMutableArray array];
    if (data.onlineBespeakStatus == OrderBookingBespeakStatusBespeakFail) {
        [sectionForBooking addObject:_bookingFailureCell];
    }
    if (data.canShowButton) {
        [sectionForBooking addObject:_bookingCell];
    }
    if (sectionForBooking.count>0) {
        [sections addObject:sectionForBooking];
    }
    
    //3.结算信息
    NSMutableArray *section02 = [NSMutableArray array];
    ServiceOrderDetailPayInfoCell *pricePayInfoCell = [self viewWithNib:@"ServiceOrderDetailPayInfoCell"];
    pricePayInfoCell.type = ServiceOrderDetailPayInfoCellTypeTypePrice;
    [section02 addObject:pricePayInfoCell];
    ServiceOrderDetailPayInfoCell *promotionPayInfoCell = [self viewWithNib:@"ServiceOrderDetailPayInfoCell"];
    promotionPayInfoCell.type = ServiceOrderDetailPayInfoCellTypeTypePromotion;
    [section02 addObject:promotionPayInfoCell];
    ServiceOrderDetailPayInfoCell *scorePayInfoCell = [self viewWithNib:@"ServiceOrderDetailPayInfoCell"];
    scorePayInfoCell.type = ServiceOrderDetailPayInfoCellTypeTypeScore;
    [section02 addObject:scorePayInfoCell];
    if (data.transportationExpenses>0) {
        ServiceOrderDetailPayInfoCell *transportationExpensesPayInfoCell = [self viewWithNib:@"ServiceOrderDetailPayInfoCell"];
        transportationExpensesPayInfoCell.type = ServiceOrderDetailPayInfoCellTypeTransportationExpenses;
        [section02 addObject:transportationExpensesPayInfoCell];
    }
    ServiceOrderDetailTotalPayInfoCell *totalPayInfoCell = [self viewWithNib:@"ServiceOrderDetailTotalPayInfoCell"];
    [section02 addObject:totalPayInfoCell];
    [sections addObject:section02];
    //4.备注信息
    if (data.remarks.count>0) {
        NSMutableArray *section03 = [NSMutableArray array];
        [section03 addObject:_remarksCell];
        [sections addObject:section03];
    }
    //5.订单信息
    NSMutableArray *section04 = [NSMutableArray array];
    [section04 addObject:_orderInfoCell];
    [sections addObject:section04];
    //6.退款信息
    if (data.refunds.count>0) {
        NSMutableArray *section05 = [NSMutableArray array];
        [section05 addObject:_refundTipCell];
        [data.refunds enumerateObjectsUsingBlock:^(ServiceOrderDetailRefund * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ServiceOrderDetailRefundInfoCell *refundInfoCell = [self viewWithNib:@"ServiceOrderDetailRefundInfoCell"];
            refundInfoCell.tag = idx;
            [section05 addObject:refundInfoCell];
        }];
        [sections addObject:section05];
    }
    //7.支付提醒
    if ([data.expireTimeDesc isNotNull]) {
        NSMutableArray *section05 = [NSMutableArray array];
        [section05 addObject:_payTipCell];
        [sections addObject:section05];
    }
    
    if (data.isShowRemainingTime && data.remainingTime>0) {
        if (!_countDownCell) {
            _countDownCell = [self viewWithNib:@"ServiceOrderDetailCountDownCell"];
        }
        NSMutableArray *sectionForCountDown = [NSMutableArray array];
        [sectionForCountDown addObject:_countDownCell];
        [sections addObject:sectionForCountDown];
    }
    
    self.sections = sections;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sections[section].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section==0?8:0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ServiceOrderDetailBaseCell *cell = self.sections[indexPath.section][indexPath.row];
    cell.data = self.model.data;
    return cell;
}

#pragma mark - ServiceOrderDetailBaseCellDelegate

- (void)serviceOrderDetailBaseCell:(ServiceOrderDetailBaseCell *)cell actionType:(ServiceOrderDetailBaseCellActionType)type {
    switch (type) {
        case ServiceOrderDetailBaseCellActionTypeServiceDetail:
        {
            [self serviceInfo];
        }
            break;
        case ServiceOrderDetailBaseCellActionTypeOrderDetail:
        {
            [self storeInfo];
        }
            break;
        case ServiceOrderDetailBaseCellActionTypeContact:
        {
            [self makePhoneCallToCS];
        }
            break;
        case ServiceOrderDetailBaseCellActionTypeBooking:
        {
            [self booking:NO];
        }
            break;
        case ServiceOrderDetailBaseCellActionTypeBookingMustEdit:
        {
            [self booking:YES];
        }
            break;
        case ServiceOrderDetailBaseCellActionTypeReload:
        {
            [self loadOrderDetailSuccess:nil faliure:nil];
        }
            break;
    }
}

- (void)serviceInfo {
    ServiceDetailViewController *controller = [[ServiceDetailViewController alloc] initWithServiceId:self.model.data.serveId channelId:@"0"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)storeInfo {
    StoreDetailViewController *controller = [[StoreDetailViewController alloc] initWithStoreId:self.model.data.storeInfo.storeId];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)makePhoneCallToCS {
    NSArray *phones = self.model.data.supplierPhones;
    if (phones && phones.count == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", phones[0]]]];
    }else if (phones && phones.count > 1){
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"请选择客服电话" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        for (NSString *phone in phones) {
            UIAlertAction *phoneAction = [UIAlertAction actionWithTitle:phone style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", phone]]];
            }];
            [controller addAction:phoneAction];
        }
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [controller addAction:cancelAction];
        [self presentViewController:controller animated:YES completion:nil];
    }
}

- (void)booking:(BOOL)mustEdit {
    OrderBookingViewController *controller = [[OrderBookingViewController alloc]init];
    controller.orderNo = self.model.data.oderId;
    controller.mustEdit = mustEdit;
    controller.successBlock = ^void(){
        [self loadOrderDetailSuccess:nil faliure:nil];
    };
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - ServiceOrderDetailRemindViewDelegate

- (void)serviceOrderDetailRemindView:(ServiceOrderDetailRemindView *)view actionType:(ServiceOrderDetailRemindViewActionType)type {
    switch (type) {
        case ServiceOrderDetailRemindViewActionTypeLink:
        {
            [self showNoti];
        }
            break;
        case ServiceOrderDetailRemindViewActionTypeDelete:
        {
            [self nilTableHeaderView];
        }
            break;
    }
}

- (void)showNoti {
    WebViewController *controller = [[WebViewController alloc] init];
    controller.urlString = _model.data.noticePageUrl;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)nilTableHeaderView {
    UIView *header = [UIView new];
    header.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.01);
    self.tableView.tableHeaderView = header;
}

#pragma mark - ServiceOrderDetailToolBarDelegate

- (void)serviceOrderDetailToolBar:(ServiceOrderDetailToolBar *)toolBar btn:(ServiceOrderDetailToolBarButton *)btn actionType:(ServiceOrderDetailToolBarButtonActionType)type value:(id)value {
    
    switch (type) {
        case ActionTypeCancleOrder://取消订单
        {
            [self cancleOrder];
        }
            break;
        case ActionTypePayNow://立即支付
        {
            [self payNow];
        }
            break;
        case ActionTypeApplyRefund://申请退款
        {
            [self applyRefund];
        }
            break;
        case ActionTypeGetConsumerCode://获取消费码
        {
            [self getCode:btn];
        }
            break;
        case ActionTypeComment://发表评论
        {
            [self comment];
        }
            break;
        case ActionTypeBuyAgain://再次购买
        {
            [self buyAgain];
        }
            break;
    }
}


#pragma mark ================取消订单================

- (void)cancleOrder {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"" message:@"您真的要取消订单么？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"不取消了" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"忍痛取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self cancelOrderRequest];
    }];
    [controller addAction:cancelAction];
    [controller addAction:confirmAction];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)cancelOrderRequest {
    NSDictionary *param = @{@"orderid":self.orderId};
    [Request startWithName:@"ORDER_CANCLE_ORDER" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [self cancelOrderSucceed:dic];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self cancelOrderFailed:error];
    }];
}

- (void)cancelOrderSucceed:(NSDictionary *)data {
    [self loadOrderDetailSuccess:nil faliure:nil];
    NSDictionary *trackParam = @{ @"id":self.orderId,@"result":@"true"};
    [MTA trackCustomKeyValueEvent:@"event_result_order_dtl_cancel" props:trackParam];
    [MobClick event:@"event_result_order_dtl_cancel" attributes:trackParam];
}

- (void)cancelOrderFailed:(NSError *)error {
    [[iToast makeText:@"取消订单失败"] show];
    NSDictionary *trackParam = @{ @"id":self.orderId,@"result":@"false"};
    [MTA trackCustomKeyValueEvent:@"event_result_order_dtl_cancel" props:trackParam];
    [MobClick event:@"event_result_order_dtl_cancel" attributes:trackParam];
}

#pragma mark ================立即支付================

- (void)payNow {
    
    CashierDeskViewController *controller = [[CashierDeskViewController alloc]initWithNibName:@"CashierDeskViewController" bundle:nil];
    controller.orderId = self.orderId;
    controller.orderKind = CashierDeskOrderKindService;
    controller.resultBlock = ^void (BOOL needRefresh){
        [self loadOrderDetailSuccess:^{
            if ([self.delegate respondsToSelector:@selector(serviceOrderDetailStateChanged:needRefresh:)]) {
                [self.delegate serviceOrderDetailStateChanged:self.orderId needRefresh:needRefresh];
            }
        } faliure:nil];
    };
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark ================申请退款================

- (void)applyRefund {
    
    OrderRefundViewController *controller = [[OrderRefundViewController alloc] initWithOrderId:self.orderId];
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
    //MTA
    [MTA trackCustomKeyValueEvent:@"event_skip_order_dtl_refund" props:nil];
    [MobClick event:@"event_skip_order_dtl_refund" attributes:nil];
}

#pragma mark OrderRefundViewControllerDelegate

- (void)orderRefundViewController:(OrderRefundViewController *)vc didSucceedWithRefundForOrderId:(NSString *)identifier {
    [self loadOrderDetailSuccess:^{
        if ([self.delegate respondsToSelector:@selector(serviceOrderDetailStateChanged:needRefresh:)]) {
            [self.delegate serviceOrderDetailStateChanged:self.orderId needRefresh:YES];
        }
    } faliure:nil];
}

#pragma mark ================获取消费码================

- (void)getCode:(ServiceOrderDetailToolBarButton *)btn{
    btn.enabled = NO;
    NSDictionary *param = @{@"orderId":self.orderId};
    [Request startWithName:@"ORDER_SEND_CONSUME_CODE" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        btn.enabled = NO;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        btn.backgroundColor = [UIColor lightGrayColor];
        [btn setTitle:@"已发送消费码" forState:UIControlStateDisabled];
        [[iToast makeText:@"消费码已发到您的手机，请注意查收"] show];
        NSDictionary *trackParam = @{@"id":self.orderId,@"result":@"true"};
        [MTA trackCustomKeyValueEvent:@"event_result_order_dtl_consume" props:trackParam];
        [MobClick event:@"event_result_order_dtl_consume" attributes:trackParam];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        btn.enabled = YES;
        NSString *errMsg = @"获取消费码失败";
        if (error.userInfo) {
            NSString *msg = [error.userInfo objectForKey:@"data"];
            if ([msg isKindOfClass:[NSString class]] && [msg length] > 0) errMsg = msg;
        }
        [[iToast makeText:errMsg] show];
        NSDictionary *trackParam = @{@"id":self.orderId,@"result":@"false"};
        [MTA trackCustomKeyValueEvent:@"event_result_order_dtl_consume" props:trackParam];
        [MobClick event:@"event_result_order_dtl_consume" attributes:trackParam];
    }];
}

#pragma mark ================发表评论================

- (void)comment{
    CommentFoundingViewController *controller = [[CommentFoundingViewController alloc] initWithCommentFoundingModel:[CommentFoundingModel modelFromServiceOrderDetailModel:self.model]];
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
    //MTA
    [MTA trackCustomKeyValueEvent:@"event_skip_order_dtl_evaluate" props:nil];
    [MobClick event:@"event_skip_order_dtl_evaluate" attributes:nil];
}

#pragma mark CommentFoundingViewControllerDelegate

- (void)commentFoundingViewControllerDidFinishSubmitComment:(CommentFoundingViewController *)vc {
    [self loadOrderDetailSuccess:^{
        if ([self.delegate respondsToSelector:@selector(serviceOrderDetailStateChanged:needRefresh:)]) {
            [self.delegate serviceOrderDetailStateChanged:self.orderId needRefresh:YES];
        }
    } faliure:nil];
}

#pragma mark ================再次购买================

- (void)buyAgain {
    ServiceOrderDetailData *data = self.model.data;
    NSString *productid = data.serveId;
    NSString *storeno = data.storeInfo.storeId;
    NSString *chid = data.channelId;
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
    ServiceSettlementViewController *controller = [[ServiceSettlementViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)buyAgainFailure:(NSError *)error {
    [[iToast makeText:@"再次购买失败，请稍后再试"] show];
}

@end
