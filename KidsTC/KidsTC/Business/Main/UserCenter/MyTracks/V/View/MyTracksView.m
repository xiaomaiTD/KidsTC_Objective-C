//
//  MyTracksView.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "MyTracksView.h"
#import "RefreshHeader.h"
#import "RefreshFooter.h"

#import "MyTracksHeader.h"
#import "MyTracksCell.h"
#import "MyTracksFooter.h"

static NSString *const HeadID = @"MyTracksHeader";
static NSString *const CellID = @"MyTracksCell";
static NSString *const FootID = @"MyTracksFooter";

@interface MyTracksView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MyTracksView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupTableView];
    }
    return self;
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 60;
    tableView.estimatedSectionHeaderHeight = 40;
    tableView.estimatedSectionFooterHeight = 40;
    [self addSubview:tableView];
    self.tableView = tableView;
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    tableView.tableHeaderView = header;
    
    [tableView registerNib:[UINib nibWithNibName:@"MyTracksHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:HeadID];
    [tableView registerNib:[UINib nibWithNibName:@"MyTracksCell" bundle:nil] forCellReuseIdentifier:CellID];
    [tableView registerNib:[UINib nibWithNibName:@"MyTracksFooter" bundle:nil] forHeaderFooterViewReuseIdentifier:FootID];
    
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
}

- (void)loadData:(BOOL)refresh {
    if ([self.delegate respondsToSelector:@selector(myTracksView:actionType:value:)]) {
        [self.delegate myTracksView:self actionType:MyTracksViewActionTypeLoadData value:@(refresh)];
    }
}

- (void)endRefresh:(BOOL)noMoreData {
    [self.tableView.mj_header endRefreshing];
    if (noMoreData) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.tableView.mj_footer endRefreshing];
    }
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyTracksCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MyTracksHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeadID];
    
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    MyTracksFooter *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:FootID];
    
    return footer;
}

@end
