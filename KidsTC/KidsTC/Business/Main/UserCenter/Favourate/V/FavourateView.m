//
//  FavourateView.m
//  KidsTC
//
//  Created by 钱烨 on 7/18/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//

#import "FavourateView.h"
#import "FavouriteViewServiceCell.h"
#import "FavouriteViewStoreCell.h"
#import "FavouriteViewStrategyCell.h"
#import "FavouriteViewNewsCell.h"
#import "AUISegmentView.h"
#import "FavourateSegmentViewCell.h"
#import "ArticleCell.h"
#import "ToolBox.h"
#import "GHeader.h"
#import "KTCEmptyDataView.h"

static NSString *const kSegmentCellIdentifier = @"kSegmentCellIdentifier";
static NSString *const kServiceCellIdentifier = @"kServiceCellIdentifier";
static NSString *const kStoreCellIdentifier = @"kStoreCellIdentifier";
static NSString *const kParentingStrategyCellIdentifier = @"kParentingStrategyCellIdentifier";
static NSString *const kArticleCellIdentifier = @"kArticleCellIdentifier";

@interface FavourateView () <UITableViewDataSource, UITableViewDelegate, AUISegmentViewDataSource, AUISegmentViewDelegate,ArticleCellDelegate>

@property (weak, nonatomic) IBOutlet AUISegmentView *segmentView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UINib *segmentCellNib;
@property (nonatomic, strong) UINib *serviceCellNib;
@property (nonatomic, strong) UINib *storeCellNib;
@property (nonatomic, strong) UINib *parentingStrategyCellNib;
@property (nonatomic, strong) UINib *newsCellNib;

@property (nonatomic, strong) NSArray *ItemModelArray;

@property (nonatomic, strong) NSMutableDictionary *noMoreDataDic;
@property (nonatomic, strong) NSMutableDictionary *hideFooterDic;




- (void)pullDownToRefresh;
- (void)pullUpToLoadMore;

@end

@implementation FavourateView

#pragma mark Initialization


- (id)awakeAfterUsingCoder:(NSCoder *)aDecoder
{
    self = [super awakeAfterUsingCoder:aDecoder];
    static BOOL bLoad;
    if (!bLoad)
    {
        bLoad = YES;
        FavourateView *view = [ToolBox getObjectFromNibWithView:self];
        [view buildSubviews];
        return view;
    }
    bLoad = NO;
    return self;
}

- (void)buildSubviews {
    
    self.tableView.backgroundView = nil;
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.01)];
    
    self.segmentView.dataSource = self;
    self.segmentView.delegate = self;
    [self.segmentView setShowSeparator:YES];
    if (!self.segmentCellNib) {
        self.segmentCellNib = [UINib nibWithNibName:NSStringFromClass([FavourateSegmentViewCell class]) bundle:nil];
        [self.segmentView registerNib:self.segmentCellNib forCellReuseIdentifier:kSegmentCellIdentifier];
    }
    [self.segmentView reloadData];
    self.segmentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.segmentView setSelectedIndex:0];
    
    
    if (!self.serviceCellNib) {
        self.serviceCellNib = [UINib nibWithNibName:NSStringFromClass([FavouriteViewServiceCell class]) bundle:nil];
        [self.tableView registerNib:self.serviceCellNib forCellReuseIdentifier:kServiceCellIdentifier];
    }
    if (!self.storeCellNib) {
        self.storeCellNib = [UINib nibWithNibName:NSStringFromClass([FavouriteViewStoreCell class]) bundle:nil];
        [self.tableView registerNib:self.storeCellNib forCellReuseIdentifier:kStoreCellIdentifier];
    }
    if (!self.parentingStrategyCellNib) {
        self.parentingStrategyCellNib = [UINib nibWithNibName:NSStringFromClass([FavouriteViewStrategyCell class]) bundle:nil];
        [self.tableView registerNib:self.parentingStrategyCellNib forCellReuseIdentifier:kParentingStrategyCellIdentifier];
    }
