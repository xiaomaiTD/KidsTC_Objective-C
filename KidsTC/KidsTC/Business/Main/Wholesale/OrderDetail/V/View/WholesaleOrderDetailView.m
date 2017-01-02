//
//  WholesaleOrderDetailView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleOrderDetailView.h"
#import "NSString+Category.h"

#import "WholesaleOrderDetailBaseCell.h"
#import "WholesaleOrderDetailFailureCell.h"
#import "WholesaleOrderDetailSuccessCell.h"
#import "WholesaleOrderDetailProductInfoCell.h"
#import "WholesaleOrderDetailSurplusCell.h"
#import "WholesaleOrderDetailCountDownCell.h"
#import "WholesaleOrderDetailLeaderCell.h"
#import "WholesaleOrderDetailJoinTipCell.h"
#import "WholesaleOrderDetailJoinMemberCell.h"
#import "WholesaleOrderDetailJoinCountCell.h"
#import "WholesaleOrderDetailRuleCell.h"
#import "WholesaleOrderDetailProgressCell.h"
#import "WholesaleOrderDetailBuyNoticeEmptyCell.h"
#import "WholesaleOrderDetailBuyNoticeElementCell.h"
#import "WholesaleOrderDetailTitleCell.h"
#import "WholesaleOrderDetailWebTipCell.h"
#import "WholesaleOrderDetailWebCell.h"

#import "WholesaleOrderDetailToolBar.h"

static NSString *const BaseCellID = @"WholesaleOrderDetailBaseCell";
static NSString *const FailureCellID = @"WholesaleOrderDetailFailureCell";
static NSString *const SuccessCellID = @"WholesaleOrderDetailSuccessCell";
static NSString *const ProductInfoCellID = @"WholesaleOrderDetailProductInfoCell";
static NSString *const SurplusCellID = @"WholesaleOrderDetailSurplusCell";
static NSString *const CountDownCellID = @"WholesaleOrderDetailCountDownCell";
static NSString *const LeaderCellID = @"WholesaleOrderDetailLeaderCell";
static NSString *const JoinTipCellID = @"WholesaleOrderDetailJoinTipCell";
static NSString *const JoinMemberCellID = @"WholesaleOrderDetailJoinMemberCell";
static NSString *const JoinCountCellID = @"WholesaleOrderDetailJoinCountCell";
static NSString *const RuleCellID = @"WholesaleOrderDetailRuleCell";
static NSString *const ProgressCellID = @"WholesaleOrderDetailProgressCell";
static NSString *const BuyNoticeEmptyCellID = @"WholesaleOrderDetailBuyNoticeEmptyCell";
static NSString *const BuyNoticeElementCellID = @"WholesaleOrderDetailBuyNoticeElementCell";
static NSString *const TitleCellID = @"WholesaleOrderDetailTitleCell";
static NSString *const WebTipCellID = @"WholesaleOrderDetailWebTipCell";
static NSString *const WebCellID = @"WholesaleOrderDetailWebCell";

@interface WholesaleOrderDetailView ()<UITableViewDelegate,UITableViewDataSource,WholesaleOrderDetailBaseCellDelegate,WholesaleOrderDetailToolBarDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSArray<WholesaleOrderDetailBaseCell *> *> *sections;

@property (nonatomic, strong) WholesaleOrderDetailToolBar *toolBar;
@end

@implementation WholesaleOrderDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
        [self setupTableView];
        [self setupToolBar];
    }
    return self;
}

- (void)setData:(WholesaleOrderDetailData *)data {
    _data = data;
    self.toolBar.data = data;
    [self setupSections];
    [self.tableView reloadData];
}

