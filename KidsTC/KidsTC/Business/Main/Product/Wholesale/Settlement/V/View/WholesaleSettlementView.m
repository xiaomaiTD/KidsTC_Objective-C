//
//  WholesaleSettlementView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleSettlementView.h"

#import "WholesaleSettlementBaseCell.h"
#import "WholesaleSettlementAddressTipCell.h"
#import "WholesaleSettlementAddressCell.h"
#import "WholesaleSettlementProductInfoCell.h"
#import "WholesaleSettlementStoreInfoCell.h"
#import "WholesaleSettlementPayTypeCell.h"
#import "WholesaleSettlementPhoneCell.h"
#import "WholesaleSettlementRuleCell.h"
#import "WholesaleSettlementProgressCell.h"
#import "WholesaleSettlementDateCell.h"

#import "WholesaleSettlementToolBar.h"

static NSString *const BaseCellID = @"WholesaleSettlementBaseCell";
static NSString *const AddressTipCellID = @"WholesaleSettlementAddressTipCell";
static NSString *const AddressCellID = @"WholesaleSettlementAddressCell";
static NSString *const ProductInfoCellID = @"WholesaleSettlementProductInfoCell";
static NSString *const StoreInfoCellID = @"WholesaleSettlementStoreInfoCell";
static NSString *const PayTypeCellID = @"WholesaleSettlementPayTypeCell";
static NSString *const PhoneCellID = @"WholesaleSettlementPhoneCell";
static NSString *const RuleCellID = @"WholesaleSettlementRuleCell";
static NSString *const ProgressCellID = @"WholesaleSettlementProgressCell";
static NSString *const DateCellID = @"WholesaleSettlementDateCell";

@interface WholesaleSettlementView ()<UITableViewDelegate,UITableViewDataSource,WholesaleSettlementBaseCellDelegate,WholesaleSettlementToolBarDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSArray<WholesaleSettlementBaseCell *> *> *sections;

@property (nonatomic, strong) WholesaleSettlementToolBar *toolBar;
@end

@implementation WholesaleSettlementView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
        [self setupTableView];
        [self setupToolBar];
    }
    return self;
}

- (void)setData:(WholesaleSettlementData *)data {
    _data = data;
    self.toolBar.data = data;
    [self setupSections];
    [self.tableView reloadData];
}

- (void)reloadData {
    self.toolBar.data = self.data;
    //[self setupSections];
    [self.tableView reloadData];
}

#pragma mark - setupTableView

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-kWholesaleSettlementToolBarH) style:UITableViewStyleGrouped];
    tableView.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 66;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self addSubview:tableView];
    self.tableView = tableView;
    [self registerCells];
}

- (void)registerCells {
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleSettlementBaseCell" bundle:nil] forCellReuseIdentifier:BaseCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleSettlementAddressTipCell" bundle:nil] forCellReuseIdentifier:AddressTipCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleSettlementAddressCell" bundle:nil] forCellReuseIdentifier:AddressCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleSettlementProductInfoCell" bundle:nil] forCellReuseIdentifier:ProductInfoCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleSettlementStoreInfoCell" bundle:nil] forCellReuseIdentifier:StoreInfoCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleSettlementPayTypeCell" bundle:nil] forCellReuseIdentifier:PayTypeCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleSettlementPhoneCell" bundle:nil] forCellReuseIdentifier:PhoneCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleSettlementRuleCell" bundle:nil] forCellReuseIdentifier:RuleCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleSettlementProgressCell" bundle:nil] forCellReuseIdentifier:ProgressCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleSettlementDateCell" bundle:nil] forCellReuseIdentifier:DateCellID];
}

- (__kindof UITableViewCell *)cellWithID:(NSString *)cellID {
    return [self.tableView dequeueReusableCellWithIdentifier:cellID];
}

