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
#import "WholesalePickDateViewController.h"

@interface WholesaleSettlementViewController ()<WholesaleSettlementViewDelegate,WholesalePickDateViewControllerDelegate>
@property (nonatomic, strong) WholesaleSettlementView *settlementView;
@property (nonatomic, strong) WholesaleSettlementData *data;
@end

@implementation WholesaleSettlementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    [TCProgressHUD showSVP];
    [Request startWithName:@"GET_FIGHT_GROUP_ORDER_CONFIRM_V2" param:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
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
        case WholesaleSettlementViewActionTypeSelectDate://选择时间
        {
            [self selectDate];
        }
            break;
        case WholesaleSettlementViewActionTypePlaceOrder://下单
        {
            [self placeOrder];
        }
            break;
    }
}

#pragma mark 切换地址

- (void)selectPlace {
    WholesalePickDateViewController *controller = [[WholesalePickDateViewController alloc] initWithNibName:@"WholesalePickDateViewController" bundle:nil];
    controller.delegate = self;
    controller.sku = self.data.sku;
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    controller.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)wholesalePickDateViewController:(WholesalePickDateViewController *)controller actionType:(WholesalePickDateViewControllerActionType)type value:(id)value {
    switch (type) {
        case WholesalePickDateViewControllerActionTypeMakeSure:
        {
            [self.settlementView reloadData];
            [controller dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        default:
            break;
    }
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

#pragma mark 选择时间

- (void)selectDate {
    [self selectPlace];
}

#pragma mark 下单

- (void)placeOrder {
    WholesaleSettlementData *data = self.data;
    
    if (![data.fightGroupSysNo isNotNull]) {
        [[iToast makeText:@"商品编号为空"] show];
        return;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:data.fightGroupSysNo forKey:@"fightGroupId"];
    if ([data.openGroupSysNo isNotNull]) {
        [param setObject:data.openGroupSysNo forKey:@"openGroupId"];
    }
    
    //time
    NSArray<WholesalePickDateTime *> *times = self.data.sku.times;
    __block WholesalePickDateTime *time = nil;
    if (times.count>0) {
        [times enumerateObjectsUsingBlock:^(WholesalePickDateTime *obj, NSUInteger idx, BOOL *stop) {
            if (obj.select) {
                time = obj;
                *stop = YES;
            }
        }];
        if(!time) time = times.firstObject;
    }
    if (time) {
        NSString *skuId = time.skuId;
        if ([skuId isNotNull]) {
            [param setObject:skuId forKey:@"skuId"];
        }
        NSString *timeId = time.timeNo;
        if ([timeId isNotNull]) {
            [param setObject:timeId forKey:@"timeNo"];
        }
    }
    //place
    NSArray<WholesalePickDatePlace *> *places = self.data.sku.places;
    __block WholesalePickDatePlace *place = nil;
    if (places.count>0) {
        [places enumerateObjectsUsingBlock:^(WholesalePickDatePlace *obj, NSUInteger idx, BOOL *stop) {
            if (obj.select) {
                place = obj;
                *stop = YES;
            }
        }];
        if(!place) place = places.firstObject;
    }
    if (place) {
        NSString * placeID = place.ID;
        if ([placeID isNotNull]) {
            switch (self.data.placeType) {
                case PlaceTypeStore:
                {
                    [param setObject:placeID forKey:@"storeNo"];
                }
                    break;
                case PlaceTypePlace:
                {
                    [param setObject:placeID forKey:@"placeNo"];
                }
                    break;
                default:
                    break;
            }
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
    if ([data.fightGroupSysNo isNotNull]) {
        [params setObject:data.fightGroupSysNo forKey:@"pid"];
    }
    if ([data.openGroupSysNo isNotNull]) {
        [params setObject:data.openGroupSysNo forKey:@"gid"];
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
        NSString *text = [NSString stringWithFormat:@"%@",error.userInfo[@"data"]];
        if ([text isNotNull]) errMsg = text;
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
    controller.productId = self.data.fightGroupSysNo;
    controller.openGroupId = model.data.openGroupId;
    NavigationController *navi = [[NavigationController alloc]initWithRootViewController:controller];
    [self presentViewController:navi animated:YES completion:^{
        [self.navigationController popToRootViewControllerAnimated:NO];
    }];
}
@end
