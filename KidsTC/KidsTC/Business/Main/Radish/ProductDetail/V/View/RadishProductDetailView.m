//
//  RadishProductDetailView.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/5.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishProductDetailView.h"
#import "NSString+Category.h"
#import "Colours.h"

#import "RadishProductDetailBaseCell.h"
#import "RadishProductDetailBannerCell.h"
#import "RadishProductDetailInfoCell.h"
#import "RadishProductDetailDateCell.h"
#import "RadishProductDetailPlaceCell.h"
#import "RadishProductDetailPlaceCountCell.h"
#import "RadishProductDetailTitleCell.h"
#import "RadishProductDetailBuyNoticeElementCell.h"
#import "RadishProductDetailBuyNoticeEmptyCell.h"
#import "RadishProductDetailJoinCell.h"
#import "RadishProductDetailTwoColumnWebViewCell.h"
#import "RadishProductDetailTwoColumnConsultTipCell.h"
#import "RadishProductDetailTwoColumnConsultEmptyCell.h"
#import "RadishProductDetailTwoColumnConsultConsultCell.h"
#import "RadishProductDetailTwoColumnConsultMoreCell.h"

#import "RadishProductDetailTwoColumnToolBar.h"
#import "RadishProductDetailToolBar.h"

static NSString *const BaseCellID = @"RadishProductDetailBaseCell";
static NSString *const BannerCellID = @"RadishProductDetailBannerCell";
static NSString *const InfoCellID = @"RadishProductDetailInfoCell";
static NSString *const DateCellID = @"RadishProductDetailDateCell";
static NSString *const PlaceCellID = @"RadishProductDetailPlaceCell";
static NSString *const PlaceCountCellID = @"RadishProductDetailPlaceCountCell";
static NSString *const TitleCellID = @"RadishProductDetailTitleCell";
static NSString *const BuyNoticeElementCellID = @"RadishProductDetailBuyNoticeElementCell";
static NSString *const BuyNoticeEmptyCellID = @"RadishProductDetailBuyNoticeEmptyCell";
static NSString *const JoinCellID = @"RadishProductDetailJoinCell";
static NSString *const TwoColumnWebViewCellID = @"RadishProductDetailTwoColumnWebViewCell";
static NSString *const TwoColumnConsultTipCellID = @"RadishProductDetailTwoColumnConsultTipCell";
static NSString *const TwoColumnConsultEmptyCellID = @"RadishProductDetailTwoColumnConsultEmptyCell";
static NSString *const TwoColumnConsultConsultCellID = @"RadishProductDetailTwoColumnConsultConsultCell";
static NSString *const TwoColumnConsultMoreCellID = @"RadishProductDetailTwoColumnConsultMoreCell";

@interface RadishProductDetailView ()<UITableViewDelegate,UITableViewDataSource,RadishProductDetailBaseCellDelegate,RadishProductDetailToolBarDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSArray<RadishProductDetailBaseCell *> *> *sections;
@property (nonatomic, strong) RadishProductDetailToolBar *toolBar;
@end

@implementation RadishProductDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
        [self setupTableView];
        [self setupToolBar];
    }
    return self;
}

- (void)setData:(RadishProductDetailData *)data {
    _data = data;
    self.toolBar.data = self.data;
    [self setupSections];
    [self.tableView reloadData];
}

#pragma mark - setupTableView

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-49) style:UITableViewStyleGrouped];
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
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailBaseCell" bundle:nil] forCellReuseIdentifier:BaseCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailBannerCell" bundle:nil] forCellReuseIdentifier:BannerCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailInfoCell" bundle:nil] forCellReuseIdentifier:InfoCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailDateCell" bundle:nil] forCellReuseIdentifier:DateCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailPlaceCell" bundle:nil] forCellReuseIdentifier:PlaceCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailPlaceCountCell" bundle:nil] forCellReuseIdentifier:PlaceCountCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailTitleCell" bundle:nil] forCellReuseIdentifier:TitleCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailBuyNoticeElementCell" bundle:nil] forCellReuseIdentifier:BuyNoticeElementCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailBuyNoticeEmptyCell" bundle:nil] forCellReuseIdentifier:BuyNoticeEmptyCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailJoinCell" bundle:nil] forCellReuseIdentifier:JoinCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailTwoColumnWebViewCell" bundle:nil] forCellReuseIdentifier:TwoColumnWebViewCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailTwoColumnConsultTipCell" bundle:nil] forCellReuseIdentifier:TwoColumnConsultTipCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailTwoColumnConsultEmptyCell" bundle:nil] forCellReuseIdentifier:TwoColumnConsultEmptyCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailTwoColumnConsultConsultCell" bundle:nil] forCellReuseIdentifier:TwoColumnConsultConsultCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishProductDetailTwoColumnConsultMoreCell" bundle:nil] forCellReuseIdentifier:TwoColumnConsultMoreCellID];
}

- (__kindof UITableViewCell *)cellWithID:(NSString *)cellID {
    return [self.tableView dequeueReusableCellWithIdentifier:cellID];
}

- (void)setupSections {
    
    NSMutableArray *sections  = [NSMutableArray array];
    
    NSMutableArray *section01 = [NSMutableArray array];
    
    if(section01.count>0) [sections addObject:section01];
    
    NSMutableArray *section02 = [NSMutableArray array];
    
    if(section02.count>0) [sections addObject:section02];

    NSMutableArray *section03 = [NSMutableArray array];

    if(section03.count>0) [sections addObject:section03];
    
    NSMutableArray *section04 = [NSMutableArray array];

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
    return (section == self.sections.count - 1)?38:10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section<self.sections.count) {
        NSArray<RadishProductDetailBaseCell *> *rows = self.sections[section];
        if (row<rows.count) {
            RadishProductDetailBaseCell *cell = rows[row];
            cell.delegate = self;
            cell.data = self.data;
            return cell;
        }
    }
    return [tableView dequeueReusableCellWithIdentifier:BaseCellID];
}

#pragma mark RadishProductDetailBaseCellDelegate

- (void)radishProductDetailBaseCell:(RadishProductDetailBaseCell *)cell actionType:(RadishProductDetailBaseCellActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(radishProductDetailView:actionType:value:)]) {
        [self.delegate radishProductDetailView:self actionType:(RadishProductDetailViewActionType)type value:value];
    }
    if (type == RadishProductDetailBaseCellActionTypeWebLoadFinish) {
        [self.tableView reloadData];
    }
}

#pragma mark - setupToolBar

- (void)setupToolBar {
    RadishProductDetailToolBar *toolBar = [[NSBundle mainBundle] loadNibNamed:@"RadishProductDetailToolBar" owner:self options:nil].firstObject;
    toolBar.hidden = YES;
    toolBar.delegate = self;
    toolBar.frame = CGRectMake(0, SCREEN_HEIGHT-64-kRadishProductDetailToolBarH, SCREEN_WIDTH, kRadishProductDetailToolBarH);
    [self addSubview:toolBar];
    self.toolBar = toolBar;
}

#pragma mark RadishProductDetailToolBarDelegate

- (void)RadishProductDetailToolBar:(RadishProductDetailToolBar *)toolBar actionType:(RadishProductDetailToolBarActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(radishProductDetailView:actionType:value:)]) {
        [self.delegate radishProductDetailView:self actionType:(RadishProductDetailViewActionType)type value:value];
    }
}

@end
