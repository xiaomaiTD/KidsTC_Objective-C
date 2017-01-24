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
#import "NSString+ZP.h"

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
#import "SettlementResultNewViewController.h"
#import "NavigationController.h"
#import "ServiceSettlementSelectPlaceViewController.h"


#import "KTCPaymentService.h"
#import "PayModel.h"

@interface ServiceSettlementViewController ()<UITableViewDelegate,UITableViewDataSource,ServiceSettlementBaseCellDelegate,ServiceSettlementToolBarDelegate>
@property (nonatomic,   weak) UITableView *tableView;
@property (nonatomic,   weak) ServiceSettlementToolBar *tooBar;
@property (nonatomic, strong) NSArray<NSArray<ServiceSettlementBaseCell *> *> *sections;
@property (nonatomic, assign) NSUInteger scoreNum;
@property (nonatomic, strong) NSString *couponCode;
@property (nonatomic, assign) BOOL isCancelCoupon;//是否取消使用优惠券(如果取消[有满减则会使用满减])，默认为NO，不取消
@property (nonatomic, strong) ServiceSettlementModel *model;
@property (nonatomic, strong) NSString *buyNum;

@property (nonatomic, assign) PayType payType;

@property (nonatomic, strong) ServiceSettlementSubViewsProvider *subViewsProvider;
@property (nonatomic, strong) ServiceSettlementDataManager *dataManager;

@end

@implementation ServiceSettlementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    switch (_type) {
        case ProductDetailTypeNormal:
        case ProductDetailTypeTicket:
        case ProductDetailTypeFree:
            break;
        default:
        {
            _type = ProductDetailTypeNormal;
        }
            break;
    }
    
    _subViewsProvider = [ServiceSettlementSubViewsProvider new];
    _subViewsProvider.type = _type;
    
    _dataManager = [ServiceSettlementDataManager new];
    _dataManager.type = _type;
    
    
    switch (_type) {
        case ProductDetailTypeNormal:
        {
            self.pageId = 10501;
        }
            break;
        case ProductDetailTypeTicket:
        {
            self.pageId = 10507;
        }
            break;
        default:
            break;
    }
    
    self.navigationItem.title = @"结算";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.naviTheme = NaviThemeWihte;
    
    [self setupTableView];
    
    [self setupToolBar];
    
    [self loadShoppingCart];
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - kServiceSettlementToolBarH) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tableView.estimatedRowHeight = 44.0f;
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
}

- (void)setupToolBar {
    _tooBar = _subViewsProvider.tooBar;
    _tooBar.frame = CGRectMake(0, SCREEN_HEIGHT-kServiceSettlementToolBarH, SCREEN_WIDTH, kServiceSettlementToolBarH);
    _tooBar.delegate = self;
    _tooBar.hidden = YES;
    [self.view addSubview:_tooBar];
}

- (id)viewWithNib:(NSString *)nib{
    return [[NSBundle mainBundle] loadNibNamed:nib owner:self options:nil].firstObject;
}

#pragma mark - 从购物车获取商品结算信息

- (NSDictionary *)loadShoppingCartParam {

    switch (_type) {
        case ProductDetailTypeNormal:
        {
            ServiceSettlementDataItem *item = self.model.data;
            NSString *couponCode = self.couponCode.length>0?self.couponCode:@"";
            NSString *buyNum = [self.buyNum isNotNull]?self.buyNum:@"";
            NSString *storeNo = [item.store.storeId isNotNull]?item.store.storeId:@"";
            NSString *placeNo = @"";
            if (item.placeType == PlaceTypePlace) {
                if (item.place.count>item.currentPlaceIndex) {
                    ServiceSettlementPlace *place = item.place[item.currentPlaceIndex];
                    if ([place.sysNo isNotNull]) {
                        placeNo = place.sysNo;
                    }
                }
            }
            NSDictionary *param = @{@"couponCode":couponCode,
                                    @"scoreNum":@(self.scoreNum),
                                    @"isCancelCoupon":@(self.isCancelCoupon),
                                    @"buyNum":buyNum,
                                    @"storeNo":storeNo,
                                    @"placeNo":placeNo};
            return param;
        }
            break;
        case ProductDetailTypeTicket:
        {
            ServiceSettlementDataItem *item = self.model.data;
            NSString *couponCode = self.couponCode.length>0?self.couponCode:@"";
            NSDictionary *param = @{@"couponCode":couponCode,
                                    @"scoreNum":@(self.scoreNum),
                                    @"isCancelCoupon":@(self.isCancelCoupon),
                                    @"takeTicketWay":@(item.takeTicketWay)};
            return param;
        }
            break;
        case ProductDetailTypeFree:
        {
            return nil;
        }
            break;
            default:
            break;
    }
    return nil;
}

