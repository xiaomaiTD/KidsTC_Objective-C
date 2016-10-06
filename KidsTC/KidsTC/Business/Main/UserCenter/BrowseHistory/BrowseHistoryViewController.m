//
//  BrowseHistoryViewController.m
//  KidsTC
//
//  Created by 平 on 16/3/9.
//  Copyright © 2016年 KidsTC. All rights reserved.
//

#import "BrowseHistoryViewController.h"
#import "KTCBrowseHistoryManager.h"
#import "KTCEmptyDataView.h"
#import "GHeader.h"
#import "KTCMapService.h"
#import "MTA.h"
//服务
#import "ServiceListViewCell.h"
#import "ServiceListItemModel.h"
#import "ServiceDetailViewController.h"

//门店
#import "StoreListItemModel.h"
#import "StoreListViewCell.h"
#import "StoreDetailViewController.h"

static NSString *const serviceCellIdentifier = @"ServiceListViewCell";
static NSString *const storeCellIdentifier = @"StoreListViewCell";

#define pagecount @(10)

@interface BrowseHistoryViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UISegmentedControl *segmentControl;
@property (nonatomic, assign) KTCBrowseHistoryType browseHistoryType;

//服务
@property (nonatomic, strong) NSMutableArray *serviceAry;
@property (nonatomic, assign) NSUInteger serviceCurrentPage;

//门店
@property (nonatomic, strong) NSMutableArray *storeAry;
@property (nonatomic, assign) NSUInteger storeCurrentPage;

@property (nonatomic, copy) NSString *userLocation;
@end

@implementation BrowseHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.serviceAry = [NSMutableArray new];
    self.storeAry = [NSMutableArray new];
    
    [self initUI];
    
    [self segmentControlDidChangedSelectedIndex:0];
    
    //监听用户地理位置改变通知
    [NotificationCenter addObserver:self selector:@selector(resetLocation) name:kUserLocationHasChangedNotification object:nil];
}


//初始化界面
- (void)initUI{
    
    self.segmentControl = [[UISegmentedControl alloc]initWithItems:@[@"   服务    ",@"   门店    "]];
    [self.segmentControl addTarget:self action:@selector(segmentControlDidChangedSelectedIndex:) forControlEvents:UIControlEventValueChanged];
    [self.segmentControl setSelectedSegmentIndex:0];
    [self.segmentControl setTintColor:[UIColor whiteColor]];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [self.segmentControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:COLOR_PINK forKey:NSForegroundColorAttributeName];
    [self.segmentControl setTitleTextAttributes:highlightedAttributes forState:UIControlStateSelected];
    self.navigationItem.titleView = self.segmentControl;
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ServiceListViewCell class]) bundle:nil] forCellReuseIdentifier:serviceCellIdentifier];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([StoreListViewCell class]) bundle:nil] forCellReuseIdentifier:storeCellIdentifier];
    WeakSelf(self)
    RefreshHeader *mj_header = [RefreshHeader headerWithRefreshingBlock:^{
        StrongSelf(self)
        [self loadDataForNew:YES];
    }];
    mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_header = mj_header;
    
    RefreshFooter *mj_footer = [RefreshFooter footerWithRefreshingBlock:^{
        StrongSelf(self)
        [self loadDataForNew:NO];
    }];
    mj_footer.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer = mj_footer;
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self resetLocation];
}

- (void)segmentControlDidChangedSelectedIndex:(UISegmentedControl *)segmentControl{

    if (segmentControl.selectedSegmentIndex == 0) {
        self.browseHistoryType = KTCBrowseHistoryTypeService;
        if (self.serviceAry.count == 0 ) {
            [self loadDataForNew:YES];
            
        }else{
            self.tableView.backgroundView = nil;
            [self.tableView reloadData];
        }
        
    }else if (segmentControl.selectedSegmentIndex == 1){
        self.browseHistoryType = KTCBrowseHistoryTypeStore;
        
        if (self.storeAry.count == 0 ) {
            [self loadDataForNew:YES];
            
        }else{
            self.tableView.backgroundView = nil;
            [self.tableView reloadData];
        }
    }
    
}


