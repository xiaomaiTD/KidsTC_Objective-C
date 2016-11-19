//
//  ServiceSettlementViewController.m
//  KidsTC
//
//  Created by zhanping on 8/11/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ServiceSettlementViewController.h"
#import "NSString+Category.h"
#import "BuryPointManager.h"
#import "UIBarButtonItem+Category.h"

#import "ServiceSettlementSubViewsProvider.h"
#import "ServiceSettlementDataManager.h"

#import "ServiceSettlementToolBar.h"

#import "GHeader.h"
#import "ServiceSettlementModel.h"

#import "UserAddressEditViewController.h"
#import "UserAddressManageViewController.h"
#import "SettlementPickScoreViewController.h"
#import "SettlementPickStoreViewController.h"
#import "ServiceSettlementPickCouponViewController.h"
#import "SettlementResultViewController.h"
#import "NavigationController.h"

#import "KTCPaymentService.h"
#import "PayModel.h"

@interface ServiceSettlementViewController ()<UITableViewDelegate,UITableViewDataSource,ServiceSettlementBaseCellDelegate>
@property (nonatomic,   weak) UITableView                           *tableView;
@property (nonatomic,   weak) ServiceSettlementToolBar              *tooBar;
@property (nonatomic, strong) NSArray<NSArray<ServiceSettlementBaseCell *> *> *sections;
@property (nonatomic, assign) NSUInteger scoreNum;
@property (nonatomic, strong) NSString *couponCode;
@property (nonatomic, assign) BOOL isCancelCoupon;//是否取消使用优惠券(如果取消[有满减则会使用满减])，默认为NO，不取消
@property (nonatomic, strong) ServiceSettlementModel *model;
@property (nonatomic, strong) NSString *buyNum;

@property (nonatomic, assign) PayType payType;

@property (nonatomic, assign) ServiceSettlementSubViewsProvider *provider;
@property (nonatomic, strong) ServiceSettlementDataManager *dataManager;

@end

@implementation ServiceSettlementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _provider = [ServiceSettlementSubViewsProvider shareServiceSettlementSubViewsProvider];
    _provider.type = _type;
    
    _dataManager = [ServiceSettlementDataManager shareServiceSettlementDataManager];
    _dataManager.type = _type;
    
    self.pageId = 10501;
    
    self.navigationItem.title = @"结算";
    
    self.naviTheme = NaviThemeWihte;
    
    [self setupTableView];
    
    [self setupToolBar];
    
    [self loadShoppingCart];
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.contentInset = UIEdgeInsetsMake(0, 0, kServiceSettlementToolBarH, 0);
    tableView.scrollIndicatorInsets = tableView.contentInset;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tableView.estimatedRowHeight = 44.0f;
    tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (void)setupToolBar {
    _tooBar = _provider.tooBar;
    _tooBar.frame = CGRectMake(0, SCREEN_HEIGHT-kServiceSettlementToolBarH, SCREEN_WIDTH, kServiceSettlementToolBarH);
    [self.view addSubview:_tooBar];
    _tooBar.hidden = YES;
    _tooBar.commitBlock = ^void () {
        [self commit];
    };
}

#pragma mark - 从购物车获取商品结算信息

- (NSDictionary *)param {

    switch (_type) {
        case ProductDetailTypeNormal:
        {
            ServiceSettlementDataItem *item = self.model.data.firstObject;
            NSString *couponCode = self.couponCode.length>0?self.couponCode:@"";
            NSString *buyNum = [self.buyNum isNotNull]?self.buyNum:@"";
            NSString *storeNo = [item.store.storeId isNotNull]?item.store.storeId:@"";
            NSDictionary *param = @{@"couponCode":couponCode,
                                    @"scoreNum":@(self.scoreNum),
                                    @"isCancelCoupon":@(self.isCancelCoupon),
                                    @"buyNum":buyNum,
                                    @"storeNo":storeNo};
            return param;
        }
            break;
        case ProductDetailTypeTicket:
        {
            ServiceSettlementDataItem *item = self.model.data.firstObject;
            NSString *couponCode = self.couponCode.length>0?self.couponCode:@"";
            NSDictionary *param = @{@"couponCode":couponCode,
                                    @"scoreNum":@(self.scoreNum),
                                    @"isCancelCoupon":@(self.isCancelCoupon),
                                    @"takeTicketWay":@(item.ticketGetType)};
            return param;
        }
            break;
        case ProductDetailTypeFree:
        {
            return nil;
        }
            break;
    }
}