//    if (!self.newsCellNib) {
//        self.newsCellNib = [UINib nibWithNibName:NSStringFromClass([FavouriteViewNewsCell class]) bundle:nil];
//        [self.tableView registerNib:self.newsCellNib forCellReuseIdentifier:kNewsCellIdentifier];
//    }
    WeakSelf(self)
    RefreshHeader *mj_header = [RefreshHeader headerWithRefreshingBlock:^{
        StrongSelf(self)
        [self pullDownToRefresh];
    }];
    mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_header = mj_header;
    
    RefreshFooter *mj_footer = [RefreshFooter footerWithRefreshingBlock:^{
        StrongSelf(self)
        BOOL noMore = [[self.noMoreDataDic objectForKey:[NSString stringWithFormat:@"%zd", self.currentTag]] boolValue];
        if (noMore) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            return;
        }
        [self pullUpToLoadMore];
    }];
    mj_footer.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer = mj_footer;
    
    //data
    self.noMoreDataDic = [[NSMutableDictionary alloc] init];
    self.hideFooterDic = [[NSMutableDictionary alloc] init];
}

- (NSUInteger)serviceListPageSize {
    return 10;
}

- (NSUInteger)storeListPageSize {
    return 10;
}

- (NSUInteger)strategyListPageSize {
    return 10;
}

- (NSUInteger)newsListPageSize {
    return 10;
}

#pragma mark AUISegmentViewDataSource & AUISegmentViewDelegate

- (NSUInteger)numberOfCellsForSegmentView:(AUISegmentView *)segmentView {
    return 4;
}

- (UITableViewCell *)segmentView:(AUISegmentView *)segmentView cellAtIndex:(NSUInteger)index {
    
    FavourateSegmentViewCell *cell = [segmentView dequeueReusableCellWithIdentifier:kSegmentCellIdentifier forIndex:index];
    if (!cell) {
        cell =  [[[NSBundle mainBundle] loadNibNamed:@"FavourateSegmentViewCell" owner:nil options:nil] objectAtIndex:0];
    }
    switch (index) {
        case 0:
        {
            [cell.titleLabel setText:@"服务"];
        }
            break;
        case 1:
        {
            [cell.titleLabel setText:@"门店"];
        }
            break;
        case 2:
        {
            [cell.titleLabel setText:@"攻略"];
        }
            break;
        case 3:
        {
            [cell.titleLabel setText:@"资讯"];
        }
            break;
        default:
            break;
    }
    return cell;
}

- (void)segmentView:(AUISegmentView *)segmentView didSelectedAtIndex:(NSUInteger)index {
    _currentTag = (FavourateViewSegmentTag)index;
    if (self.delegate && [self.delegate respondsToSelector:@selector(favourateView:didChangedSegmentSelectedIndexWithTag:)]) {
        [self.delegate favourateView:self didChangedSegmentSelectedIndexWithTag:(FavourateViewSegmentTag)index];
    }
}


