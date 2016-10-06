//
//  ArticleUserCenterViewController.m
//  KidsTC
//
//  Created by zhanping on 2016/9/13.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ArticleUserCenterViewController.h"

#import "GHeader.h"
#import "NSString+Category.h"
#import "SegueMaster.h"

#import "ArticleHomeModel.h"
#import "ArticleUserCenterArticleModel.h"
#import "ArticleUserCenterCommentModel.h"

#import "ArticleUserCenterTableHeaderView.h"
#import "ArticleUserCenterToolBar.h"

#import "ArticleHomeBaseCell.h"
#import "ArticleHomeIconCell.h"
#import "ArticleHomeNoIconCell.h"
#import "ArticleHomeBigImgCell.h"
#import "ArticleHomeTagImgCell.h"
#import "ArticleHomeBannerCell.h"
#import "ArticleHomeVideoCell.h"
#import "ArticleHomeAlbumCell.h"
#import "ArticleHomeUserArticleCell.h"
#import "ArticleHomeColumnTitleCell.h"
#import "ArticleHomeAlbumEntrysCell.h"

#import "ArticleUserCenterCommentCell.h"

#import "KTCEmptyDataView.h"

static int const kPageCount = 10;

static NSString *const ArticleHomeBaseCellID          = @"ArticleHomeBaseCellID";
static NSString *const ArticleHomeIconCellID          = @"ArticleHomeIconCellID";
static NSString *const ArticleHomeNoIconCellID        = @"ArticleHomeNoIconCellID";
static NSString *const ArticleHomeBigImgCellID        = @"ArticleHomeBigImgCellID";
static NSString *const ArticleHomeTagImgCellID        = @"ArticleHomeTagImgCellID";
static NSString *const ArticleHomeBannerCellID        = @"ArticleHomeBannerCellID";
static NSString *const ArticleHomeVideoCellID         = @"ArticleHomeVideoCellID";
static NSString *const ArticleHomeAlbumCellID         = @"ArticleHomeAlbumCellID";
static NSString *const ArticleHomeUserArticleCellID   = @"ArticleHomeUserArticleCellID";
static NSString *const ArticleHomeColumnTitleCellID   = @"ArticleHomeColumnTitleCellID";
static NSString *const ArticleHomeAlbumEntrysCellID   = @"ArticleHomeAlbumEntrysCellID";

static NSString *const ArticleUserCenterCommentCellID = @"ArticleUserCenterCommentCellID";


@interface ArticleUserCenterViewController ()<UITableViewDelegate,UITableViewDataSource,ArticleUserCenterToolBarDelegate,ArticleHomeBaseCellDelegate,ArticleUserCenterCommentCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ArticleUserCenterTableHeaderView *headerView;
@property (nonatomic, strong) ArticleUserCenterToolBar *toolBar;

@property (nonatomic, assign) ArticleUserCenterToolBarItemType currentType;

@property (nonatomic, assign) NSUInteger articlePage;
@property (nonatomic, strong) NSArray<ArticleHomeItem *> *articles;

@property (nonatomic, assign) NSUInteger commentPage;
@property (nonatomic, strong) NSArray<ArticleUserCenterCommentItem *> *comments;

@property (nonatomic, strong) NSArray *currentArray;

@end

@implementation ArticleUserCenterViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.title = @"评论列表";
    
    [self setupTableView];
    
    _headerView = [self viewWithNib:@"ArticleUserCenterTableHeaderView"];
    _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*kArticleUserCenterTableHeaderViewRatio);
    self.tableView.tableHeaderView = _headerView;
    
    _toolBar = [self viewWithNib:@"ArticleUserCenterToolBar"];
    _toolBar.delegate = self;
    _toolBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, kArticleUserCenterToolBarHeight);
    [self.view addSubview:_toolBar];
    [_toolBar beginRefreshing];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self scrollViewDidScroll:_tableView];
    [self loadUserInfo];
}

- (void)loadUserInfo {
    [Request startWithName:@"GET_USER_BASE_INFO" param:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        self.headerView.data = [ArticleHomeUserInfoModel modelWithDictionary:dic].data;
    } failure:nil];
}

- (void)setupTableView {
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 44.0;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [self registerCells];
    
    [self setupMJ];
}

