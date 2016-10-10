//
//  FlashAdvanceSettlementViewController.m
//  KidsTC
//
//  Created by zhanping on 8/16/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "FlashAdvanceSettlementViewController.h"
#import "GHeader.h"

#import "FlashAdvanceSettlementBaseCell.h"
#import "FlashAdvanceSettlementTipAddressCell.h"
#import "FlashAdvanceSettlementAddressCell.h"
#import "FlashAdvanceSettlementServiceInfoCell.h"
#import "FlashAdvanceSettlementStoreInfoCell.h"
#import "FlashAdvanceSettlementPayTypeCell.h"
#import "FlashAdvanceSettlementReadRuleCell.h"
#import "FlashAdvanceSettlementToolBar.h"

#import "UserAddressEditViewController.h"
#import "UserAddressManageViewController.h"
#import "SettlementPickStoreViewController.h"
#import "SettlementResultViewController.h"
#import "NavigationController.h"
#import "WebViewController.h"

#import "PayModel.h"
#import "KTCPaymentService.h"

#import "NSString+Category.h"


#define TOOLBAR_HEIGHT 60

@interface FlashAdvanceSettlementViewController ()<UITableViewDelegate,UITableViewDataSource,FlashAdvanceSettlementBaseCellDelegate>
@property (nonatomic, weak  ) UITableView                           *tableView;
@property (nonatomic, weak  ) FlashAdvanceSettlementToolBar         *toolBar;
@property (nonatomic, strong) FlashAdvanceSettlementTipAddressCell  *tipAddressCell;
@property (nonatomic, strong) FlashAdvanceSettlementAddressCell     *addressCell;
@property (nonatomic, strong) FlashAdvanceSettlementServiceInfoCell *serviceInfoCell;
@property (nonatomic, strong) FlashAdvanceSettlementStoreInfoCell   *storeInfoCell;
@property (nonatomic, strong) FlashAdvanceSettlementPayTypeCell     *payTypeCell;
@property (nonatomic, strong) FlashAdvanceSettlementReadRuleCell    *readRuleCell;

@property (nonatomic, strong) NSArray<NSArray<FlashAdvanceSettlementBaseCell *> *> *sections;

@property (nonatomic, assign) BOOL hasReadRule;
@property (nonatomic, assign) PayType payType;

@property (nonatomic, strong) FlashSettlementModel *model;
@end

@implementation FlashAdvanceSettlementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    FlashAdvanceSettlementToolBar *toolBar = [self viewWithNib:@"FlashAdvanceSettlementToolBar"];
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
                                 @"confirmType":@(1)};
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
    _toolBar.model = model;
    [self.tableView reloadData];
}

- (void)loadShoppingCartFailure:(NSError *)error {
    [[iToast makeText:@"获取商品结算信息失败"] show];
    [self back];
}


- (void)setupSections:(FlashSettlementModel *)model{
    FlashSettlementData *data = model.data;
    NSMutableArray<NSMutableArray<FlashAdvanceSettlementBaseCell *> *> *sections = [NSMutableArray array];
    
    //收货地址
    if (data.hasUserAddress) {
        NSMutableArray<FlashAdvanceSettlementBaseCell *> *section00 = [NSMutableArray array];
        if (data.userAddress) {
            if (!_addressCell) {
                _addressCell = [self viewWithNib:@"FlashAdvanceSettlementAddressCell"];
                _addressCell.delegate = self;
            }
            [section00 addObject:_addressCell];
        }else{
            if (!_tipAddressCell) {
                _tipAddressCell = [self viewWithNib:@"FlashAdvanceSettlementTipAddressCell"];
                _tipAddressCell.delegate = self;
            }
            [section00 addObject:_tipAddressCell];
        }
        [sections addObject:section00];
    }
    
    //服务信息、门店信息
    NSMutableArray<FlashAdvanceSettlementBaseCell *> *section01 = [NSMutableArray array];
    if (!_serviceInfoCell) _serviceInfoCell = [self viewWithNib:@"FlashAdvanceSettlementServiceInfoCell"];
    [section01 addObject:_serviceInfoCell];
    if (data.storeInfo && data.storeInfo.storeDesc.length>0) {
        if (!_storeInfoCell) {
            _storeInfoCell = [self viewWithNib:@"FlashAdvanceSettlementStoreInfoCell"];
            _storeInfoCell.delegate = self;
        }
        [section01 addObject:_storeInfoCell];
    }
    [sections addObject:section01];
    
    //支付方式、阅读预付规则
    NSMutableArray<FlashAdvanceSettlementBaseCell *> *section02 = [NSMutableArray array];
    if (!_payTypeCell) {
        _payTypeCell = [self viewWithNib:@"FlashAdvanceSettlementPayTypeCell"];
        _payTypeCell.delegate = self;
    }
    [section02 addObject:_payTypeCell];
    if (!_readRuleCell) {
        _readRuleCell = [self viewWithNib:@"FlashAdvanceSettlementReadRuleCell"];
        _readRuleCell.delegate = self;
    }
    [section02 addObject:_readRuleCell];
    [sections addObject:section02];
    
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
    FlashAdvanceSettlementBaseCell *cell = self.sections[indexPath.section][indexPath.row];
    cell.data = self.model.data;
    cell.indexPath = indexPath;
    return cell;
}

