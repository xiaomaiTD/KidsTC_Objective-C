//
//  WolesaleProductDetailView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WolesaleProductDetailView.h"
#import "NSString+Category.h"

#import "WolesaleProductDetailBaseCell.h"
#import "WolesaleProductDetailProgressCell.h"
#import "WolesaleProductDetailProductInfoCell.h"
#import "WolesaleProductDetailRuleTipCell.h"
#import "WolesaleProductDetailJoinTipCell.h"
#import "WolesaleProductDetailJoinCountDownCell.h"
#import "WolesaleProductDetailJoinTeamCell.h"
#import "WolesaleProductDetailJoinCountCell.h"
#import "WolesaleProductDetailTitleCell.h"
#import "WolesaleProductDetailBuyNoticeEmptyCell.h"
#import "WolesaleProductDetailBuyNoticeElementCell.h"
#import "WolesaleProductDetailTimeCell.h"
#import "WolesaleProductDetailAddressCell.h"
#import "WolesaleProductDetailWebCell.h"
#import "WolesaleProductDetailOtherPorductCell.h"

#import "WolesaleProductDetailToolBar.h"

static NSString *const BaseCellID = @"WolesaleProductDetailBaseCell";
static NSString *const ProgressCellID = @"WolesaleProductDetailProgressCell";
static NSString *const ProductInfoCellID = @"WolesaleProductDetailProductInfoCell";
static NSString *const RuleTipCellID = @"WolesaleProductDetailRuleTipCell";
static NSString *const JoinTipCellID = @"WolesaleProductDetailJoinTipCell";
static NSString *const JoinCountDownCellID = @"WolesaleProductDetailJoinCountDownCell";
static NSString *const JoinTeamCellID = @"WolesaleProductDetailJoinTeamCell";
static NSString *const JoinCountCellID = @"WolesaleProductDetailJoinCountCell";
static NSString *const TitleCellID = @"WolesaleProductDetailTitleCell";
static NSString *const BuyNoticeEmptyCellID = @"WolesaleProductDetailBuyNoticeEmptyCell";
static NSString *const BuyNoticeElementCellID = @"WolesaleProductDetailBuyNoticeElementCell";
static NSString *const TimeCellID = @"WolesaleProductDetailTimeCell";
static NSString *const AddressCellID = @"WolesaleProductDetailAddressCell";
static NSString *const WebCellID = @"WolesaleProductDetailWebCell";
static NSString *const OtherPorductCellID = @"WolesaleProductDetailOtherPorductCell";

@interface WolesaleProductDetailView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSArray<WolesaleProductDetailBaseCell *> *> *sections;

@property (nonatomic, strong) WolesaleProductDetailToolBar *toolBar;
@end

@implementation WolesaleProductDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupTableView];
        [self setupToolBar];
    }
    return self;
}

- (void)setData:(WolesaleProductDetailData *)data {
    _data = data;
    self.toolBar.data = self.data;
    [self setupSections];
    [self.tableView reloadData];
}

#pragma mark - setupTableView

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-kWolesaleProductDetailToolBarH) style:UITableViewStyleGrouped];
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
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailBaseCell" bundle:nil] forCellReuseIdentifier:BaseCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailProgressCell" bundle:nil] forCellReuseIdentifier:ProgressCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailProductInfoCell" bundle:nil] forCellReuseIdentifier:ProductInfoCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailRuleTipCell" bundle:nil] forCellReuseIdentifier:RuleTipCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailJoinTipCell" bundle:nil] forCellReuseIdentifier:JoinTipCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailJoinCountDownCell" bundle:nil] forCellReuseIdentifier:JoinCountDownCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailJoinTeamCell" bundle:nil] forCellReuseIdentifier:JoinTeamCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailJoinCountCell" bundle:nil] forCellReuseIdentifier:JoinCountCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailTitleCell" bundle:nil] forCellReuseIdentifier:TitleCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailBuyNoticeEmptyCell" bundle:nil] forCellReuseIdentifier:BuyNoticeEmptyCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailBuyNoticeElementCell" bundle:nil] forCellReuseIdentifier:BuyNoticeElementCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailTimeCell" bundle:nil] forCellReuseIdentifier:TimeCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailAddressCell" bundle:nil] forCellReuseIdentifier:AddressCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailWebCell" bundle:nil] forCellReuseIdentifier:WebCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailOtherPorductCell" bundle:nil] forCellReuseIdentifier:OtherPorductCellID];
}

- (__kindof UITableViewCell *)cellWithID:(NSString *)cellID {
    return [self.tableView dequeueReusableCellWithIdentifier:cellID];
}