#pragma mark UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.ItemModelArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.currentTag) {
        case FavourateViewSegmentTagService:
        {
            FavouriteViewServiceCell *cell = [tableView dequeueReusableCellWithIdentifier:kServiceCellIdentifier forIndexPath:indexPath];
            if (!cell) {
                cell =  [[[NSBundle mainBundle] loadNibNamed:@"FavouriteViewServiceCell" owner:nil options:nil] objectAtIndex:0];
            }
            [cell configWithItemModel:[self.ItemModelArray objectAtIndex:indexPath.row]];
            return cell;
        }
            break;
        case FavourateViewSegmentTagStore:
        {
            FavouriteViewStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:kStoreCellIdentifier forIndexPath:indexPath];
            if (!cell) {
                cell =  [[[NSBundle mainBundle] loadNibNamed:@"FavouriteViewStoreCell" owner:nil options:nil] objectAtIndex:0];
            }
            [cell configWithItemModel:[self.ItemModelArray objectAtIndex:indexPath.row]];
            return cell;
        }
            break;
        case FavourateViewSegmentTagStrategy:
        {
            FavouriteViewStrategyCell *cell = [tableView dequeueReusableCellWithIdentifier:kParentingStrategyCellIdentifier forIndexPath:indexPath];
            if (!cell) {
                cell =  [[[NSBundle mainBundle] loadNibNamed:@"FavouriteViewStrategyCell" owner:nil options:nil] objectAtIndex:0];
            }
            [cell configWithItemModel:[self.ItemModelArray objectAtIndex:indexPath.row]];
            return cell;
        }
            break;
        case FavourateViewSegmentTagNews:
        {
            ArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:kArticleCellIdentifier];
            if (!cell) {
                cell =  [[ArticleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kArticleCellIdentifier];
                cell.backgroundColor = [UIColor clearColor];
                cell.delegate = self;
                cell.line.hidden = YES;
            }
            cell.layout = self.ItemModelArray[indexPath.row];
            
            return cell;
        }
            break;
        default:
            break;
    }
    
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0;
    switch (self.currentTag) {
        case FavourateViewSegmentTagService:
        {
            height = [FavouriteViewServiceCell cellHeight];
        }
            break;
        case FavourateViewSegmentTagStore:
        {
            height = [FavouriteViewStoreCell cellHeight];
        }
            break;
        case FavourateViewSegmentTagStrategy:
        {
            height = [FavouriteViewStrategyCell cellHeight];
        }
            break;
        case FavourateViewSegmentTagNews:
        {
            //height = [FavouriteViewNewsCell cellHeight];
            ArticleLayout *layout = self.ItemModelArray[indexPath.row];
            height = layout.height;
        }
            break;
        default:
            break;
    }
    return height;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(favourateView:didSelectedAtIndex:ofTag:)]) {
        [self.delegate favourateView:self didSelectedAtIndex:indexPath.row ofTag:self.currentTag];
    }
}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSMutableArray *array = [NSMutableArray arrayWithArray:self.ItemModelArray];
        [array removeObjectAtIndex:indexPath.row];
        self.ItemModelArray = [NSArray arrayWithArray:array];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationTop];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(favourateView:didDeleteIndex:ofTag:)]) {
            [self.delegate favourateView:self didDeleteIndex:indexPath.row ofTag:self.currentTag];
        }
    }
}

#pragma mark Private methods

- (void)pullDownToRefresh {
    self.tableView.backgroundView = nil;
    if (self.delegate && [self.delegate respondsToSelector:@selector(favourateView:needUpdateDataForTag:)]) {
        [self.delegate favourateView:self needUpdateDataForTag:self.currentTag];
    }
}

- (void)pullUpToLoadMore {
    self.tableView.backgroundView = nil;
    if (self.delegate && [self.delegate respondsToSelector:@selector(favourateView:needLoadMoreDataForTag:)]) {
        [self.delegate favourateView:self needLoadMoreDataForTag:self.currentTag];
    }
}



#pragma mark Public methods

- (void)reloadDataForTag:(FavourateViewSegmentTag)tag {
    if (self.dataSource && [self.dataSource respondsToSelector:@selector(favourateView:itemModelsForSegmentTag:)]) {
        self.ItemModelArray = [self.dataSource favourateView:self itemModelsForSegmentTag:tag];
        [self.tableView reloadData];
        if ([self.ItemModelArray count] > 0) {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:NO];
        }
        if ([[self.noMoreDataDic objectForKey:[NSString stringWithFormat:@"%d", self.currentTag]] boolValue]) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.tableView.mj_footer resetNoMoreData];
        }
    }
    [self.tableView.mj_footer setHidden:[[self.hideFooterDic objectForKey:[NSString stringWithFormat:@"%d", self.currentTag]] boolValue]];
    if ([self.ItemModelArray count] == 0) {
        self.tableView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.tableView.frame.size.height) image:nil description:@"啥都木有啊···" needGoHome:YES];
    } else {
        self.tableView.backgroundView = nil;
    }
}

