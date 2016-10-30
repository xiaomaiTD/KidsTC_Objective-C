//
//  SearchResultViewController.m
//  KidsTC
//
//  Created by zhanping on 6/29/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "SearchResultViewController.h"
#import "GHeader.h"
#import "BuryPointManager.h"
#import "NSString+Category.h"

#import "RefreshHeader.h"
#import "RefreshFooter.h"
#import "SearchResultFactorView.h"
#import "SearchResultViewLocationButton.h"
#import "SearchResultFactorShowModelManager.h"
#import "SearchResultModel.h"
#import "SearchResultProductCell.h"
#import "SearchResultStoreCell.h"
#import "SearchResultArticleCell.h"
#import "SearchParmsModel.h"
#import "KTCMapService.h"
#import "MapLocateViewController.h"
#import "ProductDetailViewController.h"
#import "StoreDetailViewController.h"
#import "WebViewController.h"
#import "KTCEmptyDataView.h"

#define COUNT 10

//=======================================================================

#define SearchParameters_kPage @"page" //当前页

//=======================================================================

#define MapAddrViewHeight 30

#define SearchParameters_kArea @"s"//地区
#define SearchParameters_kSort @"st"//排序
#define SearchParameters_kAge @"a"//年龄段
#define SearchParameters_kCategory @"c"//分类

#define SearchParameters_kPageSize @"pageSize"//每页数量
#define SearchParameters_kType @"type"//搜索类型
#define SearchParameters_kMapaddr @"mapaddr"//地址
#define SearchParameters_kKeywords @"k"//关键字

//=======================================================================

#define SearchArticleParameters_kPageCount @"pageCount"
#define SearchArticleParameters_kArticleKind @"articleKind"
#define SearchArticleParameters_kTagId @"tagId"
#define SearchArticleParameters_kKeyWord @"keyWord"
#define SearchArticleParameters_kPopulation_type @"population_type"
#define SearchArticleParameters_kAuthorId @"authorId"

//=======================================================================

@interface SearchResultViewController ()<SearchResultFactorViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) SearchResultFactorView *factorView;
@property (nonatomic, strong) SearchResultFactorShowModel *productFactorShowModel;
@property (nonatomic, strong) SearchResultFactorShowModel *storeFactorShowModel;

@property (nonatomic, weak) UISegmentedControl *sg;
@property (nonatomic, weak) UIScrollView *scv;
@property (nonatomic, weak) UITableView *tv1;
@property (nonatomic, weak) UITableView *tv2;
@property (nonatomic, weak) UITableView *tv3;
@property (nonatomic, weak) UIButton *locationButton;

@property (nonatomic, assign) BOOL tv1HaveRefreshed;
@property (nonatomic, assign) BOOL tv2HaveRefreshed;
@property (nonatomic, assign) NSUInteger tv1Page;
@property (nonatomic, assign) NSUInteger tv2Page;
@property (nonatomic, assign) NSUInteger tv3page;
@property (nonatomic, strong) NSMutableArray<SearchResultProductItem *> *ary1;
@property (nonatomic, strong) NSMutableArray<SearchResultStoreItem *> *ary2;
@property (nonatomic, strong) NSMutableArray<SearchResultArticleItem *> *ary3;
@end

@implementation SearchResultViewController

static NSString *const productCellReuseIndentifier = @"SearchResultProductCell";
static NSString *const storeCellReuseIndentifier = @"SearchResultStoreCell";
static NSString *const articleCellReuseIndentifier = @"SearchResultArticleCell";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.pageId = 10202;
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    switch (self.searchType) {
        case SearchType_Product:
        case SearchType_Store:
        {
            [self prepareForProductOrStore];
        }
            break;
        case SearchType_Article:
        {
            [self prepareForArticle];
        }
            break;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    switch (self.searchType) {
        case SearchType_Product:
        case SearchType_Store:
        {
            [self resetLocation];
        }
            break;
        default:
            break;
    }
}

#pragma mark - ==================服务或门店==================

