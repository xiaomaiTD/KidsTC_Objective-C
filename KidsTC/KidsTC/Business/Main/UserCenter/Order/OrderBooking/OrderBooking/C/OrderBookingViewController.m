//
//  OrderBookingViewController.m
//  KidsTC
//
//  Created by zhanping on 2016/9/18.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "OrderBookingViewController.h"

#import "GHeader.h"
#import "NSString+Category.h"
#import "NSDate+ZP.h"

#import "OrderBookingModel.h"

#import "OrderBookingBaseCell.h"
#import "OrderBookingServiceInfoCell.h"
#import "OrderBookingStoreInfoCell.h"
#import "OrderBookingSelectTimeCell.h"
#import "OrderBookingSelectAgeCell.h"
#import "OrderBookingRemarksCell.h"
#import "OrderBookingMakeSureCell.h"

#import "ServiceDetailViewController.h"
#import "StoreDetailViewController.h"
#import "OrderBookingSelectTimeViewController.h"
#import "OrderBookingSelectAgeViewController.h"

@interface OrderBookingViewController ()<UITableViewDelegate,UITableViewDataSource,OrderBookingBaseCellDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) OrderBookingServiceInfoCell *serviceInfoCell;
@property (nonatomic, strong) OrderBookingStoreInfoCell *storeInfoCell;
@property (nonatomic, strong) OrderBookingSelectTimeCell *selectTimeCell;
@property (nonatomic, strong) OrderBookingSelectAgeCell *selectAgeCell;
@property (nonatomic, strong) OrderBookingRemarksCell *remarksCell;
@property (nonatomic, strong) OrderBookingMakeSureCell *makeSureCell;

@property (nonatomic, strong) OrderBookingData *data;
@property (nonatomic, strong) NSMutableArray<NSMutableArray<OrderBookingBaseCell *> *> *sections;

@end

@implementation OrderBookingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"在线预约";
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tableView.estimatedRowHeight = 44.0f;
    tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [self prepareCells];
    
    [self loadData];
}

- (void)prepareCells{
    _serviceInfoCell = [self viewWithNib:@"OrderBookingServiceInfoCell"];
    _serviceInfoCell.delegate = self;
    _storeInfoCell = [self viewWithNib:@"OrderBookingStoreInfoCell"];
    _storeInfoCell.delegate = self;
    _selectTimeCell = [self viewWithNib:@"OrderBookingSelectTimeCell"];
    _selectTimeCell.delegate = self;
    _selectAgeCell = [self viewWithNib:@"OrderBookingSelectAgeCell"];
    _selectAgeCell.delegate = self;
    _remarksCell = [self viewWithNib:@"OrderBookingRemarksCell"];
    _makeSureCell = [self viewWithNib:@"OrderBookingMakeSureCell"];
    _makeSureCell.delegate = self;
}

- (id)viewWithNib:(NSString *)nib{
    return [[NSBundle mainBundle] loadNibNamed:nib owner:self options:nil].firstObject;
}

- (void)loadData {
    
    if (![_orderNo isNotNull]) {
        [[iToast makeText:@"订单编号为空"] show];
        [self back];
        return;
    }
    [TCProgressHUD showSVP];
    NSDictionary *param = @{@"orderno":_orderNo};
    [Request startWithName:@"ONLINE_BESPEAK_USER_GET" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        [self loadDataSuccess:[OrderBookingModel modelWithDictionary:dic]];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self loadDataFailure:error];
    }];
}

- (void)loadDataSuccess:(OrderBookingModel *)model {
    
    if (!model.data) {
        [[iToast makeText:@"在线预约信息请求失败，请稍后再试"] show];
        [self back];
    }
    
    if ((model.data.bespeakStatus == OrderBookingBespeakStatusCanBespeak) || _mustEdit) {
        if (model.data.timeShowModels.count>0) {
            self.data = model.data;
        }else{
            [[iToast makeText:@"没有合适的在线预约时间噢"] show];
            [self back];
        }
    }else{
        self.data = model.data;
    }
}

