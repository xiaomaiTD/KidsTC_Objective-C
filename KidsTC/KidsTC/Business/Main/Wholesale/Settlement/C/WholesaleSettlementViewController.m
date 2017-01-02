//
//  WholesaleSettlementViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleSettlementViewController.h"
#import "UIBarButtonItem+Category.h"
#import "GHeader.h"
#import "NSString+Category.h"
#import "KTCPaymentService.h"
#import "BuryPointManager.h"

#import "WholesaleSettlementModel.h"
#import "WholesaleSettlementView.h"

#import "SettlementPickStoreViewController.h"
#import "ServiceSettlementSelectPlaceViewController.h"
#import "CommonShareViewController.h"
#import "WebViewController.h"
#import "SettlementResultNewViewController.h"
#import "NavigationController.h"
#import "WholesaleOrderDetailViewController.h"

@interface WholesaleSettlementViewController ()<WholesaleSettlementViewDelegate>
@property (nonatomic, strong) WholesaleSettlementView *settlementView;
@property (nonatomic, strong) WholesaleSettlementData *data;
@end

@implementation WholesaleSettlementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![self.productId isNotNull]) {
        [[iToast makeText:@"商品编号为空"] show];
        [self back];
        return;
    }
    
    self.navigationItem.title = @"拼团";
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    WholesaleSettlementView *settlementView = [[WholesaleSettlementView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    settlementView.delegate = self;
    [self.view addSubview:settlementView];
    self.settlementView = settlementView;
    
    /*
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImagePostion:UIBarButtonPositionRight target:self action:@selector(share) andGetButton:^(UIButton *btn) {
        [btn setImageEdgeInsets:UIEdgeInsetsMake(3, 3, 3, 3)];
        [btn setImage:[UIImage imageNamed:@"wholesale_share"] forState:UIControlStateNormal];
    }];
    */
    
    [self loadData];
}

- (void)share {
    CommonShareViewController *controller = [CommonShareViewController instanceWithShareObject:self.data.shareObject sourceType:KTCShareServiceTypeWholesale];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)loadData {
    NSDictionary *param = @{@"fightGroupId":_productId,
                            @"openGroupId":_openGroupId};
    [TCProgressHUD showSVP];
    [Request startWithName:@"GET_PRODUCT_TUAN_ORDER_CONFIRM" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        WholesaleSettlementData *data = [WholesaleSettlementModel modelWithDictionary:dic].data;
        if (data) {
            [self loadDataSuccess:data];
        }else{
            [self loadDataFailure:nil];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self loadDataFailure:error];
    }];
}

- (void)loadDataSuccess:(WholesaleSettlementData *)data{
    self.data = data;
    self.settlementView.data = data;
}

- (void)loadDataFailure:(NSError *)error{
    [iToast makeText:@"拼团结算信息获取失败，请稍后再试"];
    [self back];
}

#pragma mark - WholesaleSettlementViewDelegate

- (void)wholesaleSettlementView:(WholesaleSettlementView *)view actionType:(WholesaleSettlementViewActionType)type value:(id)value {
    
    switch (type) {
        case WholesaleSettlementViewActionTypeSelectStore://切换门店
        {
            [self selectStore];
        }
            break;
        case WholesaleSettlementViewActionTypeSelectPlace://切换地址
        {
            [self selectPlace];
        }
            break;
        case WholesaleSettlementViewActionTypeRule://查看活动规则
        {
            [self rule];
        }
            break;
        case WholesaleSettlementViewActionTypePlaceOrder://下单
        {
            [self placeOrder];
        }
            break;
    }
}

#pragma makr 切换门店

