//
//  ActivityView.m
//  KidsTC
//
//  Created by 钱烨 on 10/8/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "ActivityView.h"
//#import "HorizontalCalendarView.h"
#import "ActivityViewCell.h"
#import "KTCEmptyDataView.h"
#import "ToolBox.h"
#import "RefreshHeader.h"
#import "RefreshFooter.h"

static NSString *const kCellIdentifier = @"kCellIdentifier";

@interface ActivityView () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UINib *cellNib;

@property (nonatomic, strong) NSArray *listModels;

@property (nonatomic, assign) BOOL noMoreData;

- (void)pullDownToRefresh;

- (void)pullUpToLoadMore;

@end

@implementation ActivityView

#pragma mark Initialization


- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    self = [super awakeAfterUsingCoder:aDecoder];
    static BOOL bLoad;
    if (!bLoad)
    {
        bLoad = YES;
        ActivityView *view = [ToolBox getObjectFromNibWithView:self];
        [view buildSubviews];
        return view;
    }
    bLoad = NO;
    return self;
}

- (void)buildSubviews {
    self.tableView.backgroundView = nil;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 5)];
    if (!self.cellNib) {
        self.cellNib = [UINib nibWithNibName:NSStringFromClass([ActivityViewCell class]) bundle:nil];
        [self.tableView registerNib:self.cellNib forCellReuseIdentifier:kCellIdentifier];
    }
    
    WeakSelf(self)
    RefreshHeader *mj_header = [RefreshHeader headerWithRefreshingBlock:^{
        StrongSelf(self)
        [self pullDownToRefresh];
    }];
    mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_header = mj_header;
    
    RefreshFooter *mj_footer = [RefreshFooter footerWithRefreshingBlock:^{
        StrongSelf(self)
        if (self.noMoreData) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
        [self pullUpToLoadMore];
    }];
    mj_footer.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer = mj_footer;
}

#pragma mark UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.listModels count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ActivityViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell =  [[[NSBundle mainBundle] loadNibNamed:@"ActivityViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    [cell configWithItemModel:[self.listModels objectAtIndex:indexPath.section]];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ActivityListItemModel *model = [self.listModels objectAtIndex:indexPath.section];
    return [model cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 2.5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 2.5;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(activityView:didSelectedItemAtIndex:)]) {
        [self.delegate activityView:self didSelectedItemAtIndex:indexPath.section];
    }
}

#pragma mark Private methods

- (void)pullDownToRefresh {
    self.tableView.backgroundView = nil;
    if (self.delegate && [self.delegate respondsToSelector:@selector(didPullDownToRefreshForActivityView:)]) {
        [self.delegate didPullDownToRefreshForActivityView:self];
    }
}

- (void)pullUpToLoadMore {
    self.tableView.backgroundView = nil;
    if (self.delegate && [self.delegate respondsToSelector:@selector(didPullUpToLoadMoreForactivityView:)]) {
        [self.delegate didPullUpToLoadMoreForactivityView:self];
    }
}

#pragma mark Public methods

- (void)reloadData {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(listItemModelsOfActivityView:)]) {
        self.listModels = [self.dataSource listItemModelsOfActivityView:self];
        [self.tableView reloadData];
        if (self.noMoreData) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.tableView.mj_footer resetNoMoreData];
        }
    }
    if ([self.listModels count] == 0) {
        self.tableView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.tableView.frame.size.height) image:[UIImage imageNamed:@""] description:@"啥都木有啊···"];
    } else {
        self.tableView.backgroundView = nil;
    }
}

- (void)startRefresh {
    [self.tableView.mj_header beginRefreshing];
}

- (void)endRefresh {
    [self.tableView.mj_header endRefreshing];
}

- (void)endLoadMore {
    [self.tableView.mj_footer endRefreshing];
}

- (void)noMoreData:(BOOL)noMore {
    self.noMoreData = noMore;
    if (self.noMoreData) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.tableView.mj_footer resetNoMoreData];
    }
}

- (void)hideLoadMoreFooter:(BOOL)hidden {
    [self.tableView.mj_footer setHidden:hidden];
}


@end