- (void)loadShoppingCart{
    NSDictionary *param = self.loadShoppingCartParam;
    if (!param) {
        [[iToast makeText:@"参数错误"] show];
        [self back];
        return;
    }
    
    [TCProgressHUD showSVP];
    [_dataManager loadDataWithParam:param successBlock:^(ServiceSettlementModel *model) {
        [TCProgressHUD dismissSVP];
        [self loadShoppingCartSuccess:model];
    } failureBlock:^(NSError *error) {
        [TCProgressHUD dismissSVP];
        [self loadShoppingCartFailure:error];
    }];
}

- (void)loadShoppingCartSuccess:(ServiceSettlementModel *)model {
    ServiceSettlementDataItem *item = model.data;
    item.type = _type;
    _subViewsProvider.model = model;
    _sections = _subViewsProvider.sections;
    _model = model;
    _tooBar.item = item;
    [_tableView reloadData];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *pid = self.model.data.serveId;
    if ([pid isNotNull]) {
        [params setValue:pid forKey:@"pid"];
    }
    NSString *cid = self.model.data.channelId;
    if ([cid isNotNull]) {
        [params setValue:cid forKey:@"cid"];
    }
    self.trackParams = [NSDictionary dictionaryWithDictionary:params];
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
    return (section==0)?10:0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ServiceSettlementBaseCell *cell = self.sections[indexPath.section][indexPath.row];
    cell.indexPath = indexPath;
    cell.delegate = self;
    cell.item = self.model.data;
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
                self.model.data.userAddress = item;
                [self.tableView reloadData];
            };
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case ServiceSettlementBaseCellActionTypeStore:
        {
            ServiceSettlementDataItem *item = self.model.data;
            SettlementPickStoreViewController *controller = [[SettlementPickStoreViewController alloc]init];
            controller.serveId = item.serveId;
            controller.channelId = item.channelId;
            controller.storeId = item.store.storeId;
            controller.pickStoreBlock = ^void (SettlementPickStoreDataItem *store){
                self.model.data.store = store;
                [self.tableView reloadData];
            };
            [self.navigationController pushViewController:controller animated:YES];
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            NSString *pid = self.model.data.serveId;
            if ([pid isNotNull]) {
                [params setValue:pid forKey:@"pid"];
            }
            [BuryPointManager trackEvent:@"event_skip_balance_store" actionId:20701 params:params];
        }
            break;
        case ServiceSettlementBaseCellActionTypePlace:
        {
            ServiceSettlementSelectPlaceViewController *controller = [[ServiceSettlementSelectPlaceViewController alloc] initWithNibName:@"ServiceSettlementSelectPlaceViewController" bundle:nil];
            controller.currentIndex = self.model.data.currentPlaceIndex;
            controller.places = self.model.data.place;
            controller.actionBlock = ^(NSInteger selectIndex){
                self.model.data.currentPlaceIndex = selectIndex;
                [self.tableView reloadData];
            };
            [self.navigationController pushViewController:controller animated:YES];
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
            NSString *pid = self.model.data.serveId;
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
            controller.scoreNum = self.model.data.scorenum;
            controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            controller.modalPresentationStyle = UIModalPresentationCustom;
            [self presentViewController:controller animated:NO completion:nil];
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            if ([self.couponCode isNotNull]) {
                [params setValue:@(self.scoreNum) forKey:@"num"];
            }
            NSString *pid = self.model.data.serveId;
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
            [self loadShoppingCart];
        }
            break;
    }
}


#pragma mark - ServiceSettlementToolBarDelegate

- (void)serviceSettlementToolBar:(ServiceSettlementToolBar *)toolBar actionType:(ServiceSettlementToolBarActionType)type value:(id)value {
    
    switch (type) {
        case ServiceSettlementToolBarActionTypeCommit:
        {
            [self placeOrder:value];
        }
            break;
        default:
            break;
    }
}

#pragma mark - 下单

