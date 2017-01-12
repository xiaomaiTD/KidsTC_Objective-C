//
//  RadishSettlementView.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/5.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishSettlementView.h"

#import "RadishSettlementBaseCell.h"
#import "RadishSettlementTipAddressCell.h"
#import "RadishSettlementAddressCell.h"
#import "RadishSettlementProductInfoCell.h"
#import "RadishSettlementPlaceInfoCell.h"
#import "RadishSettlementRadishCell.h"
#import "RadishSettlementPayTypeCell.h"
#import "RadishSettlementUserRemarkCell.h"

#import "RadishSettlementToolBar.h"

static NSString *const BaseCellID = @"RadishSettlementBaseCell";
static NSString *const TipAddressCellID = @"RadishSettlementTipAddressCell";
static NSString *const AddressCellID = @"RadishSettlementAddressCell";
static NSString *const ProductInfoCellID = @"RadishSettlementProductInfoCell";
static NSString *const PlaceInfoCellID = @"RadishSettlementPlaceInfoCell";
static NSString *const RadishCellID = @"RadishSettlementRadishCell";
static NSString *const PayTypeCellID = @"RadishSettlementPayTypeCell";
static NSString *const UserRemarkCellID = @"RadishSettlementUserRemarkCell";

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

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.bounds));
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

- (void)scrollToUserRemark {
    NSUInteger row = self.sections.lastObject.count-1;
    NSUInteger section = self.sections.count - 1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

#pragma mark - setupTableView

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-kRadishSettlementToolBarH) style:UITableViewStyleGrouped];
    tableView.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.contentInset = UIEdgeInsetsMake(0, 0, kRadishSettlementToolBarH, 0);
    //tableView.scrollIndicatorInsets = tableView.contentInset;
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
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishSettlementTipAddressCell" bundle:nil] forCellReuseIdentifier:TipAddressCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishSettlementAddressCell" bundle:nil] forCellReuseIdentifier:AddressCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishSettlementProductInfoCell" bundle:nil] forCellReuseIdentifier:ProductInfoCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishSettlementPlaceInfoCell" bundle:nil] forCellReuseIdentifier:PlaceInfoCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishSettlementRadishCell" bundle:nil] forCellReuseIdentifier:RadishCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishSettlementPayTypeCell" bundle:nil] forCellReuseIdentifier:PayTypeCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishSettlementUserRemarkCell" bundle:nil] forCellReuseIdentifier:UserRemarkCellID];
}

- (__kindof UITableViewCell *)cellWithID:(NSString *)cellID {
    return [self.tableView dequeueReusableCellWithIdentifier:cellID];
}

- (void)setupSections {
    
    NSMutableArray *sections  = [NSMutableArray array];
    
    //收货地址
    if (self.data.hasUserAddress) {
        NSMutableArray *section01 = [NSMutableArray array];
        if (self.data.userAddressInfo) {
            RadishSettlementAddressCell *addressCell = [self cellWithID:AddressCellID];
            if (addressCell) [section01 addObject:addressCell];
        }else{
            RadishSettlementTipAddressCell *tipAddressCell = [self cellWithID:TipAddressCellID];
            if (tipAddressCell) [section01 addObject:tipAddressCell];
        }
        if(section01.count>0) [sections addObject:section01];
    }
    
    NSMutableArray *section02 = [NSMutableArray array];
    RadishSettlementProductInfoCell *productInfoCell = [self cellWithID:ProductInfoCellID];
    if (productInfoCell) [section02 addObject:productInfoCell];
    switch (self.data.placeType) {
        case PlaceTypeStore:
        {
            if (self.data.store) {
                RadishSettlementPlaceInfoCell *placeInfoCell = [self cellWithID:PlaceInfoCellID];
                if (placeInfoCell) [section02 addObject:placeInfoCell];
            }
        }
            break;
        case PlaceTypePlace:
        {
            if (self.data.place.count>0) {
                RadishSettlementPlaceInfoCell *placeInfoCell = [self cellWithID:PlaceInfoCellID];
                if (placeInfoCell) [section02 addObject:placeInfoCell];
            }
        }
            break;
        default:
            break;
    }

    if(section02.count>0) [sections addObject:section02];
    
     NSMutableArray *section03 = [NSMutableArray array];
     RadishSettlementRadishCell *radishCell = [self cellWithID:RadishCellID];
     if (radishCell) [section03 addObject:radishCell];
     if(section03.count>0) [sections addObject:section03];
    
    NSMutableArray *section04 = [NSMutableArray array];
    RadishSettlementPayTypeCell *payTypeCell = [self cellWithID:PayTypeCellID];
    if (payTypeCell) [section04 addObject:payTypeCell];
    if(section04.count>0) [sections addObject:section04];
    
    NSMutableArray *section05 = [NSMutableArray array];
    RadishSettlementUserRemarkCell *userRemarkCell = [self cellWithID:UserRemarkCellID];
    if (userRemarkCell) [section05 addObject:userRemarkCell];
    if(section05.count>0) [sections addObject:section05];
    
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