- (void)prepareForProductOrStore{
    
    self.ary1 = [NSMutableArray array];
    self.ary2 = [NSMutableArray array];
    
    [self initTitleView];
    
    [self initTv1Tv2];
    
    [self initLocationButton];
    
    [self initFactorView];
    
    [[SearchResultFactorShowModelManager shareManager]loadSearchResultFactorDataCallBack:^(SearchResultFactorShowModel *productFactorShowModel, SearchResultFactorShowModel *storeFactorShowModel) {
        
        self.productFactorShowModel = productFactorShowModel;
        self.storeFactorShowModel = storeFactorShowModel;
        
        [self remakeSureSearchResultFactorShowModel];
        [self reSetScrollViewContentOffsetState];
    }];
    
    [NotificationCenter addObserver:self selector:@selector(resetLocation) name:kUserLocationHasChangedNotification object:nil];
}

- (void)initTitleView{
    
    UISegmentedControl *sg = [[UISegmentedControl alloc]initWithItems:@[@" 服务   ",@"门店    "]];
    
    sg.frame = CGRectMake(0, 0, 180, 32);
    [sg addTarget:self action:@selector(sgDidChangedSelectedIndex:) forControlEvents:UIControlEventValueChanged];
    [sg setTintColor:[UIColor whiteColor]];
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                                 NSForegroundColorAttributeName:[UIColor whiteColor]};
    [sg setTitleTextAttributes:attributes forState:UIControlStateNormal];
    NSDictionary *highlightedAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                                            NSForegroundColorAttributeName:COLOR_PINK};
    [sg setTitleTextAttributes:highlightedAttributes forState:UIControlStateSelected];
    self.navigationItem.titleView = sg;
    self.sg = sg;
}

- (void)initFactorView{
    
    SearchResultFactorView *factorView = [[SearchResultFactorView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SearchResultFactorTopViewHight)];
    [self.view addSubview:factorView];
    self.factorView = factorView;
    factorView.delegate = self;
}

- (void)initTv1Tv2{
    
    UIScrollView *scv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    scv.showsVerticalScrollIndicator = NO;
    scv.showsHorizontalScrollIndicator = NO;
    scv.pagingEnabled = YES;
    scv.bounces = YES;
    scv.delegate = self;
    scv.scrollsToTop = NO;
    [self.view addSubview:scv];
    self.scv = scv;
    
    CGRect scv_bounds = scv.bounds;
    
    UITableView *tv1 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, scv_bounds.size.height) style:UITableViewStyleGrouped];
    tv1.contentInset = UIEdgeInsetsMake(64+SearchResultFactorTopViewHight, 0, MapAddrViewHeight, 0);
    tv1.scrollIndicatorInsets = tv1.contentInset;
    tv1.delegate = self;
    tv1.dataSource = self;
    tv1.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tv1 registerNib:[UINib nibWithNibName:@"SearchResultProductCell" bundle:nil] forCellReuseIdentifier:productCellReuseIndentifier];
    [scv addSubview:tv1];
    self.tv1 = tv1;
    
    scv_bounds.origin.y = SCREEN_WIDTH;
    UITableView *tv2 = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, scv_bounds.size.height) style:UITableViewStyleGrouped];
    tv2.contentInset = UIEdgeInsetsMake(64+SearchResultFactorTopViewHight, 0, MapAddrViewHeight, 0);
    tv2.scrollIndicatorInsets = tv2.contentInset;
    tv2.delegate = self;
    tv2.dataSource = self;
    tv2.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tv2 registerNib:[UINib nibWithNibName:@"SearchResultStoreCell" bundle:nil] forCellReuseIdentifier:storeCellReuseIndentifier];
    [scv addSubview:tv2];
    self.tv2 = tv2;
    
    scv.contentSize = CGSizeMake(SCREEN_WIDTH * 2, 0);
    WeakSelf(self)
    MJRefreshHeader *tv1_header = [RefreshHeader headerWithRefreshingBlock:^{
        StrongSelf(self)
        [self getAry1Refresh:YES];
    }];
    tv1_header.automaticallyChangeAlpha = YES;
    self.tv1.mj_header = tv1_header;
    
    MJRefreshFooter *tv1_footer = [RefreshFooter footerWithRefreshingBlock:^{
        StrongSelf(self)
        [self getAry1Refresh:NO];
    }];
    tv1_footer.automaticallyChangeAlpha = YES;
    self.tv1.mj_footer = tv1_footer;
    
    MJRefreshHeader *tv2_header = [RefreshHeader headerWithRefreshingBlock:^{
        StrongSelf(self)
        [self getAry2Refresh:YES];
    }];
    tv2_header.automaticallyChangeAlpha = YES;
    self.tv2.mj_header = tv2_header;
    
    MJRefreshFooter *tv2_footer = [RefreshFooter footerWithRefreshingBlock:^{
        StrongSelf(self)
        [self getAry2Refresh:NO];
    }];
    tv2_footer.automaticallyChangeAlpha = YES;
    self.tv2.mj_footer = tv2_footer;
}

