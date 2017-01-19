//
//  RadishSettlementViewController.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/5.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishSettlementViewController.h"
#import "GHeader.h"
#import "NSString+Category.h"
#import "NavigationController.h"
#import "KTCPaymentService.h"

#import "RadishSettlementView.h"
#import "RadishSettlementModel.h"

#import "UserAddressEditViewController.h"
#import "UserAddressManageViewController.h"
#import "SettlementPickStoreViewController.h"
#import "ServiceSettlementSelectPlaceViewController.h"
#import "SettlementResultNewViewController.h"

@interface RadishSettlementViewController ()<RadishSettlementViewDelegate>
@property (nonatomic, strong) RadishSettlementView *settlementView;
@property (nonatomic, strong) RadishSettlementData *data;
@end

@implementation RadishSettlementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"结算";
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.pageId = 11302;
    
    RadishSettlementView *settlementView = [[RadishSettlementView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    settlementView.delegate = self;
    [self.view addSubview:settlementView];
    self.settlementView = settlementView;
    
    [self loadData];
}

- (void)loadData {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    NSString *userAddress = self.data.userAddressInfo.ID;
    if ([userAddress isNotNull]) {
        [param setObject:userAddress forKey:@"userAddress"];
    }
    
    NSInteger buyNum = self.data.buyNum;
    if (buyNum<1) {
        buyNum = 1;
    }
    [param setObject:@(buyNum) forKey:@"buyNum"];
    
    NSString *storeNo = self.data.store.storeId;
    if ([storeNo isNotNull]) {
        [param setObject:storeNo forKey:@"storeNo"];
    }
    
    if (self.data.placeType == PlaceTypePlace) {
        NSUInteger placeIndex = self.data.currentPlaceIndex;
        NSArray<ServiceSettlementPlace *> *place = self.data.place;
        if (placeIndex<place.count) {
            ServiceSettlementPlace *placeItem = place[placeIndex];
            NSString *place = placeItem.sysNo;
            if ([place isNotNull]) {
                [param setObject:place forKey:@"place"];
            }
        }
    }
    
    [TCProgressHUD showSVP];
    [Request startWithName:@"GET_RADISH_ORDER_CONFIRM" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        RadishSettlementData *data = [RadishSettlementModel modelWithDictionary:dic].data;
        [self loadDataSuccess:data];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self loadDataFailure:error];
    }];
}

- (void)loadDataSuccess:(RadishSettlementData *)data{
    _data = data;
    self.settlementView.data = data;
}

- (void)loadDataFailure:(NSError *)error {
    NSString *errMsg = @"结算信息查询失败";
    NSString *text = [NSString stringWithFormat:@"%@",error.userInfo[@"data"]];
    if ([text isNotNull]) errMsg = text;
    [[iToast makeText:errMsg] show];
    [self back];
}

#pragma mark - RadishSettlementViewDelegate