- (void)registerCells {
    
    [_tableView registerClass:[ArticleHomeBaseCell class]                                     forCellReuseIdentifier:ArticleHomeBaseCellID];
    [_tableView registerNib:[UINib nibWithNibName:@"ArticleHomeIconCell" bundle:nil]          forCellReuseIdentifier:ArticleHomeIconCellID];
    [_tableView registerNib:[UINib nibWithNibName:@"ArticleHomeNoIconCell" bundle:nil]        forCellReuseIdentifier:ArticleHomeNoIconCellID];
    [_tableView registerNib:[UINib nibWithNibName:@"ArticleHomeBigImgCell" bundle:nil]        forCellReuseIdentifier:ArticleHomeBigImgCellID];
    [_tableView registerNib:[UINib nibWithNibName:@"ArticleHomeTagImgCell" bundle:nil]        forCellReuseIdentifier:ArticleHomeTagImgCellID];
    [_tableView registerNib:[UINib nibWithNibName:@"ArticleHomeBannerCell" bundle:nil]        forCellReuseIdentifier:ArticleHomeBannerCellID];
    [_tableView registerNib:[UINib nibWithNibName:@"ArticleHomeVideoCell" bundle:nil]         forCellReuseIdentifier:ArticleHomeVideoCellID];
    [_tableView registerNib:[UINib nibWithNibName:@"ArticleHomeAlbumCell" bundle:nil]         forCellReuseIdentifier:ArticleHomeAlbumCellID];
    [_tableView registerNib:[UINib nibWithNibName:@"ArticleHomeUserArticleCell" bundle:nil]   forCellReuseIdentifier:ArticleHomeUserArticleCellID];
    [_tableView registerNib:[UINib nibWithNibName:@"ArticleHomeColumnTitleCell" bundle:nil]   forCellReuseIdentifier:ArticleHomeColumnTitleCellID];
    [_tableView registerNib:[UINib nibWithNibName:@"ArticleHomeAlbumEntrysCell" bundle:nil]   forCellReuseIdentifier:ArticleHomeAlbumEntrysCellID];
    
    [_tableView registerNib:[UINib nibWithNibName:@"ArticleUserCenterCommentCell" bundle:nil] forCellReuseIdentifier:ArticleUserCenterCommentCellID];
}

- (void)setupMJ {
    
    WeakSelf(self)
    RefreshHeader *mj_header = [RefreshHeader headerWithRefreshingBlock:^{
        StrongSelf(self)
        [self loadDataRefresh:YES];
    }];
    mj_header.automaticallyChangeAlpha = YES;
    _tableView.mj_header = mj_header;
    
    RefreshFooter *mj_footer = [RefreshFooter footerWithRefreshingBlock:^{
        StrongSelf(self)
        [self loadDataRefresh:NO];
    }];
    mj_footer.automaticallyChangeAlpha = YES;
    _tableView.mj_footer = mj_footer;
}

- (id)viewWithNib:(NSString *)nib{
    return [[NSBundle mainBundle] loadNibNamed:nib owner:self options:nil].firstObject;
}

- (void)loadDataRefresh:(BOOL)refresh {
    switch (_currentType) {
        case ArticleUserCenterToolBarItemTypeArticle:
        {
            [self loadArticleDataRefresh:refresh];
        }
            break;
        case ArticleUserCenterToolBarItemTypeComment:
        {
            [self loadCommentDataRefresh:refresh];
        }
            break;
    }
}

- (void)loadArticleDataRefresh:(BOOL)refresh {
    
    self.articlePage = refresh?1:++_articlePage;
    
    NSDictionary *param = @{@"page":@(_articlePage),
                            @"pageCount":@(kPageCount)};
    
    [Request startWithName:@"ARTICLES_USER_GET" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [self loadArticleDataRefresh:refresh success:[ArticleUserCenterArticleModel modelWithDictionary:dic]];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self loadArticleDataRefresh:refresh failure:error];
    }];
}