- (void)loadDataFailure:(NSError *)error {
    [[iToast makeText:@"在线预约信息请求失败，请稍后再试"] show];
    [self back];
}

- (void)setData:(OrderBookingData *)data {
    _data = data;
    [self setupSections:data];
    [_tableView reloadData];
}

- (void)setupSections:(OrderBookingData *)data {
    NSMutableArray<NSMutableArray<OrderBookingBaseCell *> *> *sections = [NSMutableArray new];
    
    NSMutableArray<OrderBookingBaseCell *> *sectionForBase = [NSMutableArray new];
    [sectionForBase addObject:_serviceInfoCell];
    [sectionForBase addObject:_storeInfoCell];
    [sectionForBase addObject:_selectTimeCell];
    if (data.productOnlineBespeakConfig.isBabyAge) {
        [sectionForBase addObject:_selectAgeCell];
    }
    [sections addObject:sectionForBase];
    
    if (data.supplierRemarkStr.length>0) {
        NSMutableArray<OrderBookingBaseCell *> *sectionForRemarks = [NSMutableArray new];
        [sectionForRemarks addObject:_remarksCell];
        [sections addObject:sectionForRemarks];
    }
    
    if (_mustEdit || data.bespeakStatus == OrderBookingBespeakStatusCanBespeak) {
        NSMutableArray<OrderBookingBaseCell *> *sectionForMakeSure = [NSMutableArray new];
        [sectionForMakeSure addObject:_makeSureCell];
        [sections addObject:sectionForMakeSure];
    }
    
    _sections = sections;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.sections[section].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section==0?8:0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OrderBookingBaseCell *cell = self.sections[indexPath.section][indexPath.row];
    cell.mustEdit = _mustEdit;//要放在data之前赋值
    cell.data = _data;
    return cell;
}

#pragma mark - OrderBookingBaseCellDelegate

- (void)orderBookingBaseCell:(OrderBookingBaseCell *)cell actionType:(OrderBookingBaseCellActionType)type value:(id)value {
    switch (type) {
        case OrderBookingBaseCellActionTypeServiceInfo:
        {
            [self serviceInfo];
        }
            break;
        case OrderBookingBaseCellActionTypeStoreInfo:
        {
            [self storeInfo];
        }
            break;
        case OrderBookingBaseCellActionTypeSelectTime:
        {
            [self selectTime];
        }
            break;
        case OrderBookingBaseCellActionTypeSelectAge:
        {
            [self selectAge];
        }
            break;
        case OrderBookingBaseCellActionTypeMakeSure:
        {
            [self makeSure];
        }
            break;
    }
}

- (void)serviceInfo {
    ServiceDetailViewController *controller = [[ServiceDetailViewController alloc] initWithServiceId:self.data.productInfo.productId channelId:@""];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)storeInfo {
    StoreDetailViewController *controller = [[StoreDetailViewController alloc] initWithStoreId:self.data.storeInfo.storeNo];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)selectTime {
    OrderBookingSelectTimeViewController *controller = [[OrderBookingSelectTimeViewController alloc] initWithNibName:@"OrderBookingSelectTimeViewController" bundle:nil];
    controller.data = _data;
    controller.makeSureBlock = ^void(OrderBookingTimeShowModel *model){
        self.data.currentTimeShowModel = model;
        [_tableView reloadData];
    };
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    controller.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)selectAge {
    OrderBookingSelectAgeViewController *controller = [[OrderBookingSelectAgeViewController alloc] initWithNibName:@"OrderBookingSelectAgeViewController" bundle:nil];
    controller.age = _data.userBespeakInfo.babyAge;
    controller.makeSureBlock = ^void (NSInteger age){
        self.data.userBespeakInfo.babyAge = age;
        [_tableView reloadData];
    };
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    controller.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)makeSure {
    
    OrderBookingTimeShowModel *timeShowModel = self.data.currentTimeShowModel;
    if (!timeShowModel) {
        [[iToast makeText:@"请选择预约时间"] show];
        return;
    }
    BOOL isBabyAge = _data.productOnlineBespeakConfig.isBabyAge;
    NSUInteger age = _data.userBespeakInfo.babyAge;
    if (isBabyAge) {
        if (age>12) {
            [[iToast makeText:@"请选择宝宝年龄"] show];
            return;
        }
    }
    NSDictionary *param = @{@"orderno":_orderNo,
                            @"bespeaktimes":self.bespeaktimes,
                            @"babyage":@(age)};
    [TCProgressHUD showSVP];
    [Request startWithName:@"ONLINE_BESPEAK_EDIT" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        [self makeSureSuccess:nil];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self makeSureFailure:error];
    }];
}

