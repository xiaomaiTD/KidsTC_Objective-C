//
//  ProductOrderFreeListView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/5.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderFreeListView.h"

#import "Colours.h"

#import "RefreshHeader.h"
#import "RefreshFooter.h"
#import "KTCEmptyDataView.h"
#import "ProductOrderFreeListHeader.h"
#import "ProductOrderFreeListCell.h"

static NSString *const CellID = @"ProductOrderFreeListCell";

@interface ProductOrderFreeListView ()<ProductOrderFreeListCellDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ProductOrderFreeListView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupTableView];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
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
    [tableView registerNib:[UINib nibWithNibName:@"ProductOrderFreeListCell" bundle:nil] forCellReuseIdentifier:CellID];
    ProductOrderFreeListHeader *header = [[NSBundle mainBundle] loadNibNamed:@"ProductOrderListHeader" owner:self options:nil].firstObject;
    header.frame = CGRectMake(0, 0, SCREEN_WIDTH, 28);
    header.hidden = YES;
    header.actionBlock = ^(){
        tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.001)];
    };
    tableView.tableHeaderView = header;
    
    [self setupMJ];
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
    if ([self.delegate respondsToSelector:@selector(productOrderFreeListView:actionType:value:)]) {
        [self.delegate productOrderFreeListView:self actionType:ProductOrderFreeListViewActionTypeLoadData value:@(refresh)];
    }
}

- (void)reloadData {
    [self.tableView reloadData];
}

- (void)beginRefreshing {
    [self.tableView.mj_header beginRefreshing];
}

- (void)dealWithUI:(NSUInteger)loadCount {
    if (self.items.count>0) {
        self.tableView.tableHeaderView.hidden = NO;
    }
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    if (loadCount<ProductOrderFreeListPageCount) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    if (self.items.count<1) {
        self.tableView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
                                                                          image:nil description:@"啥都没有啊…"
                                                                     needGoHome:NO];
    }else self.tableView.backgroundView = nil;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductOrderFreeListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"ProductOrderFreeListCell" owner:self options:nil].firstObject;
    }
    NSInteger section = indexPath.section;
    if (section < self.items.count) {
        cell.item = self.items[section];
        cell.delegate = self;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSInteger section = indexPath.section;
    if (section < self.items.count) {
        ProductOrderFreeListItem *item = self.items[section];
        if ([self.delegate respondsToSelector:@selector(productOrderFreeListView:actionType:value:)]) {
            [self.delegate productOrderFreeListView:self actionType:ProductOrderFreeListViewActionTypeSegue value:item.segueModel];
        }
    }
    
}

#pragma mark - ProductOrderFreeListCellDelegate

- (void)productOrderFreeListCell:(ProductOrderFreeListCell *)cell actionType:(ProductOrderFreeListCellActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(productOrderFreeListView:actionType:value:)]) {
        [self.delegate productOrderFreeListView:self actionType:(ProductOrderFreeListViewActionType)type value:value];
    }
}

@end