- (void)initLocationButton{
    
    SearchResultViewLocationButton *locationButton = [[SearchResultViewLocationButton alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-MapAddrViewHeight, SCREEN_WIDTH, MapAddrViewHeight)];
    [self.view addSubview:locationButton];
    self.locationButton = locationButton;
    [locationButton addTarget:self action:@selector(locationButtonClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)sgDidChangedSelectedIndex:(UISegmentedControl *)sg{
    
    if (sg.selectedSegmentIndex == 0) {
        if (self.scv.contentOffset.x != 0)
            [self.scv setContentOffset:CGPointMake(0, 0) animated:YES];
    }else{
        if (self.scv.contentOffset.x != SCREEN_WIDTH)
            [self.scv setContentOffset:CGPointMake(SCREEN_WIDTH, 0) animated:YES];
    }
}

- (void)locationButtonClick:(UIButton *)btn{

    MapLocateViewController *controller = [[MapLocateViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (void)resetLocation{
    
    NSString *locationString = [KTCMapService shareKTCMapService].currentLocation.locationDescription;
    if ([locationString length] == 0) {
        [self.locationButton setImage:[UIImage imageNamed:@"unlocated"] forState:UIControlStateNormal];
        [self.locationButton setTitle:@"还没有定位哦..." forState:UIControlStateNormal];
    } else {
        [self.locationButton setImage:[UIImage imageNamed:@"located"] forState:UIControlStateNormal];
        [self.locationButton setTitle:locationString forState:UIControlStateNormal];
    }
}

- (void)dealloc{
    [NotificationCenter removeObserver:self];
    [[KTCMapService shareKTCMapService] startUpdateLocation];
}

- (void)remakeSureSearchResultFactorShowModel{
    if (self.searchParmsModel) {
        switch (self.searchType) {
            case SearchType_Product:
            {
                [self remakeSureSearchResultFactorShowModel:self.productFactorShowModel];
            }
                break;
            case SearchType_Store:
            {
                [self remakeSureSearchResultFactorShowModel:self.storeFactorShowModel];
            }
                break;
            default:
                break;
        }
    }
}

- (void)remakeSureSearchResultFactorShowModel:(SearchResultFactorShowModel *)model{
    
    SearchParmsProductOrStoreModel *searchParmsModel = (SearchParmsProductOrStoreModel *)self.searchParmsModel;
    NSString *area = searchParmsModel.s;//地区
    NSString *sort = searchParmsModel.st;//排序
    NSString *age = searchParmsModel.a;//年龄
    NSString *category = [NSString stringWithFormat:@"%zd",searchParmsModel.c];//分类
    
    NSArray<SearchResultFactorTopItem *> *topItems = model.items;
    for (int k = 0; k<topItems.count; k++) {
        SearchResultFactorTopItem *topItem = topItems[k];
        SearchResultFactorItem *firstSelectedSubItem = [SearchResultFactorItem firstSelectedSubItem:topItem];
        NSArray<NSArray<SearchResultFactorItem *> *> *subArrays = topItem.subArrays;
        for (int m = 0; m<subArrays.count; m++) {
            NSArray<SearchResultFactorItem *> *subArray = subArrays[m];
            for (int n = 0; n<subArray.count; n++) {
                SearchResultFactorItem *item = subArray[n];
                switch (topItem.type) {
                    case SearchResultFactorTopItemTypeArea:
                    {
                        [self makeSureSelectedWithValue:area item:item superItem:nil firstSelectedSubItem:firstSelectedSubItem];
                    }
                        break;
                    case SearchResultFactorTopItemTypeSort:
                    {
                        [self makeSureSelectedWithValue:sort item:item superItem:nil firstSelectedSubItem:firstSelectedSubItem];
                    }
                        break;
                    case SearchResultFactorTopItemTypeFilter:
                    {
                        NSArray<NSArray<SearchResultFactorItem *> *> *subArraysV2 = item.subArrays;
                        for (int i = 0; i<subArraysV2.count; i++) {
                            NSArray<SearchResultFactorItem *> *subArrayV2 = subArraysV2[i];
                            for (int j = 0; j<subArrayV2.count; j++) {
                                SearchResultFactorItem *itemv2 = subArrayV2[j];
                                if (m==0) {
                                    [self makeSureSelectedWithValue:age item:itemv2 superItem:item firstSelectedSubItem:firstSelectedSubItem];
                                }else if (m==1){
                                    [self makeSureSelectedWithValue:category item:itemv2 superItem:item firstSelectedSubItem:firstSelectedSubItem];
                                }
                            }
                        }
                    }
                        break;
                }
            }
        }
    }
}

- (void)makeSureSelectedWithValue:(NSString *)value
                             item:(SearchResultFactorItem *)item
                        superItem:(SearchResultFactorItem *)superItem
             firstSelectedSubItem:(SearchResultFactorItem *)firstSelectedSubItem{
    
    if ([value isEqualToString:item.value] && item.value.length>0) {
        if (firstSelectedSubItem) {
            firstSelectedSubItem.selected = NO;
            firstSelectedSubItem.makeSureSelected = NO;
        }
        item.selected = YES;
        item.makeSureSelected = YES;
        if (superItem) {
            superItem.selected = YES;
            superItem.makeSureSelected = YES;
        }
    }
}

- (void)reSetScrollViewContentOffsetState{
    
    switch (self.searchType) {
        case SearchType_Product:
        {
            self.scv.contentOffset = CGPointMake(0, 0);
        }
            break;
        case SearchType_Store:
        {
            self.scv.contentOffset = CGPointMake(SCREEN_WIDTH, 0);
        }
            break;
        default:
            break;
    }
    [self scrollViewDidScroll:self.scv];
}

- (NSDictionary *)factorDic{
    
    __block NSString *area = @"";
    __block NSString *sort = @"";
    __block NSString *age = @"";
    __block NSString *category = @"";
    
    NSArray<SearchResultFactorTopItem *> *topItems = self.factorView.model.items;
    for (int k = 0; k<topItems.count; k++) {
        SearchResultFactorTopItem *topItem = topItems[k];
        NSArray<NSArray<SearchResultFactorItem *> *> *subArrays = topItem.subArrays;
        for (int m = 0; m<subArrays.count; m++) {
            NSArray<SearchResultFactorItem *> *subArray = subArrays[m];
            for (int n = 0; n<subArray.count; n++) {
                SearchResultFactorItem *item = subArray[n];
                if (item.makeSureSelected) {
                    switch (topItem.type) {
                        case SearchResultFactorTopItemTypeArea:
                        {
                            if (item.value.length>0) area = item.value;
                        }
                            break;
                        case SearchResultFactorTopItemTypeSort:
                        {
                            if (item.value.length>0) sort = item.value;
                        }
                            break;
                        case SearchResultFactorTopItemTypeFilter:
                        {
                            NSArray<NSArray<SearchResultFactorItem *> *> *subArraysV2 = item.subArrays;
                            for (int i = 0; i<subArraysV2.count; i++) {
                                NSArray<SearchResultFactorItem *> *subArrayV2 = subArraysV2[i];
                                for (int j = 0; j<subArrayV2.count; j++) {
                                    SearchResultFactorItem *itemv2 = subArrayV2[j];
                                    if (itemv2.makeSureSelected) {
                                        if (m==0) {
                                            if (itemv2.value.length>0) age = itemv2.value;
                                        }else if (m==1){
                                            if (itemv2.value.length>0) category = itemv2.value;
                                        }
                                    }
                                }
                            }
                        }
                            break;
                    }
                }
            }
        }
    }
    NSDictionary *factorDic = @{SearchParameters_kArea:area,
                                SearchParameters_kSort:sort,
                                SearchParameters_kAge:age,
                                SearchParameters_kCategory:category};
    return factorDic;
}

- (NSDictionary *)parametersRefresh:(BOOL)refresh
                               page:(NSUInteger)page
                       usePageBlock:(void (^)(NSUInteger usedPage))usePageBlock{
    if (refresh) {
        page = 1;
    }else{
        page ++;
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithDictionary:self.factorDic];
    
    [parameters setValue:@(page) forKey:SearchParameters_kPage];
    [parameters setValue:@(COUNT) forKey:SearchParameters_kPageSize];
    [parameters setValue:@(self.searchType) forKey:SearchParameters_kType];
    [parameters setValue:self.keywords forKey:SearchParameters_kKeywords];
    [parameters setValue:self.mapaddr forKey:SearchParameters_kMapaddr];
    
    usePageBlock(page);
    
    return parameters;
}

- (NSString *)keywords{
    NSString *keywords = @"";
    if (self.searchParmsModel.k.length>0) keywords = self.searchParmsModel.k;
    return keywords;
}

- (NSString *)mapaddr{
    NSString *mapaddr = @"";
    switch (self.searchType) {
        case SearchType_Product:
        case SearchType_Store:
        {
            SearchParmsProductOrStoreModel *searchParmsModel = (SearchParmsProductOrStoreModel *)self.searchParmsModel;
            if (searchParmsModel.mapaddr.length>0) mapaddr = searchParmsModel.mapaddr;
        }
            break;
        default:
            break;
    }
    if (mapaddr.length==0) mapaddr = [KTCMapService shareKTCMapService].currentLocationString;
    
    return mapaddr;
}

- (void)getAry1Refresh:(BOOL)refresh{
    if (refresh) self.tv1HaveRefreshed = YES;
    
    [self loadAry1Ary2DataRefresh:refresh tableView:self.tv1 page:self.tv1Page sueeessCallBack:^(NSArray *ary) {
        if (refresh) {
            self.ary1 = [NSMutableArray arrayWithArray:ary];
        }else{
            [self.ary1 addObjectsFromArray:ary];
        }
        [self loadSuccessTableView:self.tv1 dataAry:ary ary:self.ary1];
    } failueCallBack:^{
        [self loadFailureTableView:self.tv1 ary:self.ary1];
    } usedPageBlock:^(NSUInteger usedPage) {
        self.tv1Page = usedPage;
    }];
}

- (void)getAry2Refresh:(BOOL)refresh{
    if (refresh) self.tv2HaveRefreshed = YES;
    
    [self loadAry1Ary2DataRefresh:refresh tableView:self.tv2 page:self.tv2Page sueeessCallBack:^(NSArray *ary) {
        if (refresh) {
            self.ary2 = [NSMutableArray arrayWithArray:ary];
        }else{
            [self.ary2 addObjectsFromArray:ary];
        }
        [self loadSuccessTableView:self.tv2 dataAry:ary ary:self.ary2];
    } failueCallBack:^{
        [self loadFailureTableView:self.tv2 ary:self.ary2];
    } usedPageBlock:^(NSUInteger usedPage) {
        self.tv2Page = usedPage;
    }];
}

- (void)loadAry1Ary2DataRefresh:(BOOL)refresh
              tableView:(UITableView *)tableView
                   page:(NSUInteger)page
        sueeessCallBack:(void(^)(NSArray *ary))sueeessCallBack
         failueCallBack:(void(^)())failueCallBack
          usedPageBlock:(void(^)(NSUInteger usedPage))usedPageBlock{
    
    
    NSDictionary *param = [self parametersRefresh:refresh
                                                  page:page
                                          usePageBlock:^(NSUInteger usedPage) {
                                              usedPageBlock(usedPage);
                                          }];
    WeakSelf(self);
    [Request startWithName:@"SEARCH_SEARCH" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        StrongSelf(self);
        NSArray *ary = nil;
        if (tableView==self.tv1) {
            SearchResultProductModel *productModel = [SearchResultProductModel modelWithDictionary:dic];
            ary = productModel.data;
        }else{
            SearchResultStoreModel *storeModel = [SearchResultStoreModel modelWithDictionary:dic];
            ary = storeModel.data;
        }
        sueeessCallBack(ary);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (error.code == -2001) {
            sueeessCallBack(nil);
        }else{
            failueCallBack();
        }
    }];
    
}

#pragma mark - SearchResultFactorViewDelegate

- (void)factorViewDidMakeSureData:(SearchResultFactorView *)factorView{
    
    switch (self.searchType) {
        case SearchType_Product:
        {
            [self.tv1.mj_header beginRefreshing];
        }
            break;
        case SearchType_Store:
        {
            [self.tv2.mj_header beginRefreshing];
        }
            break;
        default:
            break;
    }
    NSMutableDictionary *params = [@{@"searchType":@(self.searchType)} mutableCopy];
    [BuryPointManager trackEvent:@"event_result_search_filter" actionId:20204 params:params];
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == self.scv) {
        CGFloat x = self.scv.contentOffset.x;
        if (x == 0){//服务
            if (self.sg.selectedSegmentIndex != 0) self.sg.selectedSegmentIndex = 0;
            if (self.factorView.model != self.productFactorShowModel) self.factorView.model = self.productFactorShowModel;
            if (self.searchType != SearchType_Product) self.searchType = SearchType_Product;
            if (!self.tv1HaveRefreshed && self.ary1.count<=0) [self.tv1.mj_header beginRefreshing];
            if (self.tv2.scrollsToTop) self.tv2.scrollsToTop = NO;
            if (!self.tv1.scrollsToTop) self.tv1.scrollsToTop = YES;
        }else if (x==SCREEN_WIDTH){//门店
            if (self.sg.selectedSegmentIndex != 1) self.sg.selectedSegmentIndex = 1;
            if (self.factorView.model != self.storeFactorShowModel) self.factorView.model = self.storeFactorShowModel;
            if (self.searchType != SearchType_Store) self.searchType = SearchType_Store;
            if (!self.tv2HaveRefreshed &&self.ary2.count<=0) [self.tv2.mj_header beginRefreshing];
            if (self.tv1.scrollsToTop) self.tv1.scrollsToTop = NO;
            if (!self.tv2.scrollsToTop) self.tv2.scrollsToTop = YES;
        }
    }
}

#pragma mark - ====================资讯====================

- (void)prepareForArticle{
    
    self.navigationItem.title = @"资讯列表";
    
    self.ary3 = [NSMutableArray array];
    
    [self initTv3];
}

- (void)initTv3{
    
    UITableView *tv3 = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tv3.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    tv3.scrollIndicatorInsets = tv3.contentInset;
    tv3.delegate = self;
    tv3.dataSource = self;
    tv3.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tv3 registerNib:[UINib nibWithNibName:@"SearchResultArticleCell" bundle:nil] forCellReuseIdentifier:articleCellReuseIndentifier];
    [self.view addSubview:tv3];
    self.tv3 = tv3;
    
    WeakSelf(self)
    MJRefreshHeader *tv3_header = [RefreshHeader headerWithRefreshingBlock:^{
        StrongSelf(self)
        [self getAry3Refresh:YES];
    }];
    tv3_header.automaticallyChangeAlpha = YES;
    tv3.mj_header = tv3_header;
    
    MJRefreshFooter *tv3_footer = [RefreshFooter footerWithRefreshingBlock:^{
        StrongSelf(self)
        [self getAry3Refresh:NO];
    }];
    tv3_footer.automaticallyChangeAlpha = YES;
    tv3.mj_footer = tv3_footer;
    
    [tv3.mj_header beginRefreshing];
}

- (NSDictionary *)parameters{
    
    SearchParmsArticleModel *model = (SearchParmsArticleModel *)self.searchParmsModel;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    [parameters setValue:@(self.tv3page) forKey:SearchParameters_kPage];
    [parameters setValue:@(COUNT) forKey:SearchArticleParameters_kPageCount];
    if (model.ak != 0) [parameters setValue:[NSString stringWithFormat:@"%zd",model.ak] forKey:SearchArticleParameters_kArticleKind];
    if (model.t != 0) [parameters setValue:[NSString stringWithFormat:@"%zd",model.t] forKey:SearchArticleParameters_kTagId];
    if (model.k.length>0) [parameters setValue:model.k forKey:SearchArticleParameters_kKeyWord];
    if (model.p.length>0) [parameters setValue:model.p forKey:SearchArticleParameters_kPopulation_type];
    if (model.a.length>0) [parameters setValue:model.a forKey:SearchArticleParameters_kAuthorId];
    return parameters;
}

- (void)getAry3Refresh:(BOOL)refresh{
    
    if (refresh) {
        self.tv3page = 1;
    }else{
        self.tv3page ++;
    }
    [Request startWithName:@"ARTICLE_GET_LIST" param:self.parameters progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        SearchResultArticleModel *model = [SearchResultArticleModel modelWithDictionary:dic];
        if (refresh) {
            self.ary3 = [NSMutableArray arrayWithArray:model.data];
        }else{
            [self.ary3 addObjectsFromArray:model.data];
        }
        [self loadSuccessTableView:self.tv3 dataAry:model.data ary:self.ary3];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self loadFailureTableView:self.tv3 ary:self.ary3];
    }];
}

