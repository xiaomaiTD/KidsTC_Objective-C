//
//  WolesaleProductDetailView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WolesaleProductDetailView.h"

#import "WolesaleProductDetailBaseCell.h"
#import "WolesaleProductDetailProgressCell.h"
#import "WolesaleProductDetailProductInfoCell.h"
#import "WolesaleProductDetailRuleTipCell.h"
#import "WolesaleProductDetailJoinTipCell.h"
#import "WolesaleProductDetailJoinCountDownCell.h"
#import "WolesaleProductDetailJoinTeamCell.h"
#import "WolesaleProductDetailJoinCountCell.h"
#import "WolesaleProductDetailTitleCell.h"
#import "WolesaleProductDetailTimeCell.h"
#import "WolesaleProductDetailAddressCell.h"
#import "WolesaleProductDetailWebCell.h"

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
static NSString *const TimeCellID = @"WolesaleProductDetailTimeCell";
static NSString *const AddressCellID = @"WolesaleProductDetailAddressCell";
static NSString *const WebCellID = @"WolesaleProductDetailWebCell";

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
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailTimeCell" bundle:nil] forCellReuseIdentifier:TimeCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailAddressCell" bundle:nil] forCellReuseIdentifier:AddressCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WolesaleProductDetailWebCell" bundle:nil] forCellReuseIdentifier:WebCellID];
}

- (__kindof UITableViewCell *)cellWithID:(NSString *)cellID {
    return [self.tableView dequeueReusableCellWithIdentifier:cellID];
}

- (void)setupSections {
    
    NSMutableArray *sections  = [NSMutableArray array];
    
    NSMutableArray *section01 = [NSMutableArray array];
    WolesaleProductDetailProgressCell *progressCell = [self cellWithID:ProgressCellID];
    if (progressCell) [section01 addObject:progressCell];
    WolesaleProductDetailProductInfoCell *productInfoCell = [self cellWithID:ProductInfoCellID];
    if (productInfoCell) [section01 addObject:productInfoCell];
    WolesaleProductDetailRuleTipCell *ruleTipCell = [self cellWithID:RuleTipCellID];
    if (ruleTipCell) [section01 addObject:ruleTipCell];
    WolesaleProductDetailJoinTipCell *joinTipCell = [self cellWithID:JoinTipCellID];
    if (joinTipCell) [section01 addObject:joinTipCell];
    WolesaleProductDetailJoinCountDownCell *joinCountDownCell = [self cellWithID:JoinCountDownCellID];
    if (joinCountDownCell) [section01 addObject:joinCountDownCell];
    
    WolesaleProductDetailJoinTeamCell *joinTeamCell = [self cellWithID:JoinTeamCellID];
    if (joinTeamCell) [section01 addObject:joinTeamCell];
    WolesaleProductDetailJoinTeamCell *joinTeamCell01 = [self cellWithID:JoinTeamCellID];
    if (joinTeamCell01) [section01 addObject:joinTeamCell01];
    WolesaleProductDetailJoinTeamCell *joinTeamCell02 = [self cellWithID:JoinTeamCellID];
    if (joinTeamCell02) [section01 addObject:joinTeamCell02];
    WolesaleProductDetailJoinTeamCell *joinTeamCell03 = [self cellWithID:JoinTeamCellID];
    if (joinTeamCell03) [section01 addObject:joinTeamCell03];
    
    WolesaleProductDetailJoinCountCell *joinCountCell = [self cellWithID:JoinCountCellID];
    if (joinCountCell) [section01 addObject:joinCountCell];
    if(section01.count>0) [sections addObject:section01];
    
    NSMutableArray *section02 = [NSMutableArray array];
    WolesaleProductDetailTitleCell *titleCell = [self cellWithID:TitleCellID];
    if (titleCell) [section02 addObject:titleCell];
    WolesaleProductDetailTimeCell *timeCell = [self cellWithID:TimeCellID];
    if (timeCell) [section02 addObject:timeCell];
    WolesaleProductDetailAddressCell *addressCell = [self cellWithID:AddressCellID];
    if (addressCell) [section02 addObject:addressCell];
    WolesaleProductDetailWebCell *webCell = [self cellWithID:WebCellID];
    if (webCell) [section02 addObject:webCell];
    if(section02.count>0) [sections addObject:section02];
    
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
            return cell;
        }
    }
    return [tableView dequeueReusableCellWithIdentifier:BaseCellID];
}

#pragma mark - setupToolBar

- (void)setupToolBar {
    WolesaleProductDetailToolBar *toolBar = [[NSBundle mainBundle] loadNibNamed:@"WolesaleProductDetailToolBar" owner:self options:nil].firstObject;
    toolBar.frame = CGRectMake(0, SCREEN_HEIGHT-64-kWolesaleProductDetailToolBarH, SCREEN_WIDTH, kWolesaleProductDetailToolBarH);
    [self addSubview:toolBar];
    self.toolBar = toolBar;
}


@end