- (void)loadShoppingCart{
    [TCProgressHUD showSVP];
    [_dataManager loadDataWithParam:self.param successBlock:^(ServiceSettlementModel *model) {
        [TCProgressHUD dismissSVP];
        [self loadShoppingCartSuccess:model];
    } failureBlock:^(NSError *error) {
        [TCProgressHUD dismissSVP];
        [self loadShoppingCartFailure:error];
    }];
}

- (void)loadShoppingCartSuccess:(ServiceSettlementModel *)model {
    if (model.data.count>0) {
        ServiceSettlementDataItem *item = model.data.firstObject;
        if (item) {
            _provider.model = model;
            _sections = _provider.sections;
            self.model = model;
            self.tooBar.item = item;
            [self.tableView reloadData];
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            NSString *pid = self.model.data.firstObject.serveId;
            if ([pid isNotNull]) {
                [params setValue:pid forKey:@"pid"];
            }
            NSString *cid = self.model.data.firstObject.channelId;
            if ([cid isNotNull]) {
                [params setValue:cid forKey:@"cid"];
            }
        }
    }
}

- (void)loadShoppingCartFailure:(NSError *)error {
    [[iToast makeText:@"获取购物车信息失败，请稍后重试！"] show];
    [self back];
}

#pragma mark UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sections[section].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return (section==0)?8:0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ServiceSettlementBaseCell *cell = self.sections[indexPath.section][indexPath.row];
    cell.item = self.model.data.firstObject;
    cell.indexPath = indexPath;
    return cell;
}

#pragma mark ServiceSettlementBaseCellDelegate

