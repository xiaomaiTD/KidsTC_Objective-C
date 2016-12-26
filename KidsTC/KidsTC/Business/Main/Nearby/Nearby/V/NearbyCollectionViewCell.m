//
//  NearbyCollectionViewCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyCollectionViewCell.h"
#import "Colours.h"
#import "RefreshHeader.h"
#import "RefreshFooter.h"
#import "KTCEmptyDataView.h"

#import "NearbyTableViewHeader.h"
#import "NearbyTableViewCell.h"


static NSString *const CellID = @"NearbyTableViewCell";

@interface NearbyCollectionViewCell ()<UITableViewDelegate,UITableViewDataSource,NearbyTableViewHeaderDelegate,NearbyTableViewCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NearbyTableViewHeader *header;
@end

@implementation NearbyCollectionViewCell

- (NearbyTableViewHeader *)header {
    if (!_header) {
        _header = [[NSBundle mainBundle] loadNibNamed:@"NearbyTableViewHeader" owner:self options:nil].firstObject;
        _header.delegate = self;
        _header.frame = CGRectMake(0, 0, SCREEN_WIDTH, kNearbyTableViewHeaderH);
    }
    return _header;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setupTableView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //self.tableView.frame = self.bounds;
}

- (void)setData:(NearbyData *)data {
    _data = data;
    if (_data.data.count<1) {
        [self.tableView.mj_header beginRefreshing];
    }
    [self setupHeader];
    [self.tableView reloadData];
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64-MultiItemsToolBarScrollViewHeight-49) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 272;
    tableView.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
    [tableView registerNib:[UINib nibWithNibName:@"NearbyTableViewCell" bundle:nil] forCellReuseIdentifier:CellID];
    [self addSubview:tableView];
    self.tableView = tableView;
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
    //[self.tableView.mj_header beginRefreshing];
}

- (void)loadData:(BOOL)refresh {
    if ([self.delegate respondsToSelector:@selector(nearbyCollectionViewCell:actionType:value:)]) {
        [self.delegate nearbyCollectionViewCell:self actionType:NearbyCollectionViewCellActionTypeLoadData value:@(refresh)];
    }
}

- (void)dealWithUI:(NSUInteger)loadCount {
    [self setupHeader];
    if (self.data.data.count>0) {
        self.tableView.tableHeaderView.hidden = NO;
    }
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    if (loadCount<TCPAGECOUNT) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    if (self.data.data.count<1) {
        self.tableView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
                                                                          image:nil description:@"超出服务范围啦~"
                                                                     needGoHome:NO];
    }else self.tableView.backgroundView = nil;
}

- (void)setupHeader {
    NearbyPlaceInfo *placeInfo = _data.placeInfo;
    if ((_index == 0) && placeInfo.isShow && (placeInfo.leftData || placeInfo.rightData)) {
        self.tableView.tableHeaderView = self.header;
        self.header.placeInfo = placeInfo;
    }else {
        self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.001)];
    }
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return (section == self.data.data.count - 1)?10:0.001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NearbyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    NSInteger section = indexPath.section;
    if (section<self.data.data.count) {
        NearbyItem *item = self.data.data[section];
        cell.item = item;
        cell.delegate = self;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    if (section<self.data.data.count) {
        NearbyItem *item = self.data.data[section];
        if ([self.delegate respondsToSelector:@selector(nearbyCollectionViewCell:actionType:value:)]) {
            [self.delegate nearbyCollectionViewCell:self actionType:NearbyCollectionViewCellActionTypeSegue value:item.segueModel];
        }
    }
}

#pragma mark - NearbyTableViewCellDelegate

- (void)nearbyTableViewCell:(NearbyTableViewCell *)cell actionType:(NearbyTableViewCellActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(nearbyCollectionViewCell:actionType:value:)]) {
        [self.delegate nearbyCollectionViewCell:self actionType:(NearbyCollectionViewCellActionType)type value:value];
    }
}

#pragma mark - NearbyTableViewHeaderDelegate

- (void)nearbyTableViewHeader:(NearbyTableViewHeader *)header actionType:(NurseryType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(nearbyCollectionViewCell:actionType:value:)]) {
        [self.delegate nearbyCollectionViewCell:self actionType:(NearbyCollectionViewCellActionType)type value:value];
    }
}

@end
