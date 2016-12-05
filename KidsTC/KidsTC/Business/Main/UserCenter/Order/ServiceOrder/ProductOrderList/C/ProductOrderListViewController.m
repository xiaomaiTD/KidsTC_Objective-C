//
//  ProductOrderListViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/16.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderListViewController.h"
#import "UIBarButtonItem+Category.h"
#import "GHeader.h"
#import "NSString+Category.h"
#import "OnlineCustomerService.h"


#import "ProductOrderListAllTitleRowItem.h"

#import "ProductOrderListAllTitleView.h"
#import "ProductOrderListAllTitleShowView.h"
#import "ProductOrderListModel.h"
#import "ProductOrderListView.h"

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

@interface ProductOrderListViewController ()<ProductOrderListViewDelegate,CommentFoundingViewControllerDelegate,ProductOrderListAllTitleShowViewDelegate>
@property (nonatomic, assign) ProductOrderListType type;
@property (nonatomic, assign) ProductOrderListOrderType orderType;
@property (nonatomic, strong) ProductOrderListView *listView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSArray *items;


@property (nonatomic, strong) ProductOrderListAllTitleView *allTitleView;
@property (nonatomic, strong) ProductOrderListAllTitleShowView *allTitleShowView;
@end

@implementation ProductOrderListViewController

