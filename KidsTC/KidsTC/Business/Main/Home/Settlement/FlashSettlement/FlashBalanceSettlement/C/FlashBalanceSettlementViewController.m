//
//  FlashBalanceSettlementViewController.m
//  KidsTC
//
//  Created by zhanping on 8/17/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "FlashBalanceSettlementViewController.h"
#import "GHeader.h"

#import "FlashBalanceSettlementBaseCell.h"
#import "FlashBalanceSettlementAddressCell.h"
#import "FlashBalanceSettlementServiceInfoCell.h"
#import "FlashBalanceSettlementStoreInfoCell.h"
#import "FlashBalanceSettlementScoreCell.h"
#import "FlashBalanceSettlementPayTypeCell.h"
#import "FlashBalanceSettlementPayInfoCell.h"
#import "FlashBalanceSettlementToolBar.h"

#import "SettlementPickScoreViewController.h"
#import "SettlementResultViewController.h"
#import "NavigationController.h"

#import "PayModel.h"
#import "KTCPaymentService.h"

#import "NSString+Category.h"

#define TOOLBAR_HEIGHT 60

@interface FlashBalanceSettlementViewController ()<UITableViewDelegate,UITableViewDataSource,FlashBalanceSettlementBaseCellDelegate>
@property (nonatomic, weak  ) UITableView                           *tableView;
@property (nonatomic, weak  ) FlashBalanceSettlementToolBar         *toolBar;
@property (nonatomic, strong) FlashBalanceSettlementAddressCell     *addressCell;
@property (nonatomic, strong) FlashBalanceSettlementServiceInfoCell *serviceInfoCell;
@property (nonatomic, strong) FlashBalanceSettlementStoreInfoCell   *storeInfoCell;
@property (nonatomic, strong) FlashBalanceSettlementScoreCell       *scoreCell;
@property (nonatomic, strong) FlashBalanceSettlementPayTypeCell     *payTypeCell;

@property (nonatomic, strong) NSArray<NSArray<FlashBalanceSettlementBaseCell *> *> *sections;

@property (nonatomic, assign) PayType payType;

@property (nonatomic, strong) FlashSettlementModel *model;
@end

@implementation FlashBalanceSettlementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![_orderId isNotNull]) {
        [[iToast makeText:@"闪购订单编号为空"] show];
        [self back];
        return;
    }
    
    self.pageId = 10504;
    self.trackParams = @{@"orderId":_orderId};
    
    self.navigationItem.title = @"结算";
    
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
    
    FlashBalanceSettlementToolBar *toolBar = [self viewWithNib:@"FlashBalanceSettlementToolBar"];
    toolBar.frame = CGRectMake(0, SCREEN_HEIGHT-TOOLBAR_HEIGHT, SCREEN_WIDTH, TOOLBAR_HEIGHT);
    WeakSelf(self)
    toolBar.actionBlock = ^void(){
        StrongSelf(self)
        [self commit];
    };
    [self.view addSubview:toolBar];
    _toolBar = toolBar;
    
    [self loadShoppingCart];
}

- (void)loadShoppingCart{
    NSDictionary *parameters = @{@"orderNo":self.orderId,
                                 @"confirmType":@(2)};
    [TCProgressHUD showSVP];
    [Request startWithName:@"FS_ORDER_CONFIRM_GET" param:parameters progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        FlashSettlementModel *model = [FlashSettlementModel modelWithDictionary:dic];
        if (model.data) {
            [self loadShoppingCartSuccess:model];
        }else{
            [self loadShoppingCartFailure:nil];
        }
        [TCProgressHUD dismissSVP];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self loadShoppingCartFailure:error];
    }];
}

- (void)loadShoppingCartSuccess:(FlashSettlementModel *)model {
    [self setupSections:model];
    self.model = model;
    _toolBar.data = model.data;
    [self.tableView reloadData];
}

- (void)loadShoppingCartFailure:(NSError *)error {
    [[iToast makeText:@"获取商品结算信息失败"] show];
    [self back];
}