- (void)selectStore {
    SettlementPickStoreViewController *controller = [[SettlementPickStoreViewController alloc]init];
    controller.stores = self.data.storeItems;
    controller.pickStoreBlock = ^void (SettlementPickStoreDataItem *store){
        self.data.store = [WholesaleSettlementStore storeWithObj:store];
        [self.settlementView reloadData];
    };
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark 切换地址

- (void)selectPlace {
    ServiceSettlementSelectPlaceViewController *controller = [[ServiceSettlementSelectPlaceViewController alloc] initWithNibName:@"ServiceSettlementSelectPlaceViewController" bundle:nil];
    controller.currentIndex = self.data.currentPlaceIndex;
    controller.places = self.data.places;
    controller.actionBlock = ^(NSInteger selectIndex){
        self.data.currentPlaceIndex = selectIndex;
        [self.settlementView reloadData];
    };
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark 查看活动规则

- (void)rule {
    NSString *url = self.data.flowUrl;
    if ([url isNotNull]) {
        WebViewController *controller = [[WebViewController alloc] init];
        controller.urlString = url;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark 下单

- (void)placeOrder {
    WholesaleSettlementData *data = self.data;
    
    if (![self.productId isNotNull]) {
        [[iToast makeText:@"商品编号为空"] show];
        return;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:self.productId forKey:@"fightGroupId"];
    if ([self.openGroupId isNotNull]) {
        [param setObject:self.openGroupId forKey:@"openGroupId"];
    }
    NSString *storeNo = data.store.storeId;
    if ([storeNo isNotNull]) {
        [param setObject:storeNo forKey:@"storeNo"];
    }
    if (data.currentPlaceIndex<data.place.count) {
        WholesaleSettlementPlace *place = data.place[data.currentPlaceIndex];
        NSString *placeNo = place.sysNo;
        if ([placeNo isNotNull]) {
            [param setObject:placeNo forKey:@"placeNo"];
        }
    }
    [param setObject:@(self.data.payType) forKey:@"paytype"];
    [TCProgressHUD showSVP];
    [Request startWithName:@"PRODUCT_TUAN_PLACE_ORDER" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        PayModel *model = [PayModel modelWithDictionary:dic];
        if ([model.data.orderNo isNotNull]) {
            [self placeOrderSucceed:model];
        }else{
            [self placeOrderFailure:nil];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self placeOrderFailure:error];
    }];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if ([self.productId isNotNull]) {
        [params setObject:self.productId forKey:@"pid"];
    }
    if ([self.openGroupId isNotNull]) {
        [params setObject:self.openGroupId forKey:@"gid"];
    }
    [BuryPointManager trackEvent:@"event_click_group_pay" actionId:21802 params:params];
}

#pragma mark - 下单结果

/** 下单成功 -> 结算 */
- (void)placeOrderSucceed:(PayModel *)model {
    [KTCPaymentService startPay:model.data.payInfo succeed:^{
        [self settlementPaid:YES model:model];
        [[iToast makeText:@"结算成功"] show];
    } failure:^(NSError *error) {
        NSString *errMsg = @"结算失败";
        NSString *text = error.userInfo[@"kErrMsgKey"];
        if ([text isKindOfClass:[NSString class]] && [text length] > 0) errMsg = text;
        [[iToast makeText:errMsg] show];
    }];
}

/** 下单失败 -> 提示 */
- (void)placeOrderFailure:(NSError *)error {
    NSString *errMsg = @"下单失败";
    NSString *text = [[error userInfo] objectForKey:@"data"];
    if ([text isKindOfClass:[NSString class]] && [text length] > 0) errMsg = text;
    [[iToast makeText:errMsg] show];
}

#pragma mark - 结算结果
- (void)settlementPaid:(BOOL)paid model:(PayModel *)model{
    WholesaleOrderDetailViewController *controller = [[WholesaleOrderDetailViewController alloc]init];
    controller.productId = self.productId;
    controller.openGroupId = model.data.openGroupId;
    NavigationController *navi = [[NavigationController alloc]initWithRootViewController:controller];
    [self presentViewController:navi animated:YES completion:^{
        [self.navigationController popToRootViewControllerAnimated:NO];
    }];
}
@end