- (void)loadArticleDataRefresh:(BOOL)refresh success:(ArticleUserCenterArticleModel *)model {
    
    NSArray *ary = model.data;
    
    if (ary.count > 0) {
        if (refresh) {
            self.articles = [NSArray arrayWithArray:ary];
        }else{
            NSMutableArray *mutableAry = [NSMutableArray arrayWithArray:_articles];
            [mutableAry addObjectsFromArray:ary];
            self.articles = [NSArray arrayWithArray:mutableAry];
        }
        self.currentArray = _articles;
    }
    
    [self dealWithMJ];
    if (ary.count<kPageCount) [_tableView.mj_footer endRefreshingWithNoMoreData];
    [_tableView reloadData];
}

- (void)loadArticleDataRefresh:(BOOL)refresh failure:(NSError *)error {
    [self dealWithMJ];
    [_tableView.mj_footer endRefreshingWithNoMoreData];
}

- (void)loadCommentDataRefresh:(BOOL)refresh {

    self.commentPage = refresh?1:++_commentPage;
    NSString *userId = [self.userId isNotNull]?self.userId:@"";
    
    NSDictionary *param = @{@"page":@(_commentPage),
                            @"pageCount":@(kPageCount),
                            @"userId":userId};
    
    [Request startWithName:@"GET_USER_ARTICLE_COMMENT" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [self loadCommentDataRefresh:refresh success:[ArticleUserCenterCommentModel modelWithDictionary:dic]];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self loadCommentDataRefresh:refresh failure:error];
    }];
}

- (void)loadCommentDataRefresh:(BOOL)refresh success:(ArticleUserCenterCommentModel *)model {
    
    NSArray *ary = model.data.comments;

    if (ary.count > 0) {
        if (refresh) {
            self.comments = [NSArray arrayWithArray:ary];
        }else{
            NSMutableArray *mutableAry = [NSMutableArray arrayWithArray:_comments];
            [mutableAry addObjectsFromArray:ary];
            self.comments = [NSArray arrayWithArray:mutableAry];
        }
        self.currentArray = _comments;
    }
    
    [self dealWithMJ];
    if (ary.count<kPageCount) [_tableView.mj_footer endRefreshingWithNoMoreData];
}

- (void)loadCommentDataRefresh:(BOOL)refresh failure:(NSError *)error {
    [self dealWithMJ];
    [_tableView.mj_footer endRefreshingWithNoMoreData];
}

- (void)dealWithMJ{
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
    [_tableView reloadData];
}

- (void)setCurrentArray:(NSArray *)currentArray {
    _currentArray = currentArray;
    if (!_currentArray || _currentArray.count==0) {
        CGFloat y = kArticleUserCenterToolBarHeight + kArticleUserCenterTableHeaderViewRatio*SCREEN_WIDTH;
        _tableView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT+y) image:nil description:@"啥都没有啊" needGoHome:NO];
    } else _tableView.backgroundView = nil;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    self.naviColor = [COLOR_PINK colorWithAlphaComponent:offsetY/64];
    
    CGFloat tooBar_y = kArticleUserCenterTableHeaderViewRatio*SCREEN_WIDTH-offsetY;
    tooBar_y = tooBar_y<64?64:tooBar_y;
    CGRect frame = _toolBar.frame;
    frame.origin.y = tooBar_y;
    _toolBar.frame = frame;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _currentArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return kArticleUserCenterToolBarHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (_currentType) {
        case ArticleUserCenterToolBarItemTypeArticle:
        {
            ArticleHomeItem *item = _currentArray[indexPath.row];
            ArticleHomeBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:[self articleCellIdWtith:item.listTemplate]];
            cell.delegate = self;
            cell.item = item;
            return cell;
        }
            break;
        case ArticleUserCenterToolBarItemTypeComment:
        {
            ArticleUserCenterCommentItem *item = _currentArray[indexPath.row];
            ArticleUserCenterCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:ArticleUserCenterCommentCellID];
            cell.delegate = self;
            cell.item = item;
            return cell;
        }
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    switch (_currentType) {
        case ArticleUserCenterToolBarItemTypeArticle:
        {
            ArticleHomeItem *item = _currentArray[indexPath.row];
            [SegueMaster makeSegueWithModel:item.segueModel fromController:self];
        }
            break;
        case ArticleUserCenterToolBarItemTypeComment:
        {
            ArticleUserCenterCommentItem *item = _currentArray[indexPath.row];
            [SegueMaster makeSegueWithModel:item.segueModel fromController:self];
        }
            break;
    }
}