- (void)serviceSettlementBaseCell:(ServiceSettlementBaseCell *)cell actionType:(ServiceSettlementBaseCellActionType)type value:(id)value{
    
    switch (type) {
        case ServiceSettlementBaseCellActionTypeTipAddress:
        {
            UserAddressEditViewController *controller = [[UserAddressEditViewController alloc]init];
            controller.editType = UserAddressEditTypeAdd;
            controller.resultBlock = ^void(UserAddressManageDataItem *item){
                [self loadShoppingCart];
            };
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
            
        case ServiceSettlementBaseCellActionTypeAddress:
        {
            UserAddressManageViewController *controller = [[UserAddressManageViewController alloc]init];
            controller.fromeType = UserAddressManageFromTypeSettlement;
            controller.pickeAddressBlock = ^void (UserAddressManageDataItem *item){
                self.model.data.firstObject.userAddress = item;
                [self.tableView reloadData];
            };
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case ServiceSettlementBaseCellActionTypeStore:
        {
            ServiceSettlementDataItem *item = self.model.data.firstObject;
            SettlementPickStoreViewController *controller = [[SettlementPickStoreViewController alloc]init];
            controller.serveId = item.serveId;
            controller.channelId = item.channelId;
            controller.storeId = item.store.storeId;
            controller.pickStoreBlock = ^void (SettlementPickStoreDataItem *store){
                self.model.data.firstObject.store = store;
                [self.tableView reloadData];
            };
            [self.navigationController pushViewController:controller animated:YES];
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            NSString *pid = self.model.data.firstObject.serveId;
            if ([pid isNotNull]) {
                [params setValue:pid forKey:@"pid"];
            }
            [BuryPointManager trackEvent:@"event_skip_balance_store" actionId:20701 params:params];
        }
            break;
        case ServiceSettlementBaseCellActionTypeCoupon:
        {
            ServiceSettlementPickCouponViewController *controller = [[ServiceSettlementPickCouponViewController alloc]init];
            controller.settlementModel = self.model;
            controller.pickCouponBlock = ^void (ServiceSettlementCouponItem *coupon){
                self.couponCode = coupon?coupon.code:@"";
                self.isCancelCoupon = coupon?NO:YES;
                [self loadShoppingCart];
            };
            [self.navigationController pushViewController:controller animated:YES];
            
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            if ([self.couponCode isNotNull]) {
                [params setValue:self.couponCode forKey:@"couponId"];
            }
            NSString *pid = self.model.data.firstObject.serveId;
            if ([pid isNotNull]) {
                [params setValue:pid forKey:@"pid"];
            }
            [BuryPointManager trackEvent:@"event_result_balance_coupon" actionId:20702 params:params];
        }
            break;
        case ServiceSettlementBaseCellActionTypeScore:
        {
            SettlementPickScoreViewController *controller = [[SettlementPickScoreViewController alloc]initWithNibName:@"SettlementPickScoreViewController" bundle:nil];
            controller.resultBlock = ^void (NSUInteger scoreNum) {
                self.scoreNum = scoreNum;
                [self loadShoppingCart];
            };
            controller.scoreNum = self.model.data.firstObject.scorenum;
            controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            controller.modalPresentationStyle = UIModalPresentationCustom;
            [self presentViewController:controller animated:NO completion:nil];
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            if ([self.couponCode isNotNull]) {
                [params setValue:@(self.scoreNum) forKey:@"num"];
            }
            NSString *pid = self.model.data.firstObject.serveId;
            if ([pid isNotNull]) {
                [params setValue:pid forKey:@"pid"];
            }
            [BuryPointManager trackEvent:@"event_result_balance_score" actionId:20703 params:params];
        }
            break;
        case ServiceSettlementBaseCellActionTypeChangePayType:
        {
            self.payType = (PayType)[value integerValue];
        }
            break;
        case ServiceSettlementBaseCellActionTypeBuyNumDidChange:
        {
            self.buyNum = value;
            [self loadShoppingCart];
        }
            break;
        case ServiceSettlementBaseCellActionTypeTicketGetTypeDidChange:
        {
            _sections = _provider.sections;
            [self.tableView reloadData];
        }
            break;
    }
}

#pragma mark - 下单

- (void)commit{
    
    if (![self checkValite]) return;
    
    ServiceSettlementDataItem *item = self.model.data.firstObject;
    ServiceSettlementCouponItem *maxCoupon = item.maxCoupon;
    NSString *couponCode = maxCoupon.code.length>0?maxCoupon.code:@"";
    BOOL isFullCut = (couponCode.length<=0 && item.promotion.fiftyamt>0);
    NSString *soleid = [self.model.soleid isNotNull]?self.model.soleid:@"";
    NSString *addressId = [item.userAddress.ID isNotNull]?item.userAddress.ID:@"";
    NSString *storeId = [item.store.storeId isNotNull]?item.store.storeId:@"";
    NSString *priceStr = [NSString priceStr:item.totalPrice];
    NSDictionary *param = @{@"paytype"   : @(self.payType),     //支付方式
                            @"soleid"    : soleid,              //密等id
                            @"couponCode": couponCode,          //优惠券
                            @"point"     : @(item.usescorenum), //积分
                            @"isFullCut" : @(isFullCut),        //是否使用满减（1：是，0：否）
                            @"price"     : priceStr,            //付款总额（这里用来和后台进行校验）
                            @"addressId" : addressId,           //地址id
                            @"storeId"   : storeId              /**门店id*/};
    [TCProgressHUD showSVP];
    [Request startWithName:@"ORDER_PLACE_ORDER_V2" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        PayModel *model = [PayModel modelWithDictionary:dic];
        if (model.data.orderNo>0) {
            [self placeOrderSucceed:model];
        }else{
            [self placeOrderFailure:nil];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self placeOrderFailure:error];
    }];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *pid = self.model.data.firstObject.serveId;
    if ([pid isNotNull]) {
        [params setValue:pid forKey:@"pid"];
    }
    [BuryPointManager trackEvent:@"event_click_balance_pay" actionId:20704 params:params];
}

- (BOOL)checkValite{
    ServiceSettlementDataItem *item = self.model.data.firstObject;
    if (item.hasUserAddress) {
        if (item.userAddress.ID.length>0) {
            return YES;
        }else{
            [[iToast makeText:@"请填写收货地址"] show];
            return NO;
        }
    };
    return YES;
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
        NSString *text = [[error userInfo] objectForKey:kErrMsgKey];
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
- (void)settlementPaid:(BOOL)paid orderId:(NSString *)orderId{
    SettlementResultViewController *controller = [[SettlementResultViewController alloc]initWithNibName:@"SettlementResultViewController" bundle:nil];
    controller.paid = paid;
    controller.orderId = orderId;
    controller.type = SettlementResultTypeService;
    NavigationController *navi = [[NavigationController alloc]initWithRootViewController:controller];
    [self presentViewController:navi animated:YES completion:^{
        [self.navigationController popViewControllerAnimated:NO];
        self.tableView.delegate = nil;
        self.tableView.dataSource = nil;
    }];
}


- (void)dealloc {
    [_provider nilCells];
}

@end
