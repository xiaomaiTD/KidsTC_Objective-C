//
//  FlashServiceOrderDetailViewController.m
//  KidsTC
//
//  Created by zhanping on 8/17/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "FlashServiceOrderDetailViewController.h"
#import "GHeader.h"
#import "FlashServiceOrderDetailModel.h"
#import "NSString+Category.h"
#import "UIBarButtonItem+Category.h"
#import "OnlineCustomerService.h"
#import "GuideManager.h"
#import "BuryPointManager.h"

#import "FlashServiceOrderDetailBaseCell.h"
#import "FlashServiceOrderDetailAddressCell.h"
#import "FlashServiceOrderDetailServiceInfoCell.h"
#import "FlashServiceOrderDetailStoreInfoCell.h"
#import "FlashServiceOrderDetailBookingFailureCell.h"
#import "FlashServiceOrderDetailBookingCell.h"
#import "FlashServiceOrderDetailProgressCell.h"
#import "FlashServiceOrderDetailOrderInfoCell.h"
#import "FlashServiceOrderDetailRemarksCell.h"
#import "FlashServiceOrderDetailRefundTipCell.h"
#import "FlashServiceOrderDetailRefundInfoCell.h"
#import "FlashServiceOrderDetailCountDownCell.h"

#import "FlashServiceOrderDetailRemindView.h"
#import "FlashServiceOrderDetailToolBar.h"

#import "WebViewController.h"
#import "FlashDetailViewController.h"
#import "StoreDetailViewController.h"
#import "OrderRefundViewController.h"
#import "CashierDeskViewController.h"
#import "FlashBalanceSettlementViewController.h"
#import "CommentFoundingViewController.h"
#import "OrderBookingViewController.h"

#define TOOLBAR_HEIGHT 64

@interface FlashServiceOrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource,FlashServiceOrderDetailBaseCellDelegate,FlashServiceOrderDetailToolBarDelegate,OrderRefundViewControllerDelegate,CommentFoundingViewControllerDelegate,FlashServiceOrderDetailRemindViewDelegate>
@property (nonatomic, weak  ) UITableView                            *tableView;
@property (nonatomic, weak  ) FlashServiceOrderDetailToolBar         *toolBar;
@property (nonatomic, strong) FlashServiceOrderDetailAddressCell     *addressCell;
@property (nonatomic, strong) FlashServiceOrderDetailServiceInfoCell *serviceInfoCell;
@property (nonatomic, strong) FlashServiceOrderDetailStoreInfoCell   *storeInfoCell;
@property (nonatomic, strong) FlashServiceOrderDetailBookingFailureCell *bookingFailureCell;
@property (nonatomic, strong) FlashServiceOrderDetailBookingCell     *bookingCell;
@property (nonatomic, strong) FlashServiceOrderDetailProgressCell    *progressCell;
@property (nonatomic, strong) FlashServiceOrderDetailOrderInfoCell   *orderInfoCell;
@property (nonatomic, strong) FlashServiceOrderDetailRemarksCell     *remarksCell;
@property (nonatomic, strong) FlashServiceOrderDetailRefundTipCell   *refundTipCell;
@property (nonatomic, strong) FlashServiceOrderDetailCountDownCell   *countDownCell;

@property (nonatomic, strong) NSArray<NSArray<FlashServiceOrderDetailBaseCell *> *> *sections;

@property (nonatomic, strong) FlashServiceOrderDetailData *data;

@property (nonatomic, strong) FlashServiceOrderDetailRemindView *headerView;
@property (nonatomic, strong) UIBarButtonItem *contactBarButtonItem;
@end

@implementation FlashServiceOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![self.orderId isNotNull]) {
        [[iToast makeText:@"订单编号为空"] show];
        return;
    }
    
    self.pageId = 11004;
    
    self.navigationItem.title = @"订单详情";
    
    [self setupNaviItem];
    
    [self setupTableView];
    
    [self setupHeaderView];
    
    [self setupToolBar];
    
    [self prepareCells];
    
    [self loadOrderDetail];
    
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tableView.estimatedRowHeight = 44.0f;
    tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:tableView];
    _tableView = tableView;
}

- (void)setupHeaderView {
    _headerView = [self viewWithNib:@"FlashServiceOrderDetailRemindView"];
    _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 70);
    _headerView.delegate = self;
}