- (void)loadDataForNew:(BOOL)new{
    
    if (self.browseHistoryType == KTCBrowseHistoryTypeService) {//服务
        if (new) {
            self.serviceCurrentPage = 1;
        }else{
            self.serviceCurrentPage ++;
        }
        
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:pagecount,@"pagecount",@(self.serviceCurrentPage),@"page",@(self.browseHistoryType),@"type", nil];
        
        [Request startWithName:@"GET_BROWSE_HISTORY" param:params progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
            if (new) {
                [self.serviceAry removeAllObjects];
            }
            
            if (dic.count > 0) {
                NSArray *dataArray = [dic objectForKey:@"data"];
                if ([dataArray isKindOfClass:[NSArray class]] && [dataArray count] > 0) {
                    for (NSDictionary *singleService in dataArray) {
                        ServiceListItemModel *model = [[ServiceListItemModel alloc] initWithRawData:singleService];
                        if (model) {
                            [self.serviceAry addObject:model];
                        }
                    }
                    if (dataArray.count < [pagecount integerValue]) {
                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    }else{
                        [self.tableView.mj_footer endRefreshing];
                    }
                    
                }else{
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    [self.tableView.mj_footer setHidden:YES];
                }
                
            }else{
                [self.tableView.mj_footer setHidden:YES];
            }
            
            [self endRefreshing];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (new) {
                [self.serviceAry removeAllObjects];
            }
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            [self endRefreshing];
        }];
        
    }else if (self.browseHistoryType == KTCBrowseHistoryTypeStore){//门店
        if (new) {
            self.storeCurrentPage = 1;
        }else{
            self.storeCurrentPage ++;
        }
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:pagecount,@"pagecount",@(self.storeCurrentPage),@"page",@(self.browseHistoryType),@"type", nil];
        
        if (self.userLocation && ![self.userLocation isEqualToString:@""]) {
            [params setValue:self.userLocation forKey:@"mapaddress"];
        }
        [Request startWithName:@"GET_BROWSE_HISTORY" param:params progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
            if (new) {
                [self.storeAry removeAllObjects];
            }
            
            if (dic.count > 0) {
                NSArray *dataArray = [dic objectForKey:@"data"];
                if ([dataArray isKindOfClass:[NSArray class]] && [dataArray count] > 0) {
                    for (NSDictionary *singleStore in dataArray) {
                        StoreListItemModel *model = [[StoreListItemModel alloc] initWithRawData:singleStore];
                        if (model) {
                            [self.storeAry addObject:model];
                        }
                    }
                    if (dataArray.count < [pagecount integerValue]) {
                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    }else{
                        [self.tableView.mj_footer endRefreshing];
                    }
                    
                }else{
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    [self.tableView.mj_footer setHidden:YES];
                }
                
            }else{
                [self.tableView.mj_footer setHidden:YES];
            }
            
            [self endRefreshing];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (new) {
                [self.storeAry removeAllObjects];
            }
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            [self endRefreshing];
        }];
    }
}

- (void)endRefreshing{
    
    if (self.browseHistoryType == KTCBrowseHistoryTypeService) {//服务
        if (self.serviceAry.count == 0) {
            
            self.tableView.backgroundView = [[KTCEmptyDataView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.tableView.frame.size.height) image:nil description:@"啥都木有啊···" needGoHome:YES];
        }else{
            self.tableView.backgroundView = nil;
        }
    }else if (self.browseHistoryType == KTCBrowseHistoryTypeStore){//门店
        if (self.storeAry.count == 0) {
            self.tableView.backgroundView = [[KTCEmptyDataView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.tableView.frame.size.height) image:nil description:@"啥都木有啊···" needGoHome:YES];
        }else{
            self.tableView.backgroundView = nil;
        }
    }
    

    [self.tableView.mj_header endRefreshing];
    [self.tableView reloadData];
    
}

#pragma mark UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.browseHistoryType == KTCBrowseHistoryTypeService) {//服务
        return [self.serviceAry count];
    }else{//门店
        return [self.storeAry count];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.browseHistoryType == KTCBrowseHistoryTypeService) {//服务
        ServiceListItemModel *model = nil;
        if (indexPath.row<self.serviceAry.count) {
            model = [self.serviceAry objectAtIndex:indexPath.row];
        }
        return [model cellHeight];
    }else{//门店
        StoreListItemModel *model = nil;
        if (indexPath.row<self.storeAry.count) {
            model = [self.storeAry objectAtIndex:indexPath.row];
        }
        
        return [model cellHeight];
    }
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.browseHistoryType == KTCBrowseHistoryTypeService) {//服务
        ServiceListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:serviceCellIdentifier forIndexPath:indexPath];

        ServiceListItemModel *model = [self.serviceAry objectAtIndex:indexPath.row];
        [cell configWithItemModel:model];
        return cell;
    }else{//门店
        StoreListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:storeCellIdentifier forIndexPath:indexPath];
        StoreListItemModel *model = [self.storeAry objectAtIndex:indexPath.row];
        [cell configWithItemModel:model];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (self.browseHistoryType == KTCBrowseHistoryTypeService) {//服务
        ServiceListItemModel *model = [self.serviceAry objectAtIndex:indexPath.row];
        ServiceDetailViewController *controller = [[ServiceDetailViewController alloc] initWithServiceId:model.identifier channelId:model.channelId];
        [controller setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:controller animated:YES];
        //MTA
        [MTA trackCustomEvent:@"event_skip_search_result_dtl_service" args:nil];
    }else{//门店
        StoreListItemModel *model = [self.storeAry objectAtIndex:indexPath.row];
        StoreDetailViewController *controller = [[StoreDetailViewController alloc] initWithStoreId:model.identifier];
        [controller setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:controller animated:YES];
        //MTA
        [MTA trackCustomEvent:@"event_skip_search_result_dtl_store" args:nil];
    }
}

#pragma mark - 用户地理位置改变通知
- (void)resetLocation {
    CLLocation *location = [KTCMapService shareKTCMapService].currentLocation.location;
    CLLocationCoordinate2D coordinate2D = location.coordinate;
    self.userLocation = [NSString stringWithFormat:@"%f,%f",coordinate2D.longitude,coordinate2D.latitude];
}

- (void)dealloc{
    [NotificationCenter removeObserver:self name:kUserLocationHasChangedNotification object:nil];
}

@end