- (instancetype)initWithType:(ProductOrderListType)type {
    self = [super init];
    if (self) {
        self.type = type;
        self.orderType = ProductOrderListOrderTypeAll;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.naviTheme = NaviThemeWihte;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"ProductOrderList_message" highImageName:@"ProductOrderList_message" postion:UIBarButtonPositionRight target:self action:@selector(message)];
    
    ProductOrderListView *listView = [[ProductOrderListView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    listView.delegate = self;
    [self.view addSubview:listView];
    self.listView = listView;
    
    [self setupTitle];
}

- (void)setupTitle {
    switch (_type) {
        case ProductOrderListTypeAll://全部订单
        case ProductOrderListTypeCompleted://已完成订单
        case ProductOrderListTypeCancled://已取消订单
        {
            _allTitleShowView = [[NSBundle mainBundle] loadNibNamed:@"ProductOrderListAllTitleShowView" owner:self options:nil].firstObject;
            _allTitleShowView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
            _allTitleShowView.delegate = self;
            [self.view addSubview:_allTitleShowView];
            
            _allTitleView = [[NSBundle mainBundle] loadNibNamed:@"ProductOrderListAllTitleView" owner:self options:nil].firstObject;
            _allTitleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
            WeakSelf(self)
            _allTitleView.acitonBlock = ^(BOOL open) {
                StrongSelf(self)
                self.allTitleShowView.open = open;
            };
            self.navigationItem.titleView = _allTitleView;
        }
            break;
        case ProductOrderListTypeWaitPay:
        {
            self.navigationItem.title = @"待付款";
        }
            break;
        case ProductOrderListTypeWaiatUse:
        {
            self.navigationItem.title = @"待使用";
        }
            break;
        case ProductOrderListTypeWaitRecive:
        {
            self.navigationItem.title = @"待收货";
        }
            break;
        case ProductOrderListTypeWaitComment:
        {
            self.navigationItem.title = @"待评价";
        }
            break;
        case ProductOrderListTypeRefund:
        {
            self.navigationItem.title = @"退款/售后";
        }
            break;
    }
}

- (void)message {
    NotificationCenterViewController *controller = [[NotificationCenterViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - ProductOrderListViewDelegate

- (void)productOrderListView:(ProductOrderListView *)view actionType:(ProductOrderListViewActionType)type value:(id)value {
    switch (type) {
        case ProductOrderListViewActionTypePay:/// 付款
        {
            [self payNow:value];
        }
            break;
        case ProductOrderListViewActionTypeCancelOrder:/// 取消订单
        {
            [self cancleOrder:value];
        }
            break;
        case ProductOrderListViewActionTypeConnectService:/// 联系客服
        {
            [self connectService:value];
        }
            break;
        case ProductOrderListViewActionTypeConnectSupplier:/// 联系商家
        {
            [self connectSupplier:value];
        }
            break;
        case ProductOrderListViewActionTypeConsumeCode:/// 取票码
        {
            
        }
            break;
        case ProductOrderListViewActionTypeReserve:/// 我要预约
        {
            [self booking:value];
        }
            break;
        case ProductOrderListViewActionTypeCancelTip:/// 取消提醒
        {
            
        }
            break;
        case ProductOrderListViewActionTypeWantTip:/// 活动提醒
        {
            
        }
            break;
        case ProductOrderListViewActionTypeReminder:/// 我要催单
        {
            
        }
            break;
        case ProductOrderListViewActionTypeConfirmDeliver:/// 确认收货
        {
            [self confirmDeliver:value];
        }
            break;
        case ProductOrderListViewActionTypeEvaluate:/// 评价
        {
            [self comment:value];
        }
            break;
        case ProductOrderListViewActionTypeBuyAgain:/// 再次购买
        {
            [self buyAgain:value];
        }
            break;
        case ProductOrderListViewActionTypeComplaint:/// 投诉
        {
            [self connectService:value];
        }
            break;
        case ProductOrderListViewActionTypeStore://门店详情
        {
            [self storeInfo:value];
        }
            break;
        case ProductOrderListViewActionTypeLoadData://加载数据
        {
            [self loadData:[value boolValue]];
        }
            break;
    }
}

#pragma mark ================立即支付================

- (void)payNow:(ProductOrderListItem *)item {
    
    CashierDeskViewController *controller = [[CashierDeskViewController alloc]initWithNibName:@"CashierDeskViewController" bundle:nil];
    controller.orderId = item.orderNo;
    controller.orderKind = CashierDeskOrderKindService;
    controller.resultBlock = ^void (BOOL needRefresh){
        
    };
}

#pragma mark ================取消订单================

- (void)cancleOrder:(ProductOrderListItem *)item {
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
}

- (void)cancelOrderFailed:(NSError *)error {
    [[iToast makeText:@"取消订单失败"] show];
}

#pragma mark ================再次购买================

- (void)buyAgain:(ProductOrderListItem *)item {
    NSString *productid = item.productNo;
    NSString *storeno = @"";
    NSString *chid = item.chId;
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

#pragma mark ================联系客服================

- (void)connectService:(ProductOrderListItem *)item {
    NSString *str = [OnlineCustomerService onlineCustomerServiceLinkUrlString];
    WebViewController *controller = [[WebViewController alloc]init];
    controller.urlString = str;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark ================联系商家================

- (void)connectSupplier:(ProductOrderListItem *)item {
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

#pragma mark ================我要预约================

- (void)booking:(ProductOrderListItem *)item {
    OrderBookingViewController *controller = [[OrderBookingViewController alloc]init];
    controller.orderNo = item.orderNo;
    controller.mustEdit = NO;
    controller.successBlock = ^void(){
        
    };
}

#pragma mark ================确认收货================

- (void)confirmDeliver:(ProductOrderListItem *)item {
    
}

#pragma mark ================发表评论================

- (void)comment:(ProductOrderListItem *)item{
    CommentFoundingViewController *controller = [[CommentFoundingViewController alloc] initWithCommentFoundingModel:[CommentFoundingModel modelFromProductOrderListItem:item]];
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark CommentFoundingViewControllerDelegate

- (void)commentFoundingViewControllerDidFinishSubmitComment:(CommentFoundingViewController *)vc {
    
}

- (void)storeInfo:(ProductOrderListItem *)item {
//    StoreDetailViewController *controller = [[StoreDetailViewController alloc] initWithStoreId:item.storeNo];
//    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark ================加载数据================

- (void)loadData:(BOOL)refresh {
    self.page = refresh?1:++self.page;
    NSDictionary *param = @{@"page":@(self.page),
                            @"pageCount":@(ProductOrderListPageCount),
                            @"type":@(self.type),
                            @"orderType":@(self.orderType)};
    [Request startWithName:@"SEARCH_ORDER_V2" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        ProductOrderListModel *model = [ProductOrderListModel modelWithDictionary:dic];
        if (refresh) {
            self.items = model.data;
        }else{
            NSMutableArray *items = [NSMutableArray arrayWithArray:self.items];
            [items addObjectsFromArray:model.data];
            self.items = [NSArray arrayWithArray:items];
        }
        self.listView.items = self.items;
        [self.listView dealWithUI:model.data.count];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.listView dealWithUI:0];
    }];
}

#pragma mark - ProductOrderListAllTitleShowViewDelegate

- (void)ProductOrderListAllTitleShowView:(ProductOrderListAllTitleShowView *)view actionType:(ProductOrderListAllTitleShowViewActionType)type value:(id)value {
    view.open = NO;
    [self.allTitleView setupSelected];
    switch (type) {
        case ProductOrderListAllTitleShowViewActionTypeAll://全部订单
        {
            [self changeType:value type:ProductOrderListTypeAll];
        }
            break;
        case ProductOrderListAllTitleShowViewActionTypeCompleted://已完成订单
        {
            [self changeType:value type:ProductOrderListTypeCompleted];
        }
            break;
        case ProductOrderListAllTitleShowViewActionTypeCancled://已取消订单
        {
            [self changeType:value type:ProductOrderListTypeCancled];
        }
            break;
        case ProductOrderListAllTitleShowViewActionTypeTicket://票务
        {
            [self changeOrderType:value orderType:ProductOrderListOrderTypeTicket];
        }
            break;
        case ProductOrderListAllTitleShowViewActionTypeRealObject://商品
        {
            [self changeOrderType:value orderType:ProductOrderListOrderTypeRealObject];
        }
            break;
        case ProductOrderListAllTitleShowViewActionTypeActivity://普通订单（活动）
        {
            [self changeOrderType:value orderType:ProductOrderListOrderTypeNormal];
        }
            break;
        case ProductOrderListAllTitleShowViewActionTypeFlash://闪购
        {
            [self jumpToFlashOrderList:value];
        }
            break;
        case ProductOrderListAllTitleShowViewActionTypeAppoinment://我的预约,
        {
            [self jumpToAppoinmentOrderList:value];
        }
            break;
        case ProductOrderListAllTitleShowViewActionTypeRadish://萝卜兑换
        {
            [self jumpToRadishOrderList:value];
        }
            break;
        case ProductOrderListAllTitleShowViewActionTypeLottery://我的抽奖
        {
            [self jumpToLotteryOrderList:value];
        }
            break;
        case ProductOrderListAllTitleShowViewActionTypeActivityRegister://活动报名
        {
            [self jumpToActivityRegisterOrderList:value];
        }
            break;
        case ProductOrderListAllTitleShowViewActionTypeClose://关闭
        {
            [self titleViewClose:value];
        }
            break;
    }
}

#pragma mark ================更换类型================

- (void)changeType:(ProductOrderListAllTitleRowItem *)item type:(ProductOrderListType)type {
    self.type = type;
    self.orderType = ProductOrderListOrderTypeAll;
    self.allTitleView.title = item.title;
    [self.listView beginRefreshing];
}

#pragma mark ================更换订单类型================

- (void)changeOrderType:(ProductOrderListAllTitleRowItem *)item orderType:(ProductOrderListOrderType)orderType {
    self.type = ProductOrderListTypeAll;
    self.orderType = orderType;
    self.allTitleView.title = item.title;
    [self.listView beginRefreshing];
}

#pragma mark  ================闪购================

- (void)jumpToFlashOrderList:(ProductOrderListAllTitleRowItem *)item {
    FlashServiceOrderListViewController *controller = [[FlashServiceOrderListViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark ================我的预约================

- (void)jumpToAppoinmentOrderList:(ProductOrderListAllTitleRowItem *)item {
    AppointmentOrderListViewController *controller = [[AppointmentOrderListViewController alloc] initWithNibName:@"AppointmentOrderListViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark ================萝卜兑换================

- (void)jumpToRadishOrderList:(ProductOrderListAllTitleRowItem *)item {
    [[iToast makeText:@"该功能暂时还没有接入哦"] show];
}

#pragma mark ================我的抽奖================

- (void)jumpToLotteryOrderList:(ProductOrderListAllTitleRowItem *)item {
    ProductOrderFreeListViewController *controller = [[ProductOrderFreeListViewController alloc] init];
    controller.type = ProductOrderFreeListTypeLottery;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark ================活动报名================

- (void)jumpToActivityRegisterOrderList:(ProductOrderListAllTitleRowItem *)item {
    ProductOrderFreeListViewController *controller = [[ProductOrderFreeListViewController alloc] init];
    controller.type = ProductOrderFreeListTypeFreeActivity;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark ================关闭================

- (void)titleViewClose:(ProductOrderListAllTitleRowItem *)item {
    
}


@end