- (void)startRefreshWithTag:(FavourateViewSegmentTag)tag {
    [self.tableView.mj_header beginRefreshing];
}

- (void)endRefresh {
    [self.tableView.mj_header endRefreshing];
}

- (void)loadMoreWithTag:(FavourateViewSegmentTag)tag {
    [self.tableView.mj_footer beginRefreshing];
}

- (void)endLoadMore {
    [self.tableView.mj_footer endRefreshing];
}

- (void)noMoreData:(BOOL)noMore forTag:(FavourateViewSegmentTag)tag {
    [self.noMoreDataDic setObject:[NSNumber numberWithBool:noMore] forKey:[NSString stringWithFormat:@"%d", tag]];
}

- (void)hideLoadMoreFooter:(BOOL)hidden ForTag:(FavourateViewSegmentTag)tag {
    [self.tableView.mj_footer setHidden:hidden];
    [self.hideFooterDic setObject:[NSNumber numberWithBool:hidden] forKey:[NSString stringWithFormat:@"%d", tag]];
}

#pragma mark - ArticleCellDelegate
/**
 *  点击了头部标题按钮
 *
 *  @param cell    self
 *  @param tagItem 标题按钮对应的最小item
 */
- (void)articleCell:(ArticleCell *)cell didClickOnHeadColumnTitleTagBtn:(ACTagsItem *)targetItem{
    if ([self.delegate respondsToSelector:@selector(favourateView:articleCell:didClickOnHeadColumnTitleTagBtn:)]) {
        [self.delegate favourateView:self articleCell:cell didClickOnHeadColumnTitleTagBtn:targetItem];
    }
}
/**
 *  点击了banner
 *
 *  @param cell    self
 *  @param tagItem
 */
- (void)articleCell:(ArticleCell *)cell didClickOnBannerItem:(AHBannersItem *)targetItem{
    if ([self.delegate respondsToSelector:@selector(favourateView:articleCell:didClickOnBannerItem:)]) {
        [self.delegate favourateView:self articleCell:cell didClickOnBannerItem:targetItem];
    }
}

/**
 *  点击了头部带普通图集中的图片
 *
 *  @param cell       self
 *  @param targetItem
 */
- (void)articleCell:(ArticleCell *)cell didClickOnAlbumEntrysItem:(AHAlbumEntrysItem *)targetItem{
    if ([self.delegate respondsToSelector:@selector(favourateView:articleCell:didClickOnAlbumEntrysItem:)]) {
        [self.delegate favourateView:self articleCell:cell didClickOnAlbumEntrysItem:targetItem];
    }
}

/**
 *  点击了图集中的图片
 *
 *  @param cell       self
 *  @param targetItem
 */
- (void)articleCell:(ArticleCell *)cell didClickOnAlbum:(ALstItem *)album index:(NSUInteger)index{
    if ([self.delegate respondsToSelector:@selector(favourateView:articleCell:didClickOnAlbum:index:)]) {
        [self.delegate favourateView:self articleCell:cell didClickOnAlbum:album index:index];
    }
}
/**
 *  点击了ProductsItem
 *
 *  @param cell       self
 *  @param targetItem
 */
- (void)articleCell:(ArticleCell *)cell didClickOnProductsItem:(AIProductsItem *)targetItem{
    
    if ([self.delegate respondsToSelector:@selector(favourateView:articleCell:didClickOnProductsItem:)]) {
        [self.delegate favourateView:self articleCell:cell didClickOnProductsItem:targetItem];
    }
}

/**
 *  zpTag
 *
 *  @param cell       self
 *  @param targetItem
 */
- (void)articleCell:(ArticleCell *)cell didClickOnTagsItem:(AITagsItem *)targetItem{
    if ([self.delegate respondsToSelector:@selector(favourateView:articleCell:didClickOnTagsItem:)]) {
        [self.delegate favourateView:self articleCell:cell didClickOnTagsItem:targetItem];
    }
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
