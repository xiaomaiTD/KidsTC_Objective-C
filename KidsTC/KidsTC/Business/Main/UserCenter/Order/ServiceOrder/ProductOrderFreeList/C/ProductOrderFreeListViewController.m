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

#import "ProductOrderFreeListModel.h"
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


@interface ProductOrderFreeListViewController ()<ProductOrderFreeListViewDelegate,CommentFoundingViewControllerDelegate>
@property (nonatomic, strong) ProductOrderFreeListView *listView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSArray *items;
@end

@implementation ProductOrderFreeListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    switch (_type) {
        case ProductOrderFreeListTypeFreeActivity:
        {
            self.navigationItem.title = @"活动报名";
        }
            break;
        case ProductOrderFreeListTypeLottery:
        {
            self.navigationItem.title = @"我的抽奖";
        }
            break;
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.naviTheme = NaviThemeWihte;
    
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


#pragma mark - ProductOrderFreeListViewDelegate

- (void)productOrderFreeListView:(ProductOrderFreeListView *)view actionType:(ProductOrderFreeListViewActionType)type value:(id)value {
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
            
        }
            break;
        case ProductOrderFreeListViewActionTypeReserve:/// 我要预约
        {
            [self booking:value];
        }
            break;
        case ProductOrderFreeListViewActionTypeCancelTip:/// 取消提醒
        {
            
        }
            break;
        case ProductOrderFreeListViewActionTypeWantTip:/// 活动提醒
        {
            
        }
            break;
        case ProductOrderFreeListViewActionTypeReminder:/// 我要催单
        {
            
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
            default:
            break;
    }
}

#pragma mark ================立即支付================

- (void)payNow:(ProductOrderFreeListItem *)item {
    
    CashierDeskViewController *controller = [[CashierDeskViewController alloc]initWithNibName:@"CashierDeskViewController" bundle:nil];
    controller.orderId = item.orderNo;
    controller.orderKind = CashierDeskOrderKindService;
    controller.resultBlock = ^void (BOOL needRefresh){
        
    };
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
}

- (void)cancelOrderFailed:(NSError *)error {
    [[iToast makeText:@"取消订单失败"] show];
}

#pragma mark ================再次购买================

- (void)buyAgain:(ProductOrderFreeListItem *)item {
    NSString *productid = item.productSysNo;
    NSString *storeno = item.storeInfo.storeId;
    NSString *chid = item.channelId;
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

#pragma mark ================我要预约================

- (void)booking:(ProductOrderFreeListItem *)item {
    OrderBookingViewController *controller = [[OrderBookingViewController alloc]init];
    controller.orderNo = item.orderNo;
    controller.mustEdit = NO;
    controller.successBlock = ^void(){
        
    };
}

#pragma mark ================确认收货================

- (void)confirmDeliver:(ProductOrderFreeListItem *)item {
    
}

#pragma mark ================发表评论================

- (void)comment:(ProductOrderFreeListItem *)item{
    CommentFoundingViewController *controller = [[CommentFoundingViewController alloc] initWithCommentFoundingModel:[CommentFoundingModel modelFromProductOrderFreeListItem:item]];
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark CommentFoundingViewControllerDelegate

- (void)commentFoundingViewControllerDidFinishSubmitComment:(CommentFoundingViewController *)vc {
    
}

- (void)storeInfo:(ProductOrderFreeListItem *)item {
    StoreDetailViewController *controller = [[StoreDetailViewController alloc] initWithStoreId:item.storeInfo.storeId];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark ================加载数据================

- (void)loadData:(BOOL)refresh {
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
        [self.listView dealWithUI:model.data.count];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.listView dealWithUI:0];
    }];
}



@end
