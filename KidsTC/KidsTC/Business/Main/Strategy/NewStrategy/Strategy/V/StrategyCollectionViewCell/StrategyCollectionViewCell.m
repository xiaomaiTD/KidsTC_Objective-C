//
//  StrategyCollectionViewCell.m
//  KidsTC
//
//  Created by zhanping on 6/6/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "StrategyCollectionViewCell.h"
#import "RefreshHeader.h"
#import "RefreshFooter.h"
#import "Macro.h"

@interface StrategyCollectionViewCell ()<UITableViewDelegate,UITableViewDataSource,StrategyTableViewCellDelegate,StrategyTableHeaderViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end
static NSString *ID = @"StrategyTableViewCellID";
@implementation StrategyCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"StrategyTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ID];
    
    WeakSelf(self)
    MJRefreshHeader *mj_header = [RefreshHeader headerWithRefreshingBlock:^{
        StrongSelf(self)
        [self loadDataRefresh:YES];
    }];
    mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_header = mj_header;
    
    self.tableView.mj_footer = [RefreshFooter footerWithRefreshingBlock:^{
        StrongSelf(self)
        [self loadDataRefresh:NO];
    }];
}

- (void)beginRefreshing{
    [self.tableView.mj_header beginRefreshing];
}
- (void)headerEndRefreshing{
    [self.tableView.mj_header endRefreshing];
}
- (void)footerEndRefreshing{
    [self.tableView.mj_footer endRefreshing];
}
- (void)footerEndRefreshingWithNoMoreData{
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

- (void)setTableViewInset:(UIEdgeInsets)tableViewInset{
    _tableViewInset = tableViewInset;
    self.tableView.contentInset = tableViewInset;
}

- (void)reloadData{
    if (self.model.list.count<=0 && !self.model.header) {
//        self.tableView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.tableView.frame.size.height) image:nil description:@"啥都木有啊···" needGoHome:NO];
    }else{
        self.tableView.backgroundView = nil;
    }
    
    [self.tableView reloadData];
}
- (void)loadDataRefresh:(BOOL)refresh{
    if ([self.delegate respondsToSelector:@selector(strategyCell:loadDataRefresh:)]) {
        [self.delegate strategyCell:self loadDataRefresh:refresh];
    }
}

- (void)setModel:(StrategyShowModel *)model{
    _model = model;
    
    StrategyShowHeader *header = model.header;
    if (header) {
        StrategyTableHeaderView *tableHeaderView = [[StrategyTableHeaderView alloc]init];
        tableHeaderView.header = header;
        tableHeaderView.delegate = self;
        self.tableView.tableHeaderView = tableHeaderView;
    }else{
        self.tableView.tableHeaderView = nil;
    }
    
    NSArray *list = model.list;
    
    if (!list || [list count]==0) {
        [self beginRefreshing];
    }
    [self reloadData];
}

#pragma mark <UITableViewDelegate,UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.model.list.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    StrategyListItem *item = self.model.list[indexPath.row];
    CGFloat ratio = item.ratio;
    if (ratio==0) {
        ratio = 0.6;
    }
    CGFloat hight = (SCREEN_WIDTH-8*2)*ratio+8*2;
    return hight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    StrategyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.delegate = self;
    cell.item = self.model.list[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self.delegate respondsToSelector:@selector(strategyCell:tableView:didSelectedIndexPath:)]) {
        [self.delegate strategyCell:self tableView:self.tableView didSelectedIndexPath:indexPath];
    }
}

#pragma mark <StrategyTableViewCellDelegate>

- (void)strategyTableViewCell:(StrategyTableViewCell *)strategyTableViewCell didClickOnStrategyLikeButton:(StrategyLikeButton *)strategyLikeButton{
    if ([self.delegate respondsToSelector:@selector(strategyCell:strategyTableViewCell:didClickOnStrategyLikeButton:)]) {
        [self.delegate strategyCell:self strategyTableViewCell:strategyTableViewCell didClickOnStrategyLikeButton:strategyLikeButton];
    }
}

#pragma mark <StrategyTableHeaderViewDelegate>

- (void)strategyTableHeaderView:(StrategyTableHeaderView *)strategyTableHeaderView didClickBannerAtIndex:(NSUInteger)index{
    if ([self.delegate respondsToSelector:@selector(strategyCell:strategyTableHeaderView:didClickBannerAtIndex:)]) {
        [self.delegate strategyCell:self strategyTableHeaderView:strategyTableHeaderView didClickBannerAtIndex:index];
    }
}

- (void)strategyTableHeaderView:(StrategyTableHeaderView *)strategyTableHeaderView didClickTagPicAtIndex:(NSUInteger)index{
    if ([self.delegate respondsToSelector:@selector(strategyCell:strategyTableHeaderView:didClickTagPicAtIndex:)]) {
        [self.delegate strategyCell:self strategyTableHeaderView:strategyTableHeaderView didClickTagPicAtIndex:index];
    }
}

@end