- (NSString *)bespeaktimes{
    NSString *bespeaktimes = nil;
    NSDictionary *dic = [self bespeaktimeItemDic:self.data.currentTimeShowModel];
    if (dic) {
        NSArray *ary = @[dic];
        NSString *str = [ary modelToJSONString];
        if ([str isNotNull]) {
            bespeaktimes = str;
        }
    }
    return bespeaktimes;
}

- (NSDictionary *)bespeaktimeItemDic:(OrderBookingTimeShowModel *)model{
    NSDictionary *bespeaktimeItemDic = nil;
    NSString *dayStr = model.dayStr;
    NSString *timeStr = model.timesAry[model.selectIndex];
    if ([dayStr isNotNull] && [timeStr isNotNull]) {
        NSDate *dayDate = [NSDate zp_dateWithTimeString:dayStr withDateFormat:DF_yMd];
        if (dayDate) {
            NSArray *ary = [timeStr componentsSeparatedByString:@"-"];
            if (ary.count==2) {
                NSString *sTimeStr = ary[0];
                NSString *eTimeStr = ary[1];
                if ([sTimeStr isNotNull] && [eTimeStr isNotNull]) {
                    NSDate *sTime = [NSDate zp_dateWithTimeString:sTimeStr withDateFormat:DF_hm];
                    NSDate *eTime = [NSDate zp_dateWithTimeString:eTimeStr withDateFormat:DF_hm];
                    if (sTime && eTime) {
                        NSString *startTimeStr = [NSString stringWithFormat:@"%@ %@",dayStr,sTimeStr];
                        NSString *endTimeStr = [NSString stringWithFormat:@"%@ %@",dayStr,eTimeStr];
                        if ([startTimeStr isNotNull] && [endTimeStr isNotNull]) {
                            NSDate *startTimeDate = [NSDate zp_dateWithTimeString:startTimeStr withDateFormat:DF_yMd_hm];
                            NSDate *endTimeDate = [NSDate zp_dateWithTimeString:endTimeStr withDateFormat:DF_yMd_hm];
                            if (startTimeDate && endTimeDate) {
                                NSTimeInterval sTimeInterval = [startTimeDate timeIntervalSince1970];
                                NSTimeInterval eTimeInterval = [endTimeDate timeIntervalSince1970];
                                bespeaktimeItemDic = @{@"StartTime":@(sTimeInterval),@"EndTime":@(eTimeInterval)};
                            }
                        }
                    }
                }
            }
        }
    }
    return bespeaktimeItemDic;
}

- (void)makeSureSuccess:(id)value {
    [[iToast makeText:@"恭喜您，提交成功"] show];
    if (self.successBlock) {
        self.successBlock();
    }
    [self back];
}

- (void)makeSureFailure:(NSError *)error {
    
    NSString *msg = error.userInfo[@"data"];
    if (![msg isNotNull]) {
        msg = @"提交在线预约信息失败，请稍后再试";
    }
    [[iToast makeText:msg] show];
}


@end