- (void)setupSections {
    
    WholesaleProductDetailBase *base = self.data.fightGroupBase;
    
    NSMutableArray *sections  = [NSMutableArray array];
    
    NSMutableArray *section01 = [NSMutableArray array];
    WolesaleProductDetailProgressCell *progressCell = [self cellWithID:ProgressCellID];
    if (progressCell) [section01 addObject:progressCell];
    WolesaleProductDetailProductInfoCell *productInfoCell = [self cellWithID:ProductInfoCellID];
    if (productInfoCell) [section01 addObject:productInfoCell];
    WolesaleProductDetailRuleTipCell *ruleTipCell = [self cellWithID:RuleTipCellID];
    if (ruleTipCell) [section01 addObject:ruleTipCell];
    if (base.teams.count>0) {
        WolesaleProductDetailJoinTipCell *joinTipCell = [self cellWithID:JoinTipCellID];
        if (joinTipCell) [section01 addObject:joinTipCell];
    }
    [base.teams enumerateObjectsUsingBlock:^(WholesaleProductDetailTeam *team, NSUInteger idx, BOOL *stop) {
        WolesaleProductDetailJoinTeamCell *joinTeamCell = [self cellWithID:JoinTeamCellID];
        joinTeamCell.team = team;
        if (joinTeamCell) [section01 addObject:joinTeamCell];
    }];
    if (base.teams.count>0) {
        WolesaleProductDetailJoinCountCell *joinCountCell = [self cellWithID:JoinCountCellID];
        if (joinCountCell) [section01 addObject:joinCountCell];
    }
    if(section01.count>0) [sections addObject:section01];
    
    [base.buyNotice enumerateObjectsUsingBlock:^(WholesaleProductDetailBuyNotice *buyNotice, NSUInteger idx, BOOL *stop) {
        NSMutableArray *section02 = [NSMutableArray array];
        WolesaleProductDetailTitleCell *titleCell_buyNotice = [self cellWithID:TitleCellID];
        titleCell_buyNotice.title = buyNotice.title;
        if (titleCell_buyNotice) [section02 addObject:titleCell_buyNotice];
        [buyNotice.notice enumerateObjectsUsingBlock:^(WholesaleProductDetailNotice *notice, NSUInteger idx, BOOL *stop) {
            WolesaleProductDetailBuyNoticeEmptyCell *buyNoticeEmptyCell = [self cellWithID:BuyNoticeEmptyCellID];
            if (buyNoticeEmptyCell) [section02 addObject:buyNoticeEmptyCell];
            WolesaleProductDetailBuyNoticeElementCell *buyNoticeElementCell = [self cellWithID:BuyNoticeElementCellID];
            buyNoticeElementCell.notice = notice;
            if (buyNoticeElementCell) [section02 addObject:buyNoticeElementCell];
        }];
        if (buyNotice.notice.count>0) {
            WolesaleProductDetailBuyNoticeEmptyCell *buyNoticeEmptyCell_last = [self cellWithID:BuyNoticeEmptyCellID];
            if (buyNoticeEmptyCell_last) [section02 addObject:buyNoticeEmptyCell_last];
        }
        if(section02.count>0) [sections addObject:section02];
    }];
    
    NSMutableArray *section03 = [NSMutableArray array];
    if (base.productTime || base.store || [base.detailUrl isNotNull]) {
        WolesaleProductDetailTitleCell *titleCell_detail = [self cellWithID:TitleCellID];
        titleCell_detail.title = @"活动详情";
        if (titleCell_detail) [section03 addObject:titleCell_detail];
    }
    if (base.productTime) {
        WolesaleProductDetailTimeCell *timeCell = [self cellWithID:TimeCellID];
        if (timeCell) [section03 addObject:timeCell];
    }
    if (base.store) {
        WolesaleProductDetailAddressCell *addressCell = [self cellWithID:AddressCellID];
        if (addressCell) [section03 addObject:addressCell];
    }
    if ([base.detailUrl isNotNull]) {
        WolesaleProductDetailWebCell *webCell = [self cellWithID:WebCellID];
        if (webCell) [section03 addObject:webCell];
    }
    if(section03.count>0) [sections addObject:section03];
    
    NSMutableArray *section04 = [NSMutableArray array];
    if (base.otherProducts.count>0) {
        WolesaleProductDetailTitleCell *titleCell_otherProduct = [self cellWithID:TitleCellID];
        titleCell_otherProduct.title = @"其他拼团活动";
        if (titleCell_otherProduct) [section04 addObject:titleCell_otherProduct];
    }
    [base.otherProducts enumerateObjectsUsingBlock:^(WholesaleProductDetailOtherProduct *otherProduct, NSUInteger idx, BOOL *stop) {
        WolesaleProductDetailOtherPorductCell *otherPorductCell = [self cellWithID:OtherPorductCellID];
        otherPorductCell.otherProduct = otherProduct;
        if (otherPorductCell) [section04 addObject:otherPorductCell];
    }];
    if (base.otherProducts.count>0) {
        WolesaleProductDetailJoinCountCell *joinCountCell_otherProducts = [self cellWithID:JoinCountCellID];
        if (joinCountCell_otherProducts) [section04 addObject:joinCountCell_otherProducts];
    }
    if(section04.count>0) [sections addObject:section04];
    
    self.sections = [NSArray arrayWithArray:sections];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

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
        NSArray<WolesaleProductDetailBaseCell *> *rows = self.sections[section];
        if (row<rows.count) {
            WolesaleProductDetailBaseCell *cell = rows[row];
            cell.data = self.data;
            return cell;
        }
    }
    return [tableView dequeueReusableCellWithIdentifier:BaseCellID];
}

#pragma mark - setupToolBar

- (void)setupToolBar {
    WolesaleProductDetailToolBar *toolBar = [[NSBundle mainBundle] loadNibNamed:@"WolesaleProductDetailToolBar" owner:self options:nil].firstObject;
    toolBar.hidden = YES;
    toolBar.frame = CGRectMake(0, SCREEN_HEIGHT-64-kWolesaleProductDetailToolBarH, SCREEN_WIDTH, kWolesaleProductDetailToolBarH);
    [self addSubview:toolBar];
    self.toolBar = toolBar;
}


@end