- (NSDictionary *)placeOrderParam {
    switch (_type) {
        case ProductDetailTypeNormal:
        {
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            
            ServiceSettlementDataItem *item = self.model.data;
            
            //支付方式
            PayType payType = _payType;
            [param setObject:@(payType) forKey:@"paytype"];
            
            //密等id
            NSString *soleid = self.model.soleid;
            if (![soleid isNotNull]) {
                soleid = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]];
            }
            [param setObject:soleid forKey:@"soleid"];
            
            //优惠券
            ServiceSettlementCouponItem *maxCoupon = item.maxCoupon;
            NSString *couponCode = maxCoupon.code.length>0?maxCoupon.code:@"";
            [param setObject:couponCode forKey:@"couponCode"];
            
            //是否使用满减（1：是，0：否）
            BOOL isFullCut = (couponCode.length<=0 && item.promotion.fiftyamt>0);
            [param setObject:@(isFullCut) forKey:@"isFullCut"];
            
            //积分
            NSUInteger point = item.usescorenum;
            [param setObject:@(point) forKey:@"point"];
            
            //付款总额（这里用来和后台进行校验）
            NSString *price = item.totalPrice;
            if (![price isNotNull]) {
                [[iToast makeText:@"支付金额为空，请稍后再试！"] show];
                return nil;
            }
            [param setObject:price forKey:@"price"];
            
            //地址id
            if (item.hasUserAddress) {//地址为必填
                
                NSString *addressId = item.userAddress.ID;
                
                if (!item.userAddress) {
                    [[iToast makeText:@"请新增收货地址"] show];
                    return nil;
                }
                if (![addressId isNotNull]) {
                    [[iToast makeText:@"收货地址编号为空"] show];
                    return nil;
                }
                [param setObject:addressId forKey:@"addressId"];
            }
            
            /**门店id*/
            NSString *storeId = item.store.storeId;
            if (![storeId isNotNull]) {
                storeId = @"";
            }
            [param setObject:storeId forKey:@"storeId"];
            
            //placeNo
            if (item.placeType == PlaceTypePlace) {
                if (item.place.count>item.currentPlaceIndex) {
                    ServiceSettlementPlace *place = item.place[item.currentPlaceIndex];
                    NSString *placeNo = place.sysNo;
                    if ([placeNo isNotNull]) {
                        [param setObject:placeNo forKey:@"placeNo"];
                    }
                }
            }
            
            NSString *userRemark = [NSString stringWithFormat:@"%@",[USERDEFAULTS objectForKey:KServiceSettlementUserRemark]];
            if ([userRemark isNotNull]) {
                [param setObject:userRemark forKey:@"userRemark"];
            }
            

            return param;
        }
            break;
        case ProductDetailTypeTicket:
        {
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            
            ServiceSettlementDataItem *item = self.model.data;
            
            //票务详情编号
            NSString *productId = item.serveId;
            if (![productId isNotNull]) {
                [[iToast makeText:@"商品编号为空，请稍后再试！"] show];
                return nil;
            }
            [param setObject:productId forKey:@"productId"];
            
            //多价编号
            NSString *chId = item.channelId;
            if (![productId isNotNull]) {
                chId = @"0";
            }
            [param setObject:chId forKey:@"chId"];
            
            //支付方式
            PayType payType = _payType;
            [param setObject:@(payType) forKey:@"paytype"];
            
            //密等id
            NSString *soleid = self.model.soleid;
            if (![soleid isNotNull]) {
                soleid = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]];
            }
            [param setObject:soleid forKey:@"soleid"];
            
            //优惠券
            ServiceSettlementCouponItem *maxCoupon = item.maxCoupon;
            NSString *couponCode = maxCoupon.code.length>0?maxCoupon.code:@"";
            [param setObject:couponCode forKey:@"couponCode"];
            
            //积分
            NSUInteger point = item.usescorenum;
            [param setObject:@(point) forKey:@"point"];
            
            //付款总额（这里用来和后台进行校验）
            NSString *price = item.payPrice;
            if (![price isNotNull]) {
                [[iToast makeText:@"支付金额为空，请稍后再试！"] show];
                return nil;
            }
            [param setObject:price forKey:@"price"];
            
            //选座信息 json字符串
            NSArray<ServiceSettlementSeat *> *seats = self.model.data.seats;
            if (seats.count<1) {
                [[iToast makeText:@"座位信息为空，请稍后再试！"] show];
                return nil;
            }
            
            NSMutableArray *skuAry = [NSMutableArray array];
            [seats enumerateObjectsUsingBlock:^(ServiceSettlementSeat * seat, NSUInteger idx, BOOL *stop) {
                if (!seat) {
                    [[iToast makeText:@"座位信息不合法，请稍后再试！"] show];
                    return;
                }
                NSString *SkuId = seat.skuId;
                if (![SkuId isNotNull]) {
                    [[iToast makeText:@"座位信息编号不合法，请稍后再试！"] show];
                    return;
                }
                NSString *ChId = seat.chid;
                if (![ChId isNotNull]) {
                    [[iToast makeText:@"座位信息渠道id不合法，请稍后再试！"] show];
                    return;
                }
                NSDictionary *skuDic = @{@"SkuId":SkuId,
                                         @"ChId":ChId,
                                         @"BuyNum":@(seat.num)};
                if (skuDic) {
                    [skuAry appendObject:skuDic];
                }
            }];
            if (skuAry.count < 1) {
                [[iToast makeText:@"所有的座位信息为空，请稍后再试！"] show];
                return nil;
            }

            NSString *skus = [NSString zp_stringWithJsonObj:skuAry];
            
            if (![skus isNotNull]) {
                [[iToast makeText:@"App内部出错，请重试"] show];
                return nil;
            }
            [param setObject:skus forKey:@"skus"];
            
            
            //取票方式，1=快递 2=上门自取
            ServiceSettlementTakeTicketWay takeTicketWay = item.takeTicketWay;
            switch (takeTicketWay) {
                case ServiceSettlementTakeTicketWayCar:
                {
                    //地址id
                    NSString *addressId = item.userAddress.ID;
                    
                    if (!item.userAddress) {
                        [[iToast makeText:@"请新增收货地址"] show];
                        return nil;
                    }
                    if (![addressId isNotNull]) {
                        [[iToast makeText:@"收货地址编号为空"] show];
                        return nil;
                    }
                    [param setObject:addressId forKey:@"addressId"];
                }
                    break;
                case ServiceSettlementTakeTicketWaySelf:
                {
                    //上门自取用户信息，json字符串
                    /*
                    NSString *UserName = item.ticketUserName;
                    if (![UserName isNotNull]) {
                        [[iToast makeText:@"请填写取票人姓名"] show];
                        return nil;
                    }*/
                    
                    NSString *UserMobile = item.defaultSiteTicket.mobile;
                    if (![UserMobile isNotNull]) {
                        [[iToast makeText:@"请填写取票人电话"] show];
                        return nil;
                    }
                    
                    NSDictionary *ticketUserDic = @{@"UserMobile":UserMobile};
                    NSString *ticketUser = [NSString zp_stringWithJsonObj:ticketUserDic];
                    if (![ticketUser isNotNull]) {
                        [[iToast makeText:@"App内部出错，请重试"] show];
                        return nil;
                    }
                    [param setObject:ticketUser forKey:@"ticketUser"];
                }
                    break;
                default:
                {
                    [[iToast makeText:@"非法的取票方式"] show];
                    return nil;
                }
                    break;
            }
            [param setObject:@(takeTicketWay) forKey:@"takeTicketWay"];
            
            NSString *userRemark = [NSString stringWithFormat:@"%@",[USERDEFAULTS objectForKey:KServiceSettlementUserRemark]];
            if ([userRemark isNotNull]) {
                [param setObject:userRemark forKey:@"userRemark"];
            }
            
            return [NSDictionary dictionaryWithDictionary:param];
        }
            break;
        default:
            break;
    }
    return nil;
}

