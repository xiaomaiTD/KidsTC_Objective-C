//
//  CouponListView.m
//  KidsTC
//
//  Created by 钱烨 on 9/6/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//

#import "CouponListView.h"
#import "AUISegmentView.h"
#import "CouponListViewCell.h"
#import "CouponListViewSegmentCell.h"
#import "KTCEmptyDataView.h"
#import "ToolBox.h"
#import "GHeader.h"

static NSString *const kSegmentIdentifier = @"kSegmentIdentifier";

static NSString *const kContentCellIdentifier = @"kContentCellIdentifier";

@interface CouponListView () <UITableViewDataSource, UITableViewDelegate, AUISegmentViewDataSource, AUISegmentViewDelegate>

@property (weak, nonatomic) IBOutlet AUISegmentView *segmentView;
@property (weak, nonatomic) IBOutlet UIView *gapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UINib *segmentNib;

@property (nonatomic, strong) UINib *contentNib;

@property (nonatomic, strong) NSArray *listModels;

@property (nonatomic, strong) NSMutableDictionary *noMoreDataDic;
@property (nonatomic, strong) NSMutableDictionary *hideFooterDic;

- (void)pullDownToRefresh;

- (void)pullUpToLoadMore;

@end

@implementation CouponListView

#pragma mark Initialization


- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    self = [super awakeAfterUsingCoder:aDecoder];
    static BOOL bLoad;
    if (!bLoad)
    {
        bLoad = YES;
        CouponListView *view = [ToolBox getObjectFromNibWithView:self];
        [view buildSubviews];
        return view;
    }
    bLoad = NO;
    return self;
}

- (void)buildSubviews {
    
    //[self.gapView setBackgroundColor:COLOR_PINK];
    
    self.tableView.backgroundView = nil;
    [self.tableView setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.01)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.01)];
    if (!self.contentNib) {
        self.contentNib = [UINib nibWithNibName:NSStringFromClass([CouponListViewCell class]) bundle:nil];
        [self.tableView registerNib:self.contentNib forCellReuseIdentifier:kContentCellIdentifier];
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
        BOOL noMore = [[self.noMoreDataDic objectForKey:[NSString stringWithFormat:@"%zd", self.currentViewTag]] boolValue];
        if (noMore) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
        [self pullUpToLoadMore];
    }];
    mj_footer.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer = mj_footer;
    
    self.segmentView.dataSource = self;
    self.segmentView.delegate = self;
    if (!self.segmentNib) {
        self.segmentNib = [UINib nibWithNibName:NSStringFromClass([CouponListViewSegmentCell class]) bundle:nil];
        [self.segmentView registerNib:self.segmentNib forCellReuseIdentifier:kSegmentIdentifier];
    }
    _currentViewTag = CouponListViewTagUnused;
    [self.segmentView setSelectedIndex:self.currentViewTag];
    //data
    self.noMoreDataDic = [[NSMutableDictionary alloc] init];
    self.hideFooterDic = [[NSMutableDictionary alloc] init];
}

#pragma mark AUISegmentViewDataSource & AUISegmentViewDelegate

- (NSUInteger)numberOfCellsForSegmentView:(AUISegmentView *)segmentView {
    return 3;
}

- (UITableViewCell *)segmentView:(AUISegmentView *)segmentView cellAtIndex:(NSUInteger)index {
    
    CouponListViewSegmentCell *cell = [segmentView dequeueReusableCellWithIdentifier:kSegmentIdentifier forIndex:index];
    if (!cell) {
        cell =  [[[NSBundle mainBundle] loadNibNamed:@"CouponListViewSegmentCell" owner:nil options:nil] objectAtIndex:0];
    }
    switch (index) {
        case 0:
        {
            [cell.titleLabel setText:@"未使用"];
        }
            break;
        case 1:
        {
            [cell.titleLabel setText:@"已使用"];
        }
            break;
        case 2:
        {
            [cell.titleLabel setText:@"已过期"];
        }
            break;
        default:
            break;
    }
    return cell;
}