- (void)setupToolBar {
    FlashServiceOrderDetailToolBar *toolBar = [self viewWithNib:@"FlashServiceOrderDetailToolBar"];
    toolBar.frame = CGRectMake(0, SCREEN_HEIGHT-TOOLBAR_HEIGHT, SCREEN_WIDTH, TOOLBAR_HEIGHT);
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
    _toolBar = toolBar;
}

- (void)setupNaviItem {
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
        NSArray *phones = self.data.supplierPhones;
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
    NSDictionary *params = @{@"orderId":self.orderId};
    [BuryPointManager trackEvent:@"event_click_falsh_callmerchant" actionId:21610 params:params];
}

- (void)contectOnlineCustomerService {
    WebViewController *controller = [[WebViewController alloc] init];
    controller.urlString = [OnlineCustomerService onlineCustomerServiceLinkUrlString];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)prepareCells{
    _addressCell              = [self viewWithNib:@"FlashServiceOrderDetailAddressCell"];
    _serviceInfoCell          = [self viewWithNib:@"FlashServiceOrderDetailServiceInfoCell"];
    _serviceInfoCell.delegate = self;
    _storeInfoCell            = [self viewWithNib:@"FlashServiceOrderDetailStoreInfoCell"];
    _storeInfoCell.delegate   = self;
    _bookingFailureCell       = [self viewWithNib:@"FlashServiceOrderDetailBookingFailureCell"];
    _bookingFailureCell.delegate = self;
    _bookingCell              = [self viewWithNib:@"FlashServiceOrderDetailBookingCell"];
    _bookingCell.delegate     = self;
    _progressCell             = [self viewWithNib:@"FlashServiceOrderDetailProgressCell"];
    _orderInfoCell            = [self viewWithNib:@"FlashServiceOrderDetailOrderInfoCell"];
    _orderInfoCell.delegate   = self;
    _remarksCell              = [self viewWithNib:@"FlashServiceOrderDetailRemarksCell"];
    _refundTipCell            = [self viewWithNib:@"FlashServiceOrderDetailRefundTipCell"];
    _countDownCell            = [self viewWithNib:@"FlashServiceOrderDetailCountDownCell"];
}

- (id)viewWithNib:(NSString *)nib{
    return [[NSBundle mainBundle] loadNibNamed:nib owner:self options:nil].firstObject;
}

- (void)loadOrderDetail{
    NSDictionary *param = @{@"orderId":self.orderId};
    [TCProgressHUD showSVP];
    [Request startWithName:@"GET_FS_ORDER_DETAIL" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
         FlashServiceOrderDetailData *data = [FlashServiceOrderDetailModel modelWithDictionary:dic].data;
        if (data) {
            [self loadOrderDetailSuccess:data];
        }else{
            [self loadOrderDetailFailure:nil];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self loadOrderDetailFailure:error];
    }];
}