#pragma mark - ===================公用方法===================

- (void)loadSuccessTableView:(UITableView *)tableView dataAry:(NSArray *)dataAry ary:(NSArray *)ary{
    [tableView reloadData];
    [self dealWithHeaderFooterTableView:tableView ary:ary];
    if (dataAry.count<COUNT) {
        [tableView.mj_footer endRefreshingWithNoMoreData];
    }
}

- (void)loadFailureTableView:(UITableView *)tableView ary:(NSArray *)ary{
    [self dealWithHeaderFooterTableView:tableView ary:ary];
}

- (void)dealWithHeaderFooterTableView:(UITableView *)tableView ary:(NSArray *)ary{
    
    [tableView.mj_header endRefreshing];
    [tableView.mj_footer endRefreshing];
    
    if ([ary count] <= 0) {
        tableView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, tableView.frame.size.height) image:nil description:@"啥都木有啊···" needGoHome:NO];
    } else {
        tableView.backgroundView = nil;
    }
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSUInteger sections = 0;
    if (tableView == self.tv1) {
        sections = self.ary1.count;
    }else if (tableView == self.tv2) {
        sections = self.ary2.count;
    }else{
        sections = self.ary3.count;
    }
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
#define SECTION_MARGIN_HEIGHT 8
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return SECTION_MARGIN_HEIGHT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    NSUInteger sections = 0;
    if (tableView == self.tv1) {sections = self.ary1.count;}else
    if (tableView == self.tv2) {sections = self.ary2.count;}else{sections = self.ary3.count;}
    return (section == sections-1)?SECTION_MARGIN_HEIGHT:0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height = 0;
    if (tableView == self.tv1) {
        SearchResultProductItem *item = self.ary1[indexPath.section];
        height = item.cellHeight;
    }else if (tableView == self.tv2) {
        SearchResultStoreItem *item = self.ary2[indexPath.section];
        height = item.cellHeight;
    }else{
        //SearchResultArticleItem *item = self.ary3[indexPath.row];
        //height = item.cellHeight;
        height = 104;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.tv1) {
        SearchResultProductCell *cell = [tableView dequeueReusableCellWithIdentifier:productCellReuseIndentifier];
        cell.item = self.ary1[indexPath.section];
        return cell;
    }else if (tableView == self.tv2) {
        SearchResultStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:storeCellReuseIndentifier];
        cell.item = self.ary2[indexPath.section];
        return cell;
    }else{
        SearchResultArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:articleCellReuseIndentifier];
        cell.item = self.ary3[indexPath.section];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView == self.tv1) {
        SearchResultProductItem *item = self.ary1[indexPath.section];
        if (![item.serveId isNotNull]) {
            [[iToast makeText:@"无效的服务信息"] show];
            return;
        }
        if (![item.channelId isNotNull]) {
            item.channelId = @"0";
        }
        ProductDetailViewController *controller = [[ProductDetailViewController alloc] initWithServiceId:item.serveId channelId:item.channelId];
        [self.navigationController pushViewController:controller animated:YES];
        
        NSDictionary *params = @{@"pid":item.serveId,
                                 @"cid":item.channelId};
        [BuryPointManager trackEvent:@"event_skip_search_serve" actionId:20202 params:params];
    }else if (tableView == self.tv2) {
        SearchResultStoreItem *item = self.ary2[indexPath.section];
        if (![item.storeId isNotNull]) {
            [[iToast makeText:@"无效的门店信息"] show];
            return;
        }
        StoreDetailViewController *controller = [[StoreDetailViewController alloc] initWithStoreId:item.storeId];
        [self.navigationController pushViewController:controller animated:YES];
        
        NSDictionary *params = @{@"sid":item.storeId};
        [BuryPointManager trackEvent:@"event_skip_search_store" actionId:20203 params:params];
    }else{
        SearchResultArticleItem *item = self.ary3[indexPath.row];
        if (item.linkUrl.length<=0) {
            [[iToast makeText:@"无效的资讯信息"] show];
            return;
        }
        WebViewController *controller = [[WebViewController alloc] init];
        controller.urlString = item.linkUrl;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

@end