- (void)radishSettlementView:(RadishSettlementView *)view actionType:(RadishSettlementViewActionType)type value:(id)value {
    
    switch (type) {
        case RadishSettlementViewActionTypeTipAddress://添加收货地址
        {
            UserAddressEditViewController *controller = [[UserAddressEditViewController alloc]init];
            controller.editType = UserAddressEditTypeAdd;
            controller.resultBlock = ^void(UserAddressManageDataItem *item){
                [self loadData];
            };
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case RadishSettlementViewActionTypeAddress://切换收货地址
        {
            UserAddressManageViewController *controller = [[UserAddressManageViewController alloc]init];
            controller.fromeType = UserAddressManageFromTypeSettlement;
            controller.pickeAddressBlock = ^void (UserAddressManageDataItem *item){
                self.data.userAddressInfo = item;
                [self.settlementView reloadData];
            };
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case RadishSettlementViewActionTypeSelectStore://切换活动门店
        {
            SettlementPickStoreViewController *controller = [[SettlementPickStoreViewController alloc]init];
            controller.serveId = self.data.radishSysNo;
            controller.channelId = self.data.chid;
            controller.storeId = self.data.store.storeId;
            controller.pickStoreBlock = ^void (SettlementPickStoreDataItem *store){
                self.data.store = store;
                [self.settlementView reloadData];
            };
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case RadishSettlementViewActionTypeSelectPlace://切换活动地址
        {
            ServiceSettlementSelectPlaceViewController *controller = [[ServiceSettlementSelectPlaceViewController alloc] initWithNibName:@"ServiceSettlementSelectPlaceViewController" bundle:nil];
            controller.currentIndex = self.data.currentPlaceIndex;
            controller.places = self.data.place;
            controller.actionBlock = ^(NSInteger selectIndex){
                self.data.currentPlaceIndex = selectIndex;
                [self.settlementView reloadData];
            };
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case RadishSettlementViewActionTypePlaceOrder://下单
        {
            [self placeOrder];
        }
            break;
    }
}

- (void)placeOrder {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    NSString *radishId = self.data.radishSysNo;
    if ([radishId isNotNull]) {
        [param setObject:radishId forKey:@"radishId"];
    }
    
    NSString *chId = self.data.chid;
    if (![chId isNotNull]) {
        chId = @"0";
    }
    [param setObject:chId forKey:@"chId"];
    
    NSInteger buyNum = self.data.buyNum;
    [param setObject:@(buyNum) forKey:@"buyNum"];
    
    PayType payType = self.data.payType;
    [param setObject:@(payType) forKey:@"paytype"];
    
    NSString *soleid = self.data.soleId;
    if ([soleid isNotNull]) {
        [param setObject:soleid forKey:@"soleid"];
    }
    
    NSString *radishCount = self.data.radishCount;
    if ([radishCount isNotNull]) {
        [param setObject:radishCount forKey:@"radishCount"];
    }
    
    NSString *price = self.data.totalPrice;
    if ([price isNotNull]) {
        [param setObject:price forKey:@"price"];
    }
    
    NSString *addressId = self.data.userAddressInfo.ID;
    if ([addressId isNotNull]) {
        [param setObject:addressId forKey:@"addressId"];
    }
    
    NSString *storeId = self.data.store.storeId;
    if ([storeId isNotNull]) {
        [param setObject:storeId forKey:@"storeId"];
    }
    
    if (self.data.placeType == PlaceTypePlace) {
        NSUInteger placeIndex = self.data.currentPlaceIndex;
        NSArray<ServiceSettlementPlace *> *place = self.data.place;
        if (placeIndex<place.count) {
            ServiceSettlementPlace *placeItem = place[placeIndex];
            NSString *placeNo = placeItem.sysNo;
            if ([placeNo isNotNull]) {
                [param setObject:placeNo forKey:@"placeNo"];
            }
        }
    }
    
    NSString *userRemark = [NSString stringWithFormat:@"%@",[USERDEFAULTS objectForKey:KRadishSettlementUserRemark]];
    if ([userRemark isNotNull]) {
        [param setObject:userRemark forKey:@"userRemark"];
    }
    
    [TCProgressHUD showSVP];
    [Request startWithName:@"RADISH_PLACE_ORDER" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        PayModel *payModel = [PayModel modelWithDictionary:dic];
        if ([payModel.data.orderNo isNotNull]) {
            [self placeOrderSucceed:payModel];
        }else{
            [self placeOrderFailure:nil];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self placeOrderFailure:error];
    }];
}

#pragma mark - 下单结果

/** 下单成功 -> 结算 */
- (void)placeOrderSucceed:(PayModel *)model {
    
    NSString *orderId = model.data.orderNo;
    
    [KTCPaymentService startPay:model.data.payInfo succeed:^{
        [self settlementPaid:YES orderId:orderId];
        [[iToast makeText:@"结算成功"] show];
    } failure:^(NSError *error) {
        [self settlementPaid:NO orderId:orderId];
        NSString *errMsg = @"结算失败";
        NSString *text = [NSString stringWithFormat:@"%@",error.userInfo[@"kErrMsgKey"]];
        if ([text isNotNull]) errMsg = text;
        [[iToast makeText:errMsg] show];
    }];
}

/** 下单失败 -> 提示 */
- (void)placeOrderFailure:(NSError *)error {
    NSString *errMsg = @"下单失败";
    NSString *text = [NSString stringWithFormat:@"%@",error.userInfo[@"data"]];
    if ([text isNotNull]) errMsg = text;
    [[iToast makeText:errMsg] show];
}

#pragma mark - 结算结果
- (void)settlementPaid:(BOOL)paid orderId:(NSString *)orderId{
    SettlementResultNewViewController *controller = [[SettlementResultNewViewController alloc]initWithNibName:@"SettlementResultNewViewController" bundle:nil];
    controller.paid = paid;
    controller.orderId = orderId;
    controller.productType = ProductDetailTypeRadish;
    NavigationController *navi = [[NavigationController alloc]initWithRootViewController:controller];
    [self presentViewController:navi animated:YES completion:^{
        [self.navigationController popToRootViewControllerAnimated:NO];
    }];
}

- (void)keyboardWillShow:(NSNotification *)noti {
    [super keyboardWillShow:noti];
    self.settlementView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - self.keyboardHeight);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.settlementView scrollToUserRemark];
    });
}

- (void)keyboardWillDisappear:(NSNotification *)noti {
    self.settlementView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
}

@end