- (void)loadOrderDetailSuccess:(FlashServiceOrderDetailData *)data {
    self.data = data;
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

- (void)setData:(FlashServiceOrderDetailData *)data {
    _data = data;
    self.navigationItem.rightBarButtonItem = self.contactBarButtonItem;
    if ([data.noticePageUrl isNotNull]) {
        _tableView.tableHeaderView = _headerView;
    }else{
        [self nilTableHeaderView];
    }
    if (data.canShowButton) {
        [[GuideManager shareGuideManager] checkGuideWithTarget:self type:GuideTypeOrderDetail resultBlock:nil];
    }
    [self setupSections:data];
    _toolBar.data = data;
    _tableView.contentInset = UIEdgeInsetsMake(64, 0, _toolBar.hidden?0:TOOLBAR_HEIGHT, 0);
    _tableView.scrollIndicatorInsets = _tableView.contentInset;
    [self.tableView reloadData];
}

- (void)setupSections:(FlashServiceOrderDetailData *)data {
    NSMutableArray *sections = [NSMutableArray array];
    //1.收货地址
    if (data.userAddress) {
        NSMutableArray *section00 = [NSMutableArray array];
        [section00 addObject:_addressCell];
        [sections addObject:section00];
    }
    //2.服务信息、门店信息、在线预约信息
    NSMutableArray *section01 = [NSMutableArray array];
    [section01 addObject:_serviceInfoCell];
    if (data.storeInfo) [section01 addObject:_storeInfoCell];
    [sections addObject:section01];
    
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
    
    //3.进度
    if (data.priceConfigs.count>0 && data.isFlashSuccess) {
        NSMutableArray *section03 = [NSMutableArray array];
        [section03 addObject:_progressCell];
        [sections addObject:section03];
    }
    //4.订单信息
    NSMutableArray *section04 = [NSMutableArray array];
    [section04 addObject:_orderInfoCell];
    [sections addObject:section04];
    //5.备注信息
    if (data.remarksStr.length>0) {
        NSMutableArray *section05 = [NSMutableArray array];
        [section05 addObject:_remarksCell];
        [sections addObject:section05];
    }
    //6.退款信息
    if (data.refunds.count>0) {
        NSMutableArray *section06 = [NSMutableArray array];
        [section06 addObject:_refundTipCell];
        [data.refunds enumerateObjectsUsingBlock:^(FlashServiceOrderDetailRefund * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            FlashServiceOrderDetailRefundInfoCell *refundInfoCell = [self viewWithNib:@"FlashServiceOrderDetailRefundInfoCell"];
            refundInfoCell.tag = idx;
            [section06 addObject:refundInfoCell];
        }];
        [sections addObject:section06];
    }
    //7.倒计时
    if (data.isShowCountDown) {
        NSMutableArray *section07 = [NSMutableArray array];
        [section07 addObject:_countDownCell];
        [sections addObject:section07];
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
    FlashServiceOrderDetailBaseCell *cell = self.sections[indexPath.section][indexPath.row];
    cell.data = self.data;
    return cell;
}


#pragma mark - FlashServiceOrderDetailBaseCellDelegate

- (void)flashServiceOrderDetailBaseCell:(FlashServiceOrderDetailBaseCell *)cell actionType:(FlashServiceOrderDetailBaseCellActionType)type {
    switch (type) {
        case FlashServiceOrderDetailBaseCellActionTypeService:
        {
            [self serviceInfo];
        }
            break;
        case FlashServiceOrderDetailBaseCellActionTypeStore:
        {
            [self storeInfo];
        }
            break;
        case FlashServiceOrderDetailBaseCellActionTypeReload:
        {
            [self loadOrderDetail];
        }
            break;
        case FlashServiceOrderDetailBaseCellActionTypeContact:
        {
            [self makePhoneCallToCS];
        }
            break;
        case FlashServiceOrderDetailBaseCellActionTypeBooking:
        {
            [self booking:NO];
        }
            break;
        case FlashServiceOrderDetailBaseCellActionTypeBookingMustEdit:
        {
            [self booking:YES];
        }
            break;
    }
}

- (void)serviceInfo {
    FlashDetailViewController *controller = [[FlashDetailViewController alloc] init];
    controller.pid = self.data.fsSysNo;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)storeInfo {
    StoreDetailViewController *controller = [[StoreDetailViewController alloc] initWithStoreId:self.data.storeInfo.storeId];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)makePhoneCallToCS {
    NSArray *phones = self.data.supplierPhones;
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
    OrderBookingViewController *controller = [[OrderBookingViewController alloc] init];
    controller.orderNo = self.data.orderId;
    controller.mustEdit = mustEdit;
    controller.successBlock = ^void (){
        [self loadOrderDetail];
    };
    [self.navigationController pushViewController:controller animated:YES];
    NSDictionary *params = @{@"orderId":self.orderId};
    [BuryPointManager trackEvent:@"event_skip_flash_appoint" actionId:21614 params:params];
}

#pragma mark - FlashServiceOrderDetailRemindViewDelegate
- (void)flashServiceOrderDetailRemindView:(FlashServiceOrderDetailRemindView *)view actionType:(FlashServiceOrderDetailRemindViewActionType)type {
    switch (type) {
        case FlashServiceOrderDetailRemindViewActionTypeLink:
        {
            [self showNoti];
        }
            break;
        case FlashServiceOrderDetailRemindViewActionTypeDelete:
        {
            [self nilTableHeaderView];
        }
            break;
    }
}

- (void)showNoti {
    WebViewController *controller = [[WebViewController alloc] init];
    controller.urlString = _data.noticePageUrl;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)nilTableHeaderView {
    UIView *header = [UIView new];
    header.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0.01);
    self.tableView.tableHeaderView = header;
}

#pragma mark - FlashServiceOrderDetailToolBarDelegate

- (void)flashServiceOrderDetailToolBar:(FlashServiceOrderDetailToolBar *)toolBar btn:(FlashServiceOrderDetailToolBarButton *)btn actionType:(FlashServiceOrderDetailToolBarButtonActionType)type value:(id)value {

    switch (type) {
        case ActionTypeRefund:
        {
            [self refund];
        }
            break;
        case ActionTypeGetCode:
        {
            [self getConsumeCode:btn];
        }
            break;
        case ActionTypeLinkAction:
        {
            FDDataStatus status = self.data.status;
            switch (status) {
                    /**
                     *  等待预付 | 开团成功（已预付，待付尾款）跳转支付页
                     */
                case FDDataStatus_WaitPrePaid:
                case FDDataStatus_FlashSuccessWaitPay:
                {
                    [self gotoCashierDesk];//预付，待付尾款
                }
                    break;
                    /**
                     *  立付尾款，开团成功（已预付，没有进入确认页确认）,跳转结算页
                     */
                case FDDataStatus_FlashSuccessUnPay:
                {
                    [self getOrderConfirm];//获取订单信息
                }
                    break;
                    
                    /**
                     *  已购买，去评价
                     */
                case FDDataStatus_WaitEvalute:
                {
                    [self gotoComment];
                }
                    break;
                default:break;
            }
        }
            break;
    }
}



#pragma mark ==================退款==================

- (void)refund {
    OrderRefundViewController *controller = [[OrderRefundViewController alloc] initWithOrderId:self.orderId];
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark OrderRefundViewControllerDelegate

- (void)orderRefundViewController:(OrderRefundViewController *)vc didSucceedWithRefundForOrderId:(NSString *)identifier {
    [self loadOrderDetail];
}

#pragma mark ================获取消费码================

- (void)getConsumeCode:(FlashServiceOrderDetailToolBarButton *)btn{
    btn.enabled = NO;
    NSDictionary *param = @{@"orderId":self.orderId};
    [TCProgressHUD showSVP];
    [Request startWithName:@"ORDER_SEND_CONSUME_CODE" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        btn.enabled = NO;
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        btn.backgroundColor = [UIColor lightGrayColor];
        [btn setTitle:@"已发送消费码" forState:UIControlStateDisabled];
        [TCProgressHUD dismissSVP];
        NSString *msg = @"消费码已发送至您的手机，请注意查收！";
        NSString *text = dic[@"data"];
        if ([text isNotNull]) msg = text;
        [[iToast makeText:msg] show];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        btn.enabled = YES;
        [TCProgressHUD dismissSVP];
        NSString *errMsg = @"获取消费码失败，请稍后再试！";
        if (error.userInfo) {
            NSString *msg = [error.userInfo objectForKey:@"data"];
            if ([msg isNotNull]) errMsg = msg;
        }
        [[iToast makeText:errMsg] show];
    }];
    NSDictionary *params = @{@"orderId":self.orderId};
    [BuryPointManager trackEvent:@"event_click_flash_getsms" actionId:21611 params:params];
}

#pragma mark ================跳转收银台================

- (void)gotoCashierDesk{
    CashierDeskViewController *controller = [[CashierDeskViewController alloc] initWithNibName:@"CashierDeskViewController" bundle:nil];
    controller.orderId = self.data.orderId;
    controller.orderKind = CashierDeskOrderKindFlash;
    controller.resultBlock = ^void (BOOL needRefresh){
        [self loadOrderDetail];
    };
    [self.navigationController pushViewController:controller animated:YES];
    
    NSDictionary *params = @{@"orderId":self.orderId};
    [BuryPointManager trackEvent:@"event_skip_flash_afterpay" actionId:21613 params:params];
}

#pragma mark 获取订单信息

- (void)getOrderConfirm{
    FlashBalanceSettlementViewController *controller = [[FlashBalanceSettlementViewController alloc]init];
    controller.orderId = self.data.orderId;
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark =================去评价==================

- (void)gotoComment{
    CommentFoundingModel *model = [CommentFoundingModel modelFromFlashServiceOrderDetailData:self.data];
    CommentFoundingViewController *controller = [[CommentFoundingViewController alloc] initWithCommentFoundingModel:model];
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark CommentFoundingViewControllerDelegate

- (void)commentFoundingViewControllerDidFinishSubmitComment:(CommentFoundingViewController *)vc {
    [self loadOrderDetail];
}







@end