#pragma mark - setupTableView

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-kWholesaleOrderDetailToolBarH) style:UITableViewStyleGrouped];
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
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleOrderDetailBaseCell" bundle:nil] forCellReuseIdentifier:BaseCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleOrderDetailFailureCell" bundle:nil] forCellReuseIdentifier:FailureCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleOrderDetailSuccessCell" bundle:nil] forCellReuseIdentifier:SuccessCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleOrderDetailProductInfoCell" bundle:nil] forCellReuseIdentifier:ProductInfoCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleOrderDetailSurplusCell" bundle:nil] forCellReuseIdentifier:SurplusCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleOrderDetailCountDownCell" bundle:nil] forCellReuseIdentifier:CountDownCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleOrderDetailLeaderCell" bundle:nil] forCellReuseIdentifier:LeaderCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleOrderDetailJoinTipCell" bundle:nil] forCellReuseIdentifier:JoinTipCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleOrderDetailJoinMemberCell" bundle:nil] forCellReuseIdentifier:JoinMemberCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleOrderDetailJoinCountCell" bundle:nil] forCellReuseIdentifier:JoinCountCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleOrderDetailRuleCell" bundle:nil] forCellReuseIdentifier:RuleCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleOrderDetailProgressCell" bundle:nil] forCellReuseIdentifier:ProgressCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleOrderDetailBuyNoticeEmptyCell" bundle:nil] forCellReuseIdentifier:BuyNoticeEmptyCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleOrderDetailBuyNoticeElementCell" bundle:nil] forCellReuseIdentifier:BuyNoticeElementCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleOrderDetailTitleCell" bundle:nil] forCellReuseIdentifier:TitleCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleOrderDetailWebTipCell" bundle:nil] forCellReuseIdentifier:WebTipCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleOrderDetailWebCell" bundle:nil] forCellReuseIdentifier:WebCellID];
}

- (__kindof UITableViewCell *)cellWithID:(NSString *)cellID {
    return [self.tableView dequeueReusableCellWithIdentifier:cellID];
}

- (void)setupSections {
    
    WholesaleOrderDetailData *data = self.data;
    
    NSMutableArray *sections  = [NSMutableArray array];
    
    NSMutableArray *section01 = [NSMutableArray array];
    switch (data.openGroupStatus) {
        case FightGroupOpenGroupStatusOpenGroupSuccess:
        case FightGroupOpenGroupStatusJoinGroupSuccess:
        {
            WholesaleOrderDetailSuccessCell *successCell = [self cellWithID:SuccessCellID];
            if (successCell) [section01 addObject:successCell];
        }
            break;
        case FightGroupOpenGroupStatusOpenGroupFailure:
        case FightGroupOpenGroupStatusJoinGroupFailure:
        {
            WholesaleOrderDetailFailureCell *failureCell = [self cellWithID:FailureCellID];
            if (failureCell) [section01 addObject:failureCell];
        }
            break;
        default:
            break;
    }
    if (data.fightGroupBase) {
        WholesaleOrderDetailProductInfoCell *productInfoCell = [self cellWithID:ProductInfoCellID];
        if (productInfoCell) [section01 addObject:productInfoCell];
    }
    WholesaleOrderDetailSurplusCell *surplusCell = [self cellWithID:SurplusCellID];
    if (surplusCell) [section01 addObject:surplusCell];
    WholesaleOrderDetailCountDownCell *countDownCell = [self cellWithID:CountDownCellID];
    if (countDownCell) [section01 addObject:countDownCell];
    if (data.openGroupUser) {
        WholesaleOrderDetailLeaderCell *leaderCell = [self cellWithID:LeaderCellID];
        if (leaderCell) [section01 addObject:leaderCell];
    }
    if (data.partners.count>0) {
        WholesaleOrderDetailJoinTipCell *joinTipCell = [self cellWithID:JoinTipCellID];
        if (joinTipCell) [section01 addObject:joinTipCell];
    }
    [data.partners enumerateObjectsUsingBlock:^(WholesaleOrderDetailPartner *obj, NSUInteger idx, BOOL *stop) {
        WholesaleOrderDetailJoinMemberCell *joinMemberCell = [self cellWithID:JoinMemberCellID];
        joinMemberCell.partner = obj;
        if (joinMemberCell) [section01 addObject:joinMemberCell];
    }];
    if (data.partnerCounts.count>1) {
        WholesaleOrderDetailJoinCountCell *joinCountCell = [self cellWithID:JoinCountCellID];
        joinCountCell.tag = WholesaleOrderDetailBaseCellActionTypeLoadPartners;
        joinCountCell.counts = data.partnerCounts;
        if (joinCountCell) [section01 addObject:joinCountCell];
    }
    if(section01.count>0) [sections addObject:section01];
    
    NSMutableArray *section02 = [NSMutableArray array];
    if ([data.fightGroupBase.flowUrl isNotNull]) {
        WholesaleOrderDetailRuleCell *ruleCell = [self cellWithID:RuleCellID];
        if (ruleCell) [section02 addObject:ruleCell];
    }
    WholesaleOrderDetailProgressCell *progressCell = [self cellWithID:ProgressCellID];
    if (progressCell) [section02 addObject:progressCell];
    if(section02.count>0) [sections addObject:section02];
    
    
    [data.fightGroupBase.buyNotice enumerateObjectsUsingBlock:^(WholesaleProductDetailBuyNotice *buyNotice, NSUInteger idx, BOOL *stop) {
        NSMutableArray *section03 = [NSMutableArray array];
        WholesaleOrderDetailTitleCell *titleCell_buyNotice = [self cellWithID:TitleCellID];
        titleCell_buyNotice.title = buyNotice.title;
        if (titleCell_buyNotice) [section03 addObject:titleCell_buyNotice];
        [buyNotice.notice enumerateObjectsUsingBlock:^(WholesaleProductDetailNotice *notice, NSUInteger idx, BOOL *stop) {
            WholesaleOrderDetailBuyNoticeEmptyCell *buyNoticeEmptyCell = [self cellWithID:BuyNoticeEmptyCellID];
            if (buyNoticeEmptyCell) [section03 addObject:buyNoticeEmptyCell];
            WholesaleOrderDetailBuyNoticeElementCell *buyNoticeElementCell = [self cellWithID:BuyNoticeElementCellID];
            buyNoticeElementCell.notice = notice;
            if (buyNoticeElementCell) [section03 addObject:buyNoticeElementCell];
        }];
        if (buyNotice.notice.count>0) {
            WholesaleOrderDetailBuyNoticeEmptyCell *buyNoticeEmptyCell_last = [self cellWithID:BuyNoticeEmptyCellID];
            if (buyNoticeEmptyCell_last) [section03 addObject:buyNoticeEmptyCell_last];
        }
        if(section03.count>0) [sections addObject:section03];
    }];
    
    if ([data.fightGroupBase.detailUrl isNotNull]) {
        NSMutableArray *section04 = [NSMutableArray array];
        WholesaleOrderDetailTitleCell *titleCell_web = [self cellWithID:TitleCellID];
        titleCell_web.title = @"活动详情";
        if (titleCell_web) [section04 addObject:titleCell_web];
        WholesaleOrderDetailWebCell *webCell = [self cellWithID:WebCellID];
        webCell.webUrl = data.fightGroupBase.detailUrl;
        if (webCell) [section04 addObject:webCell];
        if(section04.count>0) [sections addObject:section04];
    }
    
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
        NSArray<WholesaleOrderDetailBaseCell *> *rows = self.sections[section];
        if (row<rows.count) {
            WholesaleOrderDetailBaseCell *cell = rows[row];
            cell.delegate = self;
            cell.data = self.data;
            return cell;
        }
    }
    return [tableView dequeueReusableCellWithIdentifier:BaseCellID];
}

