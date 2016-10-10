//
//  ServiceSettlementViewController.m
//  KidsTC
//
//  Created by zhanping on 8/11/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ServiceSettlementViewController.h"

#import "ServiceSettlementBaseCell.h"
#import "ServiceSettlementTipAddressCell.h"
#import "ServiceSettlementAddressCell.h"
#import "ServiceSettlementServiceInfoCell.h"
#import "ServiceSettlementStoreInfoCell.h"
#import "ServiceSettlementCouponCell.h"
#import "ServiceSettlementPayTypeCell.h"
#import "ServiceSettlementPayInfoCell.h"

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

#import "NSString+Category.h"

#define TOOLBAR_HEIGHT 60

@interface ServiceSettlementViewController ()<UITableViewDelegate,UITableViewDataSource,ServiceSettlementBaseCellDelegate>
@property (nonatomic,   weak) UITableView                      *tableView;
@property (nonatomic,   weak) ServiceSettlementToolBar         *tooBar;
@property (nonatomic, strong) ServiceSettlementTipAddressCell  *tipAddressCell;
@property (nonatomic, strong) ServiceSettlementAddressCell     *addressCell;
@property (nonatomic, strong) ServiceSettlementServiceInfoCell *serViceInfoCell;
@property (nonatomic, strong) ServiceSettlementStoreInfoCell   *storeInfoCell;
@property (nonatomic, strong) ServiceSettlementCouponCell      *couponCell;
@property (nonatomic, strong) ServiceSettlementPayTypeCell     *payTypeCell;
@property (nonatomic, strong) NSMutableArray<NSMutableArray<ServiceSettlementBaseCell *> *> *sections;

@property (nonatomic, assign) NSUInteger scoreNum;
@property (nonatomic, strong) NSString *couponCode;
@property (nonatomic, assign) BOOL isCancelCoupon;//是否取消使用优惠券(如果取消[有满减则会使用满减])，默认为NO，不取消
@property (nonatomic, strong) ServiceSettlementModel *model;


@property (nonatomic, assign) PayType payType;

@end

@implementation ServiceSettlementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"结算";
    self.pageId = @"pv_orderpalce";
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.contentInset = UIEdgeInsetsMake(0, 0, TOOLBAR_HEIGHT, 0);
    tableView.scrollIndicatorInsets = tableView.contentInset;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tableView.estimatedRowHeight = 44.0f;
    tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    ServiceSettlementToolBar *tooBar = [self viewWithNib:@"ServiceSettlementToolBar"];
    tooBar.frame = CGRectMake(0, SCREEN_HEIGHT-TOOLBAR_HEIGHT, SCREEN_WIDTH, TOOLBAR_HEIGHT);
    [self.view addSubview:tooBar];
    self.tooBar = tooBar;
    tooBar.commitBlock = ^void () {
        [self commit];
    };
    [self prepareCells];
    
    [self loadShoppingCart];
}

- (void)prepareCells{
    _tipAddressCell           = [self viewWithNib:@"ServiceSettlementTipAddressCell"];
    _tipAddressCell.delegate  = self;
    _addressCell              = [self viewWithNib:@"ServiceSettlementAddressCell"];
    _addressCell.delegate     = self;
    _serViceInfoCell          = [self viewWithNib:@"ServiceSettlementServiceInfoCell"];
    _serViceInfoCell.delegate = self;
    _storeInfoCell            = [self viewWithNib:@"ServiceSettlementStoreInfoCell"];
    _storeInfoCell.delegate   = self;
    _couponCell               = [self viewWithNib:@"ServiceSettlementCouponCell"];
    _couponCell.delegate      = self;
    _payTypeCell              = [self viewWithNib:@"ServiceSettlementPayTypeCell"];
    _payTypeCell.delegate     = self;
}

- (id)viewWithNib:(NSString *)nib{
    return [[NSBundle mainBundle] loadNibNamed:nib owner:self options:nil].firstObject;
}

#pragma mark - 从购物车获取商品结算信息