#pragma mark - UITableViewDelegate,UITableViewDataSource helper


- (NSString *)articleCellIdWtith:(ArticleHomeListTemplate)type {
    
    NSString *ID = ArticleHomeBaseCellID;
    
    switch (type) {
        case ArticleHomeListTemplateIcon:
        {
            ID = ArticleHomeIconCellID;
        }
            break;
        case ArticleHomeListTemplateNoIcon:
        {
            ID = ArticleHomeNoIconCellID;
        }
            break;
        case ArticleHomeListTemplateBigImg:
        {
            ID = ArticleHomeBigImgCellID;
        }
            break;
        case ArticleHomeListTemplateTagImg:
        {
            ID = ArticleHomeTagImgCellID;
        }
            break;
        case ArticleHomeListTemplateBanner:
        case ArticleHomeListTemplateHeadBanner:
        {
            ID = ArticleHomeBannerCellID;
        }
            break;
        case ArticleHomeListTemplateVideo:
        {
            ID = ArticleHomeVideoCellID;
        }
            break;
        case ArticleHomeListTemplateAlbum:
        case ArticleHomeListTemplateUserAlbum:
        {
            ID = ArticleHomeAlbumCellID;
        }
            break;
        case ArticleHomeListTemplateUserArticle:
        {
            ID = ArticleHomeUserArticleCellID;
        }
            break;
        case ArticleHomeListTemplateColumnTitle:
        {
            ID = ArticleHomeColumnTitleCellID;
        }
            break;
        case ArticleHomeListTemplateAlbumEntrys:
        {
            ID = ArticleHomeAlbumEntrysCellID;
        }
            break;
        default:
        {
            ID = ArticleHomeBaseCellID;
        }
            break;
    }
    
    return ID;
}

#pragma mark - ArticleHomeBaseCellDelegate

- (void)articleHomeBaseCell:(ArticleHomeBaseCell *)cell actionType:(ArticleHomeBaseCellActionType)type value:(id)value {
    switch (type) {
        case ArticleHomeBaseCellActionTypeSegue:
        {
            [SegueMaster makeSegueWithModel:value fromController:self];
        }
            break;
        default:break;
    }
}

#pragma mark - ArticleUserCenterCommentCellDelegate

- (void)articleUserCenterCommentCell:(ArticleUserCenterCommentCell *)cell actionType:(ArticleUserCenterCommentCellActionType)type value:(id)value {
    switch (type) {
        case ArticleUserCenterCommentCellActionTypePrise:
        {
            [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
                [self changePriseState:(ArticleUserCenterCommentItem *)value];
            }];
        }
            break;
        default:break;
    }
}

- (void)changePriseState:(ArticleUserCenterCommentItem *)item {
    
    NSString *isPrasize    = item.isPraised? @"1":@"0";
    NSString *articleSysNo = [item.articleSysNo isNotNull]?item.articleSysNo:@"";
    NSString *commentSysNO = [item.commentSysNo isNotNull]?item.commentSysNo:@"";
    NSDictionary *parameters = @{@"isPraise":isPrasize,
                                 @"relationSysNo":articleSysNo,
                                 @"commentSysNo":commentSysNO};
    [Request startWithName:@"COMMENT_PRAISE" param:parameters progress:nil success:nil failure:nil];
}

#pragma mark - ArticleUserCenterToolBarDelegate

- (void)articleUserCenterToolBar:(ArticleUserCenterToolBar *)toolBar currentType:(ArticleUserCenterToolBarItemType)type {
    
    self.currentType = type;
    
    NSString *title = @"";
    
    switch (type) {
        case ArticleUserCenterToolBarItemTypeArticle:
        {
            self.currentArray = _articles;
            title = @"文章列表";
        }
            break;
        case ArticleUserCenterToolBarItemTypeComment:
        {
            self.currentArray = _comments;
            title = @"评论列表";
        }
            break;
    }
    
    self.navigationItem.title = title;
    
    if (!_currentArray || _currentArray.count==0) {
        [_tableView.mj_header beginRefreshing];
    } else {
        [_tableView reloadData];
    }
    
}


@end
