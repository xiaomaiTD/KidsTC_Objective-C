//
//  RadishOrderListView.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/5.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishProductOrderListView.h"
#import "Colours.h"
#import "RecommendDataManager.h"
#import "NSString+Category.h"

#import "RefreshHeader.h"
#import "RefreshFooter.h"
#import "KTCEmptyDataView.h"

#import "RadishProductOrderListBaseCell.h"
#import "RadishProductOrderListInfoCell.h"
#import "RadishProductOrderListTimeCell.h"
#import "RadishProductOrderListAddressCell.h"
#import "RadishProductOrderListBtnsCell.h"

#import "RadishProductOrderListHeader.h"
#import "RecommendProductOrderListView.h"

static NSString *const BaseCellID = @"RadishProductOrderListBaseCell";
static NSString *const InfoCellID = @"RadishProductOrderListInfoCell";
static NSString *const TimeCellID = @"RadishProductOrderListTimeCell";
static NSString *const AddressCellID = @"RadishProductOrderListAddressCell";
static NSString *const BtnsCellID = @"RadishProductOrderListBtnsCell";

@interface RadishProductOrderListView ()<RadishProductOrderListBaseCellDelegate,RecommendProductViewDelegate>
@property (nonatomic, strong) RecommendProductOrderListView *footerView;
@property (nonatomic, strong) NSArray<NSArray<RadishProductOrderListBaseCell *> *> *sections;
@end

@implementation RadishProductOrderListView

- (RecommendProductOrderListView *)footerView {
    if (!_footerView) {
        _footerView = [[NSBundle mainBundle] loadNibNamed:@"RecommendProductOrderListView" owner:self options:nil].firstObject;
        _footerView.delegate = self;
    }
    return _footerView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupTableView];
    }
    return self;
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 60;
    tableView.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
    [self addSubview:tableView];
    self.tableView = tableView;
    [tableView registerNib:[UINib nibWithNibName:@"RadishProductOrderListBaseCell" bundle:nil] forCellReuseIdentifier:BaseCellID];
    [tableView registerNib:[UINib nibWithNibName:@"RadishProductOrderListInfoCell" bundle:nil] forCellReuseIdentifier:InfoCellID];
    [tableView registerNib:[UINib nibWithNibName:@"RadishProductOrderListTimeCell" bundle:nil] forCellReuseIdentifier:TimeCellID];
    [tableView registerNib:[UINib nibWithNibName:@"RadishProductOrderListAddressCell" bundle:nil] forCellReuseIdentifier:AddressCellID];
    [tableView registerNib:[UINib nibWithNibName:@"RadishProductOrderListBtnsCell" bundle:nil] forCellReuseIdentifier:BtnsCellID];
    RadishProductOrderListHeader *header = [[NSBundle mainBundle] loadNibNamed:@"RadishProductOrderListHeader" owner:self options:nil].firstObject;
    header.frame = CGRectMake(0, 0, SCREEN_WIDTH, 28);
    header.hidden = YES;
    header.actionBlock = ^(){
        tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.001)];
    };
    tableView.tableHeaderView = header;
    
    [self resetFooterView];
    
    [self setupMJ];
}

- (void)resetFooterView {
    [self.footerView reloadData];
    self.footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [self.footerView contentHeight]);
    self.tableView.tableFooterView = self.footerView;
}

