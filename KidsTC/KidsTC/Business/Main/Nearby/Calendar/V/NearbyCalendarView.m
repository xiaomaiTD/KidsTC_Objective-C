//
//  NearbyCalendarView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyCalendarView.h"
#import "Colours.h"
#import "RefreshHeader.h"
#import "RefreshFooter.h"
#import "KTCEmptyDataView.h"

#import "NearbyCalendarToolBar.h"
#import "NearbyCalendarToolBarDateView.h"
#import "NearbyCalendarToolBarCategoryView.h"
#import "NearbyTableViewCell.h"


static NSString *const CellID = @"NearbyTableViewCell";
@interface NearbyCalendarView ()<NearbyCalendarToolBarDelegate,UITableViewDelegate,UITableViewDataSource,NearbyTableViewCellDelegate>
@property (strong, nonatomic) NearbyCalendarToolBar *toolBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation NearbyCalendarView

@synthesize data = _data;

- (NearbyData *)data {
    if (!_data) {
        _data = [NearbyData new];
    }
    return _data;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 272;
    self.tableView.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NearbyTableViewCell" bundle:nil] forCellReuseIdentifier:CellID];
    [self setupMJ];
    
    NearbyCalendarToolBar *toolBar = [[NSBundle mainBundle] loadNibNamed:@"NearbyCalendarToolBar" owner:self options:nil].firstObject;
    toolBar.delegate = self;
    [self addSubview:toolBar];
    self.toolBar = toolBar;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _toolBar.frame = CGRectMake(0, 64, SCREEN_WIDTH, kNearbyCalendarToolBarH);
    });
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void)setData:(NearbyData *)data {
    _data = data;
    if (_data.data.count<1) {
        [self.tableView.mj_header beginRefreshing];
    }
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
    if ([self.delegate respondsToSelector:@selector(nearbyCalendarView:actionType:value:)]) {
        [self.delegate nearbyCalendarView:self actionType:NearbyCalendarViewActionTypeLoadData value:@(refresh)];
    }
}

- (void)dealWithUI:(NSUInteger)loadCount {
    if (self.data.data.count>0) {
        self.tableView.tableHeaderView.hidden = NO;
    }
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    if (loadCount<1) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    if (self.data.data.count<1) {
        self.tableView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
                                                                          image:nil description:@"啥都没有啊…"
                                                                     needGoHome:NO];
    }else self.tableView.backgroundView = nil;
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
    return 0.001;
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
        if ([self.delegate respondsToSelector:@selector(nearbyCalendarView:actionType:value:)]) {
            [self.delegate nearbyCalendarView:self actionType:NearbyCalendarViewActionTypeSegue value:item.segueModel];
        }
    }
}

#pragma mark - NearbyTableViewCellDelegate

- (void)nearbyTableViewCell:(NearbyTableViewCell *)cell actionType:(NearbyTableViewCellActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(nearbyCalendarView:actionType:value:)]) {
        [self.delegate nearbyCalendarView:self actionType:(NearbyCalendarViewActionType)type value:value];
    }
}

#pragma mark - NearbyCalendarToolBarDelegate

- (void)nearbyCalendarToolBar:(NearbyCalendarToolBar *)toolBar actionType:(NearbyCalendarToolBarActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(nearbyCalendarView:actionType:value:)]) {
        [self.delegate nearbyCalendarView:self actionType:(NearbyCalendarViewActionType)type value:value];
    }
}


@end