#pragma mark WholesaleOrderDetailBaseCellDelegate

- (void)wholesaleOrderDetailBaseCell:(WholesaleOrderDetailBaseCell *)cell actionType:(WholesaleOrderDetailBaseCellActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(wholesaleOrderDetailView:actionType:value:)]) {
        [self.delegate wholesaleOrderDetailView:self actionType:(WholesaleOrderDetailViewActionType)type value:value];
    }
    if (type == WholesaleOrderDetailBaseCellActionTypeWebLoadFinish) {
        [self.tableView reloadData];
    }
}

#pragma mark - setupToolBar

- (void)setupToolBar {
    WholesaleOrderDetailToolBar *toolBar = [[NSBundle mainBundle] loadNibNamed:@"WholesaleOrderDetailToolBar" owner:self options:nil].firstObject;
    toolBar.hidden = YES;
    toolBar.delegate = self;
    toolBar.frame = CGRectMake(0, SCREEN_HEIGHT-64-kWholesaleOrderDetailToolBarH, SCREEN_WIDTH, kWholesaleOrderDetailToolBarH);
    [self addSubview:toolBar];
    self.toolBar = toolBar;
}

#pragma mark WholesaleOrderDetailToolBarDelegate

- (void)wholesaleOrderDetailToolBar:(WholesaleOrderDetailToolBar *)toolBar actionType:(WholesaleOrderDetailToolBarActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(wholesaleOrderDetailView:actionType:value:)]) {
        [self.delegate wholesaleOrderDetailView:self actionType:(WholesaleOrderDetailViewActionType)type value:nil];
    }
}


@end