- (void)placeOrder:(id)value{
    
    NSDictionary *param = self.placeOrderParam;
    if (!param) return;
    [TCProgressHUD showSVP];
    [_dataManager placeOrderWithParam:param successBlock:^(PayModel *model) {
        [TCProgressHUD dismissSVP];
        [self placeOrderSucceed:model];
    } failureBlock:^(NSError *error) {
        [TCProgressHUD dismissSVP];
        [self placeOrderFailure:error];
    }];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *pid = self.model.data.serveId;
    if ([pid isNotNull]) {
        [params setValue:pid forKey:@"pid"];
    }
    [BuryPointManager trackEvent:@"event_click_balance_pay" actionId:20704 params:params];
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
- (void)settlementPaid:(BOOL)paid orderId:(NSString *)orderId{
    SettlementResultNewViewController *controller = [[SettlementResultNewViewController alloc]initWithNibName:@"SettlementResultNewViewController" bundle:nil];
    controller.paid = paid;
    controller.orderId = orderId;
    controller.productType = self.type;
    NavigationController *navi = [[NavigationController alloc]initWithRootViewController:controller];
    [self presentViewController:navi animated:YES completion:^{
        [self.navigationController popToRootViewControllerAnimated:NO];
        self.tableView.delegate = nil;
        self.tableView.dataSource = nil;
    }];
}

- (void)keyboardWillShow:(NSNotification *)noti {
    [super keyboardWillShow:noti];
    self.tableView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - self.keyboardHeight);
}

- (void)keyboardWillDisappear:(NSNotification *)noti {
    self.tableView.frame = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - kServiceSettlementToolBarH);
}

- (void)dealloc {
    [_subViewsProvider nilSubViews];
    [USERDEFAULTS setObject:@"" forKey:KServiceSettlementUserRemark];
    [USERDEFAULTS synchronize];
}

@end