- (void)segmentView:(AUISegmentView *)segmentView didSelectedAtIndex:(NSUInteger)index {
    _currentViewTag = (CouponListViewTag)index;
    if (self.delegate && [self.delegate respondsToSelector:@selector(couponListView:willShowWithTag:)]) {
        [self.delegate couponListView:self willShowWithTag:self.currentViewTag];
    }
}


#pragma mark UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.listModels count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CouponBaseModel *model = [self.listModels objectAtIndex:indexPath.section];
    CouponListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kContentCellIdentifier forIndexPath:indexPath];
    if (!cell) {
        cell =  [[[NSBundle mainBundle] loadNibNamed:@"CouponListViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    [cell configWithItemModel:model];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [CouponListViewCell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    if ([self.listModels count] > 0) {
        [view setBackgroundColor:COLOR_PINK];
    }
    return view;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(couponListView:didSelectedAtIndex:ofViewTag:)]) {
        [self.delegate couponListView:self didSelectedAtIndex:indexPath.section ofViewTag:self.currentViewTag];
    }
}

#pragma mark Private methods

- (void)pullDownToRefresh {
    self.tableView.backgroundView = nil;
    if (self.delegate && [self.delegate respondsToSelector:@selector(couponListView:DidPullDownToRefreshforViewTag:)]) {
        [self.delegate couponListView:self DidPullDownToRefreshforViewTag:self.currentViewTag];
    }
}

- (void)pullUpToLoadMore {
    self.tableView.backgroundView = nil;
    if (self.delegate && [self.delegate respondsToSelector:@selector(couponListView:DidPullUpToLoadMoreforViewTag:)]) {
        [self.delegate couponListView:self DidPullUpToLoadMoreforViewTag:self.currentViewTag];
    }
}

#pragma mark Public methods

- (void)setViewTag:(CouponListViewTag)tag {
    _currentViewTag = tag;
    [self.segmentView setSelectedIndex:self.currentViewTag];
}

- (void)reloadSegmentHeader {
    [self.segmentView reloadData];
    [self.segmentView setSelectedIndex:self.currentViewTag];
}

- (void)reloadDataforViewTag:(CouponListViewTag)tag {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(couponModelsOfCouponListView:withTag:)]) {
        self.listModels = [self.dataSource couponModelsOfCouponListView:self withTag:tag];
        [self.tableView reloadData];
        if ([self.listModels count] > 0) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
        if ([[self.noMoreDataDic objectForKey:[NSString stringWithFormat:@"%zd", self.currentViewTag]] boolValue]) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.tableView.mj_footer resetNoMoreData];
        }
    }
    [self.tableView.mj_footer setHidden:[[self.hideFooterDic objectForKey:[NSString stringWithFormat:@"%zd", self.currentViewTag]] boolValue]];
    if ([self.listModels count] == 0) {
        self.tableView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.tableView.frame.size.height) image:nil description:@"啥都木有啊···"];
    } else {
        self.tableView.backgroundView = nil;
    }
}

- (void)endRefresh {
    [self.tableView.mj_header endRefreshing];
}

- (void)endLoadMore {
    [self.tableView.mj_footer endRefreshing];
}

- (void)noMoreData:(BOOL)noMore forViewTag:(CouponListViewTag)tag {
    [self.noMoreDataDic setObject:[NSNumber numberWithBool:noMore] forKey:[NSString stringWithFormat:@"%zd", tag]];
}

- (void)hideLoadMoreFooter:(BOOL)hidden forViewTag:(CouponListViewTag)tag {
    [self.tableView.mj_footer setHidden:hidden];
    [self.hideFooterDic setObject:[NSNumber numberWithBool:hidden] forKey:[NSString stringWithFormat:@"%zd", tag]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
