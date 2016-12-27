//
//  WholesaleOrderDetailView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleOrderDetailView.h"

#import "WholesaleOrderDetailBaseCell.h"
#import "WholesaleOrderDetailFailureCell.h"
#import "WholesaleOrderDetailSuccessCell.h"
#import "WholesaleOrderDetailProductInfoCell.h"
#import "WholesaleOrderDetailJoinTipCell.h"
#import "WholesaleOrderDetailJoinMemberCell.h"
#import "WholesaleOrderDetailRuleCell.h"
#import "WholesaleOrderDetailProgressCell.h"
#import "WholesaleOrderDetailWebCell.h"

#import "WholesaleOrderDetailToolBar.h"

static NSString *const BaseCellID = @"WholesaleOrderDetailBaseCell";
static NSString *const FailureCellID = @"WholesaleOrderDetailFailureCell";
static NSString *const SuccessCellID = @"WholesaleOrderDetailSuccessCell";
static NSString *const ProductInfoCellID = @"WholesaleOrderDetailProductInfoCell";
static NSString *const JoinTipCellID = @"WholesaleOrderDetailJoinTipCell";
static NSString *const JoinMemberCellID = @"WholesaleOrderDetailJoinMemberCell";
static NSString *const RuleCellID = @"WholesaleOrderDetailRuleCell";
static NSString *const ProgressCellID = @"WholesaleOrderDetailProgressCell";
static NSString *const WebCellID = @"WholesaleOrderDetailWebCell";

@interface WholesaleOrderDetailView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSArray<WholesaleOrderDetailBaseCell *> *> *sections;

@property (nonatomic, strong) WholesaleOrderDetailToolBar *toolBar;
@end

@implementation WholesaleOrderDetailView

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
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-kWholesaleOrderDetailToolBarH) style:UITableViewStyleGrouped];
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
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleOrderDetailBaseCell" bundle:nil] forCellReuseIdentifier:BaseCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleOrderDetailFailureCell" bundle:nil] forCellReuseIdentifier:FailureCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleOrderDetailSuccessCell" bundle:nil] forCellReuseIdentifier:SuccessCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleOrderDetailProductInfoCell" bundle:nil] forCellReuseIdentifier:ProductInfoCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleOrderDetailJoinTipCell" bundle:nil] forCellReuseIdentifier:JoinTipCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleOrderDetailJoinMemberCell" bundle:nil] forCellReuseIdentifier:JoinMemberCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleOrderDetailRuleCell" bundle:nil] forCellReuseIdentifier:RuleCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleOrderDetailProgressCell" bundle:nil] forCellReuseIdentifier:ProgressCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"WholesaleOrderDetailWebCell" bundle:nil] forCellReuseIdentifier:WebCellID];
}

- (__kindof UITableViewCell *)cellWithID:(NSString *)cellID {
    return [self.tableView dequeueReusableCellWithIdentifier:cellID];
}

- (void)setupSections {
    
    NSMutableArray *sections  = [NSMutableArray array];
    
    NSMutableArray *section01 = [NSMutableArray array];
    WholesaleOrderDetailSuccessCell *successCell = [self cellWithID:SuccessCellID];
    if (successCell) [section01 addObject:successCell];
    WholesaleOrderDetailProductInfoCell *productInfoCell = [self cellWithID:ProductInfoCellID];
    if (productInfoCell) [section01 addObject:productInfoCell];
    WholesaleOrderDetailJoinTipCell *joinTipCell = [self cellWithID:JoinTipCellID];
    if (joinTipCell) [section01 addObject:joinTipCell];
    WholesaleOrderDetailJoinMemberCell *joinMemberCell01 = [self cellWithID:JoinMemberCellID];
    if (joinMemberCell01) [section01 addObject:joinMemberCell01];
    WholesaleOrderDetailJoinMemberCell *joinMemberCell02 = [self cellWithID:JoinMemberCellID];
    if (joinMemberCell02) [section01 addObject:joinMemberCell02];
    WholesaleOrderDetailJoinMemberCell *joinMemberCell03 = [self cellWithID:JoinMemberCellID];
    if (joinMemberCell03) [section01 addObject:joinMemberCell03];
    WholesaleOrderDetailJoinMemberCell *joinMemberCell04 = [self cellWithID:JoinMemberCellID];
    if (joinMemberCell04) [section01 addObject:joinMemberCell04];
    if(section01.count>0) [sections addObject:section01];
    
    NSMutableArray *section02 = [NSMutableArray array];
    WholesaleOrderDetailRuleCell *ruleCell = [self cellWithID:RuleCellID];
    if (ruleCell) [section02 addObject:ruleCell];
    WholesaleOrderDetailProgressCell *progressCell = [self cellWithID:ProgressCellID];
    if (progressCell) [section02 addObject:progressCell];
    WholesaleOrderDetailWebCell *webCell = [self cellWithID:WebCellID];
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
        NSArray<WholesaleOrderDetailBaseCell *> *rows = self.sections[section];
        if (row<rows.count) {
            WholesaleOrderDetailBaseCell *cell = rows[row];
            return cell;
        }
    }
    return [tableView dequeueReusableCellWithIdentifier:BaseCellID];
}

#pragma mark - setupToolBar

- (void)setupToolBar {
    WholesaleOrderDetailToolBar *toolBar = [[NSBundle mainBundle] loadNibNamed:@"WholesaleOrderDetailToolBar" owner:self options:nil].firstObject;
    toolBar.frame = CGRectMake(0, SCREEN_HEIGHT-64-kWholesaleOrderDetailToolBarH, SCREEN_WIDTH, kWholesaleOrderDetailToolBarH);
    [self addSubview:toolBar];
    self.toolBar = toolBar;
}

@end