- (void)setupSections {
    
    NSMutableArray *sections  = [NSMutableArray array];
    
    if (self.data.hasUserAddress) {
        NSMutableArray *section00 = [NSMutableArray array];
        if (self.data.userAddressInfo) {
            WholesaleSettlementAddressCell *addressCell = [self cellWithID:AddressCellID];
            if (addressCell) [section00 addObject:addressCell];
        }else{
            WholesaleSettlementAddressTipCell *addressTipCell = [self cellWithID:AddressTipCellID];
            if (addressTipCell) [section00 addObject:addressTipCell];
        }
        if(section00.count>0) [sections addObject:section00];
    }
    
    NSMutableArray *section01 = [NSMutableArray array];
    WholesaleSettlementProductInfoCell *productInfoCell = [self cellWithID:ProductInfoCellID];
    if (productInfoCell) [section01 addObject:productInfoCell];
    if(section01.count>0) [sections addObject:section01];
    
    NSMutableArray *dateSection = [NSMutableArray array];
    WholesaleSettlementTime *time = self.data.time;
    if (time && time.isShow) {
        WholesaleSettlementDateCell *dateCell = [self cellWithID:DateCellID];
        if (dateCell) [dateSection addObject:dateCell];
    }
    if (self.data.sku.places.count>0) {
        WholesaleSettlementStoreInfoCell *storeInfoCell = [self cellWithID:StoreInfoCellID];
        if (storeInfoCell) [dateSection addObject:storeInfoCell];
    }
    if(dateSection.count>0) [sections addObject:dateSection];
    
    NSMutableArray *section02 = [NSMutableArray array];
    WholesaleSettlementPayTypeCell *payTypeCell = [self cellWithID:PayTypeCellID];
    if (payTypeCell) [section02 addObject:payTypeCell];
    if(section02.count>0) [sections addObject:section02];
    /*
     NSMutableArray *section03 = [NSMutableArray array];
     WholesaleSettlementPhoneCell *phoneCell = [self cellWithID:PhoneCellID];
     if (phoneCell) [section03 addObject:phoneCell];
     if(section03.count>0) [sections addObject:section03];
     */
    NSMutableArray *section04 = [NSMutableArray array];
    WholesaleSettlementRuleCell *ruleCell = [self cellWithID:RuleCellID];
    if (ruleCell) [section04 addObject:ruleCell];
    WholesaleSettlementProgressCell *progressCell = [self cellWithID:ProgressCellID];
    if (progressCell) [section04 addObject:progressCell];
    if(section04.count>0) [sections addObject:section04];
    
    self.sections = [NSArray arrayWithArray:sections];
}

#pragma mark UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section<self.sections.count) {
        return self.sections[section].count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section<self.sections.count) {
        NSArray<WholesaleSettlementBaseCell *> *rows = self.sections[section];
        if (row<rows.count) {
            WholesaleSettlementBaseCell *cell = rows[row];
            cell.delegate = self;
            cell.data = self.data;
            return cell;
        }
    }
    return [tableView dequeueReusableCellWithIdentifier:BaseCellID];
}

#pragma mark WholesaleSettlementBaseCellDelegate

- (void)wholesaleSettlementBaseCell:(WholesaleSettlementBaseCell *)cell actionType:(WholesaleSettlementBaseCellActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(wholesaleSettlementView:actionType:value:)]) {
        [self.delegate wholesaleSettlementView:self actionType:(WholesaleSettlementViewActionType)type value:value];
    }
}

#pragma mark - setupToolBar

- (void)setupToolBar {
    WholesaleSettlementToolBar *toolBar = [[NSBundle mainBundle] loadNibNamed:@"WholesaleSettlementToolBar" owner:self options:nil].firstObject;
    toolBar.hidden = YES;
    toolBar.delegate = self;
    toolBar.frame = CGRectMake(0, SCREEN_HEIGHT-64-kWholesaleSettlementToolBarH, SCREEN_WIDTH, kWholesaleSettlementToolBarH);
    [self addSubview:toolBar];
    self.toolBar = toolBar;
}

#pragma mark WholesaleSettlementToolBarDelegate

- (void)didClickWholesaleSettlementToolBar:(WholesaleSettlementToolBar *)toolBar {
    if ([self.delegate respondsToSelector:@selector(wholesaleSettlementView:actionType:value:)]) {
        [self.delegate wholesaleSettlementView:self actionType:WholesaleSettlementViewActionTypePlaceOrder value:nil];
    }
}

@end
