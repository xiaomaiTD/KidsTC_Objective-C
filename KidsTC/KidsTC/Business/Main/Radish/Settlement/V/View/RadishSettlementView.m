//
//  RadishSettlementView.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/5.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishSettlementView.h"

#import "RadishSettlementBaseCell.h"
#import "RadishSettlementAddressCell.h"
#import "RadishSettlementProductInfoCell.h"
#import "RadishSettlementPlaceInfoCell.h"
#import "RadishSettlementRadishCell.h"
#import "RadishSettlementPayTypeCell.h"

#import "RadishSettlementToolBar.h"

static NSString *const BaseCellID = @"RadishSettlementBaseCell";
static NSString *const AddressCellID = @"RadishSettlementAddressCell";
static NSString *const ProductInfoCellID = @"RadishSettlementProductInfoCell";
static NSString *const PlaceInfoCellID = @"RadishSettlementPlaceInfoCell";
static NSString *const RadishCellID = @"RadishSettlementRadishCell";
static NSString *const PayTypeCellID = @"RadishSettlementPayTypeCell";

@interface RadishSettlementView ()<UITableViewDelegate,UITableViewDataSource,RadishSettlementBaseCellDelegate,RadishSettlementToolBarDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSArray<RadishSettlementBaseCell *> *> *sections;

@property (nonatomic, strong) RadishSettlementToolBar *toolBar;
@end

@implementation RadishSettlementView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
        [self setupTableView];
        [self setupToolBar];
    }
    return self;
}

- (void)setData:(RadishSettlementData *)data {
    _data = data;
    self.toolBar.data = data;
    [self setupSections];
    [self.tableView reloadData];
}

- (void)reloadData {
    [self.tableView reloadData];
}

#pragma mark - setupTableView

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-kRadishSettlementToolBarH) style:UITableViewStyleGrouped];
    tableView.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 66;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self addSubview:tableView];
    self.tableView = tableView;
    [self registerCells];
    
    [self setupSections];
    
    [self.tableView reloadData];
}

- (void)registerCells {
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishSettlementBaseCell" bundle:nil] forCellReuseIdentifier:BaseCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishSettlementAddressCell" bundle:nil] forCellReuseIdentifier:AddressCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishSettlementProductInfoCell" bundle:nil] forCellReuseIdentifier:ProductInfoCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishSettlementPlaceInfoCell" bundle:nil] forCellReuseIdentifier:PlaceInfoCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishSettlementRadishCell" bundle:nil] forCellReuseIdentifier:RadishCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishSettlementPayTypeCell" bundle:nil] forCellReuseIdentifier:PayTypeCellID];
}

- (__kindof UITableViewCell *)cellWithID:(NSString *)cellID {
    return [self.tableView dequeueReusableCellWithIdentifier:cellID];
}

- (void)setupSections {
    
    NSMutableArray *sections  = [NSMutableArray array];
    
    NSMutableArray *section01 = [NSMutableArray array];
    RadishSettlementAddressCell *addressCell = [self cellWithID:AddressCellID];
    if (addressCell) [section01 addObject:addressCell];
    if(section01.count>0) [sections addObject:section01];
    
    NSMutableArray *section02 = [NSMutableArray array];
    RadishSettlementProductInfoCell *productInfoCell = [self cellWithID:ProductInfoCellID];
    if (productInfoCell) [section02 addObject:productInfoCell];
    RadishSettlementPlaceInfoCell *placeInfoCell = [self cellWithID:PlaceInfoCellID];
    if (placeInfoCell) [section02 addObject:placeInfoCell];
    if(section02.count>0) [sections addObject:section02];
    
     NSMutableArray *section03 = [NSMutableArray array];
     RadishSettlementRadishCell *radishCell = [self cellWithID:RadishCellID];
     if (radishCell) [section03 addObject:radishCell];
     if(section03.count>0) [sections addObject:section03];
    
    NSMutableArray *section04 = [NSMutableArray array];
    RadishSettlementPayTypeCell *payTypeCell = [self cellWithID:PayTypeCellID];
    if (payTypeCell) [section04 addObject:payTypeCell];
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
        NSArray<RadishSettlementBaseCell *> *rows = self.sections[section];
        if (row<rows.count) {
            RadishSettlementBaseCell *cell = rows[row];
            cell.delegate = self;
            cell.data = self.data;
            return cell;
        }
    }
    return [tableView dequeueReusableCellWithIdentifier:BaseCellID];
}

#pragma mark RadishSettlementBaseCellDelegate

- (void)radishSettlementBaseCell:(RadishSettlementBaseCell *)cell actionType:(RadishSettlementBaseCellActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(radishSettlementView:actionType:value:)]) {
        [self.delegate radishSettlementView:self actionType:(RadishSettlementViewActionType)type value:value];
    }
}

#pragma mark - setupToolBar

- (void)setupToolBar {
    RadishSettlementToolBar *toolBar = [[NSBundle mainBundle] loadNibNamed:@"RadishSettlementToolBar" owner:self options:nil].firstObject;
    toolBar.hidden = YES;
    toolBar.delegate = self;
    toolBar.frame = CGRectMake(0, SCREEN_HEIGHT-64-kRadishSettlementToolBarH, SCREEN_WIDTH, kRadishSettlementToolBarH);
    [self addSubview:toolBar];
    self.toolBar = toolBar;
}

#pragma mark RadishSettlementToolBarDelegate

- (void)didClickRadishSettlementToolBar:(RadishSettlementToolBar *)toolBar {
    if ([self.delegate respondsToSelector:@selector(radishSettlementView:actionType:value:)]) {
        [self.delegate radishSettlementView:self actionType:RadishSettlementViewActionTypePlaceOrder value:nil];
    }
}

@end