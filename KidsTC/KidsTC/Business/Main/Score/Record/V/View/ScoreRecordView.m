//
//  ScoreRecordView.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/24.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreRecordView.h"
#import "RefreshHeader.h"
#import "RefreshFooter.h"
#import "KTCEmptyDataView.h"
#import "ScoreRecordDetailCell.h"

static NSString *const DetailCellID = @"ScoreRecordDetailCell";

@interface ScoreRecordView ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ScoreRecordView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.tableView.estimatedRowHeight = 80;
    WeakSelf(self)
    RefreshHeader *mj_header = [RefreshHeader headerWithRefreshingBlock:^{
        StrongSelf(self)
        [self getDataRefresh:YES];
    }];
    mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_header = mj_header;
    
    RefreshFooter *mj_footer = [RefreshFooter footerWithRefreshingBlock:^{
        StrongSelf(self)
        [self getDataRefresh:NO];
    }];
    self.tableView.mj_footer = mj_footer;
    
    [mj_header beginRefreshing];
    
    [self registerCells];
}

- (void)getDataRefresh:(BOOL)refresh {
    if ([self.delegate respondsToSelector:@selector(scoreRecordView:actionType:value:)]) {
        [self.delegate scoreRecordView:self actionType:ScoreRecordViewActionTypeLoadData value:@(refresh)];
    }
}

- (void)dealWithUI:(NSUInteger)loadCount {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    if (loadCount<1) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    if (self.records.count<1) {
        self.tableView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
                                                                          image:nil description:@"啥都没有啊…"
                                                                     needGoHome:NO];
    }else self.tableView.backgroundView = nil;
    [self.tableView reloadData];
}

- (void)registerCells {
    [self.tableView registerNib:[UINib nibWithNibName:@"ScoreRecordDetailCell" bundle:nil] forCellReuseIdentifier:DetailCellID];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.records.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScoreRecordDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:DetailCellID];
    NSUInteger row = indexPath.row;
    if (row<self.records.count) {
        ScoreRecordItem *record = self.records[row];
        cell.record = record;
    }
    return cell;
}

@end