#pragma mark - FlashAdvanceSettlementBaseCellDelegate

- (void)flashAdvanceSettlementBaseCell:(FlashAdvanceSettlementBaseCell *)cell actionType:(FlashAdvanceSettlementBaseCellActionType)type value:(id)value {

    switch (type) {
        case FlashAdvanceSettlementBaseCellActionTypeTipAddress:
        {
            UserAddressEditViewController *controller = [[UserAddressEditViewController alloc]init];
            controller.editType = UserAddressEditTypeAdd;
            controller.resultBlock = ^void(UserAddressManageDataItem *item){
                [self loadShoppingCart];
            };
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case FlashAdvanceSettlementBaseCellActionTypeAddress:
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
        case FlashAdvanceSettlementBaseCellActionTypeStoreInfo:
        {
            FlashSettlementData *data = self.model.data;
            SettlementPickStoreViewController *controller = [[SettlementPickStoreViewController alloc]init];
            controller.serveId = data.productNo;
            controller.storeId = data.storeInfo.storeId;
            controller.pickStoreBlock = ^void (SettlementPickStoreDataItem *store){
                self.model.data.storeInfo = store;
                [self.tableView reloadData];
            };
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case FlashAdvanceSettlementBaseCellActionTypePayType:
        {
            self.payType = (PayType)[value integerValue];
        }
            break;
        case FlashAdvanceSettlementBaseCellActionTypeCheckRule:
        {
            self.hasReadRule = [value boolValue];
        }
            break;
        case FlashAdvanceSettlementBaseCellActionTypeReadRule:
        {
            WebViewController *controller = [[WebViewController alloc]init];
            controller.urlString = self.model.data.prepaidRuleLinkUrl;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
    }
}

#pragma mark - 下单

- (void)commit{
    
    if (![self checkValite]) return;
    FlashSettlementData *data = self.model.data;
    NSString *soleid = [self.model.soleid isNotNull]?self.model.soleid:@"";
    NSString *addressId = [data.userAddress.ID isNotNull]?data.userAddress.ID:@"";
    NSString *storeId = [data.storeInfo.storeId isNotNull]?data.storeInfo.storeId:@"";
    NSDictionary *param = @{@"paytype":@(self.payType),
                            @"soleid":soleid,
                            @"addressId":addressId,
                            @"storeId":storeId};
    [TCProgressHUD showSVP];
    _toolBar.btn.enabled = NO;
    [Request startWithName:@"FS_PLACE_ORDER" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        _toolBar.btn.enabled = YES;
        [self placeOrderSucceed:[PayModel modelWithDictionary:dic]];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        _toolBar.btn.enabled = YES;
        [self placeOrderFailure:error];
    }];
}

- (BOOL)checkValite{
    
    if (!self.hasReadRule) {
        [[iToast makeText:@"请阅读并同意《闪购规则》"] show];
        return NO;
    }
    
    FlashSettlementData *data = self.model.data;
    if (data.hasUserAddress) {
        if (data.userAddress.ID>0) {
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
    controller.type = SettlementResultTypeFlash;
    NavigationController *navi = [[NavigationController alloc]initWithRootViewController:controller];
    [self presentViewController:navi animated:YES completion:^{
        [self.navigationController popViewControllerAnimated:NO];
        self.tableView.delegate = nil;
        self.tableView.dataSource = nil;
    }];
}

@end
