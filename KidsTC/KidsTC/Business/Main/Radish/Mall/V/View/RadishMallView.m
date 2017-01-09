//
//  RadishMallView.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/5.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishMallView.h"
#import "RefreshHeader.h"
#import "RefreshFooter.h"

#import "RadishMallBaseCell.h"
#import "RadishMallPlantCell.h"
#import "RadishMallItemsCell.h"
#import "RadishMallBannerCell.h"
#import "RadishMallLargeCell.h"
#import "RadishMallHotTipCell.h"
#import "RadishMallSmallCell.h"

static NSString *const BaseCellID = @"RadishMallBaseCell";
static NSString *const PlantCellID = @"RadishMallPlantCell";
static NSString *const ItemsCellID = @"RadishMallItemsCell";
static NSString *const BannerCellID = @"RadishMallBannerCell";
static NSString *const LargeCellID = @"RadishMallLargeCell";
static NSString *const HotTipCellID = @"RadishMallHotTipCell";
static NSString *const SmallCellID = @"RadishMallSmallCell";

@interface RadishMallView ()<UITableViewDelegate,UITableViewDataSource,RadishMallBaseCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSArray<RadishMallBaseCell *> *> *sections;
@end

@implementation RadishMallView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
        [self setupTableView];
    }
    return self;
}

- (void)setData:(RadishMallData *)data {
    _data = data;
    [self setupSections];
    [self.tableView reloadData];
}

- (void)reloadData {
    [self.tableView reloadData];
}

#pragma mark - setupTableView

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
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

- (void)setupMJ {
    WeakSelf(self);
    RefreshHeader *header = [RefreshHeader headerWithRefreshingBlock:^{
        StrongSelf(self);
        [self loadData:YES];
    }];
    self.tableView.mj_header = header;
    RefreshFooter *footer = [RefreshFooter footerWithRefreshingBlock:^{
        StrongSelf(self);
        [self loadData:NO];
    }];
    self.tableView.mj_footer = footer;
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadData:(BOOL)refresh {
    if ([self.delegate respondsToSelector:@selector(radishMallView:actionType:value:)]) {
        [self.delegate radishMallView:self actionType:RadishMallViewActionTypeLoadData value:@(refresh)];
    }
}

- (void)registerCells {
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishMallBaseCell" bundle:nil] forCellReuseIdentifier:BaseCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishMallPlantCell" bundle:nil] forCellReuseIdentifier:PlantCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishMallItemsCell" bundle:nil] forCellReuseIdentifier:ItemsCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishMallBannerCell" bundle:nil] forCellReuseIdentifier:BannerCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishMallLargeCell" bundle:nil] forCellReuseIdentifier:LargeCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishMallHotTipCell" bundle:nil] forCellReuseIdentifier:HotTipCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishMallSmallCell" bundle:nil] forCellReuseIdentifier:SmallCellID];
}

- (__kindof UITableViewCell *)cellWithID:(NSString *)cellID {
    return [self.tableView dequeueReusableCellWithIdentifier:cellID];
}

- (void)setupSections {
    
    NSMutableArray *sections  = [NSMutableArray array];
    
    NSMutableArray *section01 = [NSMutableArray array];
    RadishMallPlantCell *plantCell = [self cellWithID:PlantCellID];
    if (plantCell) [section01 addObject:plantCell];
    RadishMallItemsCell *itemsCell = [self cellWithID:ItemsCellID];
    if (itemsCell) [section01 addObject:itemsCell];
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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section<self.sections.count) {
        NSArray<RadishMallBaseCell *> *rows = self.sections[section];
        if (row<rows.count) {
            RadishMallBaseCell *cell = rows[row];
            cell.delegate = self;
            
            return cell;
        }
    }
    return [tableView dequeueReusableCellWithIdentifier:BaseCellID];
}

#pragma mark RadishMallBaseCellDelegate

- (void)radishMallBaseCell:(RadishMallBaseCell *)cell actionType:(RadishMallBaseCellActionType)type value:(id)value {
    
}

@end
