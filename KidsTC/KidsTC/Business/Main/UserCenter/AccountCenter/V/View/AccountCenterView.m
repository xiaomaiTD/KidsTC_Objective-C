//
//  AccountCenterView.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/8.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "AccountCenterView.h"
#import "RefreshHeader.h"
#import "RefreshFooter.h"
#import "Colours.h"

#import "AccountCenterHeader.h"
#import "AccountCenterBaseCell.h"
#import "AccountCenterCollectionsCell.h"
#import "AccountCenterOrdersCell.h"
#import "AccountCenterNumsCell.h"
#import "AccountCenterActivitiesCell.h"
#import "AccountCenterItemsCell.h"
#import "AccountCenterBannersCell.h"
#import "AccountCenterRecommendsCell.h"

static NSString *const ID = @"UITableViewCell";

@interface AccountCenterView ()<UITableViewDelegate,UITableViewDataSource,AccountCenterHeaderDelegate,AccountCenterBaseCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AccountCenterHeader *header;
@property (nonatomic, strong) NSArray<NSArray<AccountCenterBaseCell *> *> *sections;

@property (nonatomic, strong) AccountCenterCollectionsCell *collectionsCell;
@property (nonatomic, strong) AccountCenterOrdersCell *ordersCell;
@property (nonatomic, strong) AccountCenterNumsCell *numsCell;
@property (nonatomic, strong) AccountCenterActivitiesCell *activitiesCell;
@property (nonatomic, strong) AccountCenterItemsCell *itemsCell;
@property (nonatomic, strong) AccountCenterBannersCell *bannersCell;
@property (nonatomic, strong) AccountCenterRecommendsCell *recommendsCell;
@end

@implementation AccountCenterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.estimatedRowHeight = 60;
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
        tableView.scrollIndicatorInsets = tableView.contentInset;
        tableView.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
        [self addSubview:tableView];
        self.tableView = tableView;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
        
        WeakSelf(self)
        
        RefreshHeader *header = [RefreshHeader headerWithRefreshingBlock:^{
            StrongSelf(self)
            [self loadData:YES];
        }];
        tableView.mj_header = header;
        
        RefreshFooter *footer = [RefreshFooter footerWithRefreshingBlock:^{
            StrongSelf(self)
            [self loadData:NO];
        }];
        tableView.mj_footer = footer;
        footer.automaticallyRefresh = YES;
    }
    return self;
}

- (void)setModel:(AccountCenterModel *)model {
    _model = model;
    self.header.model = model;
    [self setupMainSections];
    [self.tableView reloadData];
}

- (void)dealWithUI:(NSUInteger)loadCount {
    [self setupMainSections];
    [self.recommendsCell reloadRecommends];
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    if (loadCount<TCPAGECOUNT) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
}

- (void)loadData:(BOOL)refresh {
    if ([self.delegate respondsToSelector:@selector(accountCenterView:actionType:value:)]) {
        [self.delegate accountCenterView:self actionType:AccountCenterViewActionTypeLoadData value:@(refresh)];
    }
}

- (id)viewWithNib:(NSString *)nib {
    return [[NSBundle mainBundle] loadNibNamed:nib owner:self options:nil].firstObject;
}

- (AccountCenterHeader *)header{
    if (!_header) {
        _header = [self viewWithNib:@"AccountCenterHeader"];
        _header.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
        _header.delegate = self;
        self.tableView.tableHeaderView = _header;
    }
    return _header;
}

- (AccountCenterCollectionsCell *)collectonsCell {
    if (!_collectionsCell)
    {
        _collectionsCell = [self viewWithNib:@"AccountCenterCollectionsCell"];
    }
    return _collectionsCell;
}

- (AccountCenterOrdersCell *)ordersCell {
    if (!_ordersCell)
    {
        _ordersCell = [self viewWithNib:@"AccountCenterOrdersCell"];
    }
    return _ordersCell;
}

- (AccountCenterNumsCell *)numsCell {
    if (!_numsCell)
    {
        _numsCell = [self viewWithNib:@"AccountCenterNumsCell"];
    }
    return _numsCell;
}

- (AccountCenterActivitiesCell *)activitiesCell {
    if (!_activitiesCell)
    {
        _activitiesCell = [self viewWithNib:@"AccountCenterActivitiesCell"];
    }
    return _activitiesCell;
}

- (AccountCenterItemsCell *)itemsCell {
    if (!_itemsCell)
    {
        _itemsCell = [self viewWithNib:@"AccountCenterItemsCell"];
    }
    return _itemsCell;
}

- (AccountCenterBannersCell *)bannersCell {
    if (!_bannersCell)
    {
        _bannersCell = [self viewWithNib:@"AccountCenterBannersCell"];
    }
    return _bannersCell;
}

- (AccountCenterRecommendsCell *)recommendsCell {
    if (!_recommendsCell)
    {
        _recommendsCell = [self viewWithNib:@"AccountCenterRecommendsCell"];
    }
    return _recommendsCell;
}

- (void)setupMainSections {
    
    AccountCenterData *data = self.model.data;
    
    NSMutableArray *sections = [NSMutableArray array];
    
    NSMutableArray *section00 = [NSMutableArray array];
    [section00 addObject:self.collectonsCell];
    if (section00.count>0) {
        [sections addObject:section00];
    }
    
    NSMutableArray *section01 = [NSMutableArray array];
    [section01 addObject:self.ordersCell];
    if (section01.count>0) {
        [sections addObject:section01];
    }
    
    NSMutableArray *section02 = [NSMutableArray array];
    [section02 addObject:self.numsCell];
    if (section02.count>0) {
        [sections addObject:section02];
    }
    
    NSMutableArray *section03 = [NSMutableArray array];
    if (data.config.activityExhibitionHall.count>0) {
        [section03 addObject:self.activitiesCell];
    }
    if (section03.count>0) {
        [sections addObject:section03];
    }
    
    NSMutableArray *section04 = [NSMutableArray array];
    [section04 addObject:self.itemsCell];
    if (section04.count>0) {
        [sections addObject:section04];
    }
    
    NSMutableArray *section05 = [NSMutableArray array];
    if (data.config.banners.count>0) {
        [section05 addObject:self.bannersCell];
    }
    if (section05.count>0) {
        [sections addObject:section05];
    }
    
    NSMutableArray *section07 = [NSMutableArray array];
    [section07 addObject:self.recommendsCell];
    if (section07.count>0) {
        [sections addObject:section07];
    }
    
    self.sections = [NSMutableArray arrayWithArray:sections];
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
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section<self.sections.count) {
        NSArray<AccountCenterBaseCell *> *rows = self.sections[section];
        if (row<rows.count) {
            AccountCenterBaseCell *cell = rows[row];
            cell.delegate =  self;
            cell.model = self.model;
            return cell;
        }
    }
    return [tableView dequeueReusableCellWithIdentifier:ID];
}

#pragma mark - AccountCenterHeaderDelegate

- (void)accountCenterHeader:(AccountCenterHeader *)header actionType:(AccountCenterHeaderActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(accountCenterView:actionType:value:)]) {
        [self.delegate accountCenterView:self actionType:(AccountCenterViewActionType)type value:value];
    }
}

#pragma mark - AccountCenterBaseCellDelegate

- (void)accountCenterBaseCell:(AccountCenterBaseCell *)cell actionType:(AccountCenterCellActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(accountCenterView:actionType:value:)]) {
        [self.delegate accountCenterView:self actionType:(AccountCenterViewActionType)type value:value];
    }
}




@end