- (void)setupMJ {
    WeakSelf(self);
    RefreshHeader *header = [RefreshHeader headerWithRefreshingBlock:^{
        StrongSelf(self);
        self.noMoreOrderListData = NO;
        self.noMoreRecommendData = NO;
        [self.footerView nilData];
        [self resetFooterView];
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
    if ([self.delegate respondsToSelector:@selector(radishProductOrderListView:actionType:value:)]) {
        [self.delegate radishProductOrderListView:self actionType:RadishProductOrderListViewActionTypeLoadData value:@(refresh)];
    }
}

- (void)beginRefreshing {
    [self.tableView.mj_header beginRefreshing];
}

- (void)reloadData {
    [self.tableView reloadData];
}

- (void)dealWithUI:(NSUInteger)loadCount isRecommend:(BOOL)isRecommend {
    self.tableView.tableHeaderView.hidden = self.items.count<1;
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    if (!isRecommend) {
        if (loadCount<RadishProductOrderListPageCount) {
            self.noMoreOrderListData = YES;
        }
    }else{
        if (loadCount<RadishProductOrderListPageCount) {
            self.noMoreRecommendData = YES;
        }
    }
    
    [self resetFooterView];
    
    [self.tableView reloadData];
    
    if (self.noMoreRecommendData) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    if (self.items.count<1) {
        self.tableView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
                                                                          image:nil description:@"啥都没有啊…"
                                                                     needGoHome:NO];
    }else self.tableView.backgroundView = nil;
}

- (void)setItems:(NSArray<RadishProductOrderListItem *> *)items {
    _items = items;
    [self setupSections];
}

- (void)setupSections {
    NSMutableArray *sections = [NSMutableArray array];
    [self.items enumerateObjectsUsingBlock:^(RadishProductOrderListItem *obj, NSUInteger idx, BOOL *stop) {
        NSMutableArray *section = [NSMutableArray array];
        
        RadishProductOrderListInfoCell *infoCell = [self cellWithID:InfoCellID];
        if (infoCell) [section addObject:infoCell];
        
        if ([obj.useTimeStr isNotNull]) {
            RadishProductOrderListTimeCell *timeCell = [self cellWithID:TimeCellID];
            if (timeCell) [section addObject:timeCell];
        }
        
        if ([obj.storeName isNotNull] || [obj.storeAddress isNotNull]) {
            RadishProductOrderListAddressCell *addressCell = [self cellWithID:AddressCellID];
            if (addressCell) [section addObject:addressCell];
        }
        
        if (obj.btns.count>0) {
            RadishProductOrderListBtnsCell *btnsCell = [self cellWithID:BtnsCellID];
            if (btnsCell) [section addObject:btnsCell];
        }
        
        if (section.count>0) [sections addObject:section];
    }];
    self.sections = [NSArray arrayWithArray:sections];
}

- (__kindof UITableViewCell *)cellWithID:(NSString *)ID {
    return [self.tableView dequeueReusableCellWithIdentifier:ID];
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
        NSArray<RadishProductOrderListBaseCell *> *rows = self.sections[section];
        if (row<rows.count) {
            RadishProductOrderListBaseCell *cell = rows[row];
            cell.delegate = self;
            if (section<self.items.count) {
                cell.item = self.items[section];
            }
            return cell;
        }
    }
    return [self cellWithID:BaseCellID];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSInteger section = indexPath.section;
    if (section < self.items.count) {
        RadishProductOrderListItem *item = self.items[section];
        if ([self.delegate respondsToSelector:@selector(radishProductOrderListView:actionType:value:)]) {
            [self.delegate radishProductOrderListView:self actionType:RadishProductOrderListViewActionTypeSegue value:item.segueModel];
        }
    }
}

#pragma mark - RadishProductOrderListCellDelegate

- (void)radishProductOrderListBaseCell:(RadishProductOrderListBaseCell *)cell actionType:(RadishProductOrderListBaseCellActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(radishProductOrderListView:actionType:value:)]) {
        [self.delegate radishProductOrderListView:self actionType:(RadishProductOrderListViewActionType)type value:value];
    }
}

#pragma mark - RecommendProductViewDelegate

- (void)recommendProductView:(RecommendProductView *)view actionType:(RecommendProductViewActionType)type value:(id)value {
    switch (type) {
        case RecommendProductViewActionTypeSegue:
        {
            if ([self.delegate respondsToSelector:@selector(radishProductOrderListView:actionType:value:)]) {
                [self.delegate radishProductOrderListView:self actionType:RadishProductOrderListViewActionTypeSegue value:value];
            }
        }
            break;
        default:
            break;
    }
}

- (void)dealloc {
    TCLog(@"RadishProductOrderListView挂掉了...");
}

@end