- (void)setupSections:(FlashSettlementModel *)model{
    FlashSettlementData *data = model.data;
    NSMutableArray<NSMutableArray<FlashBalanceSettlementBaseCell *> *> *sections = [NSMutableArray array];
    if (data.hasUserAddress && data.userAddress) {
        NSMutableArray<FlashBalanceSettlementBaseCell *> *section00 = [NSMutableArray array];
        if (!_addressCell) {
            _addressCell = [self viewWithNib:@"FlashBalanceSettlementAddressCell"];
        }
        [section00 addObject:_addressCell];
        [sections addObject:section00];
    }
    
    NSMutableArray<FlashBalanceSettlementBaseCell *> *section01 = [NSMutableArray array];
    if (!_serviceInfoCell) {
        _serviceInfoCell = [self viewWithNib:@"FlashBalanceSettlementServiceInfoCell"];
    }
    [section01 addObject:_serviceInfoCell];
    if (data.storeInfo && data.storeInfo.storeDesc) {
        if (!_storeInfoCell) {
            _storeInfoCell = [self viewWithNib:@"FlashBalanceSettlementStoreInfoCell"];
        }
        [section01 addObject:_storeInfoCell];
    }
    [sections addObject:section01];
    
    NSMutableArray<FlashBalanceSettlementBaseCell *> *section02 = [NSMutableArray array];
    if (!_scoreCell) {
        _scoreCell = [self viewWithNib:@"FlashBalanceSettlementScoreCell"];
        _scoreCell.delegate = self;
    }
    [section02 addObject:_scoreCell];
    [sections addObject:section02];
    
    NSMutableArray<FlashBalanceSettlementBaseCell *> *section03 = [NSMutableArray array];
    if (!_payTypeCell) {
        _payTypeCell = [self viewWithNib:@"FlashBalanceSettlementPayTypeCell"];
        _payTypeCell.delegate = self;
    }
    [section03 addObject:_payTypeCell];
    [sections addObject:section03];
    
    NSMutableArray<FlashBalanceSettlementBaseCell *> *section04 = [NSMutableArray array];
    FlashBalanceSettlementPayInfoCell *pricePayInfoCell = [self viewWithNib:@"FlashBalanceSettlementPayInfoCell"];
    pricePayInfoCell.type = FlashBalanceSettlementPayInfoCellTypePrice;
    [section04 addObject:pricePayInfoCell];
    FlashBalanceSettlementPayInfoCell *scorePayInfoCell = [self viewWithNib:@"FlashBalanceSettlementPayInfoCell"];
    scorePayInfoCell.type = FlashBalanceSettlementPayInfoCellTypeScore;
    [section04 addObject:scorePayInfoCell];
    if (data.transportationExpenses>0) {
        FlashBalanceSettlementPayInfoCell *transportationExpensesPayInfoCell = [self viewWithNib:@"FlashBalanceSettlementPayInfoCell"];
        transportationExpensesPayInfoCell.type = FlashBalanceSettlementPayInfoCellTypeTransportationExpenses;
        [section04 addObject:transportationExpensesPayInfoCell];
    }
    [sections addObject:section04];
    
    self.sections = sections;
}

- (id)viewWithNib:(NSString *)nib{
    return [[NSBundle mainBundle] loadNibNamed:nib owner:self options:nil].firstObject;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

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
    FlashBalanceSettlementBaseCell *cell = self.sections[indexPath.section][indexPath.row];
    cell.data = _model.data;
    cell.indexPath = indexPath;
    return cell;
}


#pragma mark - FlashBalanceSettlementBaseCellDelegate

- (void)flashBalanceSettlementBaseCell:(FlashBalanceSettlementBaseCell *)cell actionType:(FlashBalanceSettlementBaseCellActionType)type value:(id)value{
    switch (type) {
        case FlashBalanceSettlementBaseCellActionTypeScore:
        {
            SettlementPickScoreViewController *controller = [[SettlementPickScoreViewController alloc]initWithNibName:@"SettlementPickScoreViewController" bundle:nil];
            controller.resultBlock = ^void (NSUInteger scoreNum) {
                _model.data.useScoreNum = scoreNum;
                _toolBar.data = _model.data;
                [self.tableView reloadData];
            };
            controller.scoreNum = self.model.data.maxScoreNum;
            controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            controller.modalPresentationStyle = UIModalPresentationCustom;
            [self presentViewController:controller animated:NO completion:nil];
        }
            break;
        case FlashBalanceSettlementBaseCellActionTypePayType:
        {
            self.payType = (PayType)[value integerValue];
        }
            break;
    }
}

- (void)commit{
    FlashSettlementData *data = _model.data;
    CGFloat price = data.price - data.useScoreNum/10.0;if (price<0) price = 0;
    NSString *priceStr = [NSString priceStr:price];
    NSDictionary *param = @{@"paytype":@(self.payType),
                            @"price":priceStr,
                            @"point":@(data.useScoreNum),
                            @"orderId":data.orderNo,
                            @"soleid":_model.soleid};
    [TCProgressHUD showSVP];
    _toolBar.btn.enabled = NO;
    [Request startWithName:@"FS_BALANCE_ORDER" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        _toolBar.btn.enabled = YES;
        [self placeOrderSucceed:[PayModel modelWithDictionary:dic]];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        _toolBar.btn.enabled = YES;
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
    controller.type = SettlementResultTypeFlash;
    NavigationController *navi = [[NavigationController alloc]initWithRootViewController:controller];
    [self presentViewController:navi animated:YES completion:^{
        [self.navigationController popViewControllerAnimated:NO];
        self.tableView.delegate = nil;
        self.tableView.dataSource = nil;
    }];
}

@end