- (void)loadShoppingCart{
    NSString *couponCode = self.couponCode.length>0?self.couponCode:@"";
    NSDictionary *param = @{@"couponCode":couponCode,
                            @"scoreNum":@(self.scoreNum),
                            @"isCancelCoupon":@(self.isCancelCoupon)};
    [TCProgressHUD showSVP];
    [Request startWithName:@"SHOPPINGCART_GET_V2" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        ServiceSettlementModel *model = [ServiceSettlementModel modelWithDictionary:dic];
        [self loadShoppingCartSuccess:model];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [[iToast makeText:@"获取商品结算信息失败"] show];
        [self back];
    }];
}

- (void)loadShoppingCartSuccess:(ServiceSettlementModel *)model {
    if (model.data.count>0) {
        ServiceSettlementDataItem *item = model.data.firstObject;
        if (item) {
            [self setupSections:model];
            self.model = model;
            self.tooBar.item = item;
            [self.tableView reloadData];
        }
    }
}

- (void)setupSections:(ServiceSettlementModel *)model{
    ServiceSettlementDataItem *item = model.data.firstObject;
    NSMutableArray<NSMutableArray<ServiceSettlementBaseCell *> *> *sections = [NSMutableArray<NSMutableArray<ServiceSettlementBaseCell *> *> array];
    //收货地址
    if (item.hasUserAddress) {
        NSMutableArray<ServiceSettlementBaseCell *> *section00 = [NSMutableArray array];
        if (item.userAddress) {
            [section00 addObject:_addressCell];
        }else{
            [section00 addObject:_tipAddressCell];
        }
        [sections addObject:section00];
    }
    //商品、门店
    NSMutableArray<ServiceSettlementBaseCell *> *section01 = [NSMutableArray array];
    [section01 addObject:_serViceInfoCell];
    if (item.store && item.store.storeDesc.length>0) {
        [section01 addObject:_storeInfoCell];
    }
    [sections addObject:section01];
    //优惠券、积分
    NSMutableArray<ServiceSettlementBaseCell *> *section02 = [NSMutableArray array];
    [section02 addObject:_couponCell];
    [sections addObject:section02];
    //选择支付类型
    NSMutableArray<ServiceSettlementBaseCell *> *section03 = [NSMutableArray array];
    [section03 addObject:_payTypeCell];
    [sections addObject:section03];
    //结算信息
    NSMutableArray<ServiceSettlementBaseCell *> *section04 = [NSMutableArray array];
    ServiceSettlementPayInfoCell *pricePayInfoCell = [self viewWithNib:@"ServiceSettlementPayInfoCell"];
    pricePayInfoCell.type = ServiceSettlementPayInfoCellTypePrice;
    [section04 addObject:pricePayInfoCell];
    ServiceSettlementPayInfoCell *promotionPayInfoCell = [self viewWithNib:@"ServiceSettlementPayInfoCell"];
    promotionPayInfoCell.type = ServiceSettlementPayInfoCellTypePromotion;
    [section04 addObject:promotionPayInfoCell];
    ServiceSettlementPayInfoCell *scorePayInfoCell = [self viewWithNib:@"ServiceSettlementPayInfoCell"];
    scorePayInfoCell.type = ServiceSettlementPayInfoCellTypeScore;
    [section04 addObject:scorePayInfoCell];
    if (item.transportationExpenses>0) {
        ServiceSettlementPayInfoCell *transportationExpensesPayInfoCell = [self viewWithNib:@"ServiceSettlementPayInfoCell"];
        transportationExpensesPayInfoCell.type = ServiceSettlementPayInfoCellTypeTransportationExpenses;
        [section04 addObject:transportationExpensesPayInfoCell];
    }
    [sections addObject:section04];
    
    self.sections = sections;
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
        }
            break;
        case ServiceSettlementBaseCellActionTypeChangePayType:
        {
            self.payType = (PayType)[value integerValue];
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
    BOOL isFullCut = couponCode.length<=0;
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


@end
