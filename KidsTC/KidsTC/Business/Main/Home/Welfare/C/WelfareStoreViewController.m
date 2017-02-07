//
//  WelfareStoreViewController.m
//  KidsTC
//
//  Created by zhanping on 7/22/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "WelfareStoreViewController.h"
#import "WelfareStoreHospitalCell.h"
#import "WelfareStoreLoveHouseCell.h"
#import "RefreshHeader.h"
#import "RefreshFooter.h"
#import "GHeader.h"
#import "KTCMapService.h"
#import "KTCMapUtil.h"
#import "RouteAnnotation.h"
#import "WelfareStoreModel.h"
#import "UIBarButtonItem+Category.h"
#import "SearchResultViewController.h"
#import "MapRouteViewController.h"
#import "WelfareStoreLoveHouseAnnotationTipView.h"
#import "WelfareStoreHospitalAnnotationTipView.h"

#define pageCount 10

@interface WelfareStoreViewController ()<UITableViewDelegate,UITableViewDataSource,BMKMapViewDelegate,WelfareStoreHospitalCellDelegate,WelfareStoreLoveHouseCellDelegate,WelfareStoreLoveHouseAnnotationTipViewDelegate,WelfareStoreHospitalAnnotationTipViewDelegate>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<WelfareStoreItem *> *ary;
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, weak) BMKMapView *mapView;
@end

static NSString *const WelfareStoreHospitalCellID = @"WelfareStoreHospitalCellID";
static NSString *const WelfareStoreLoveHouseCellID = @"WelfareStoreLoveHouseCellID";
@implementation WelfareStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    switch (self.type) {
        case WelfareTypeHospital:
        {
            self.pageId = 11104;
        }
            break;
        case WelfareTypeLoveHouse:
        {
            self.pageId = 11103;
        }
            break;
    }
    
    self.ary = [NSMutableArray array];
    
    [self initui];
}

- (void)initui{
    
    NSString *title = @"";
    switch (self.type) {
        case WelfareTypeHospital:
        {
            title = @"保健室";
        }
            break;
        case WelfareTypeLoveHouse:
        {
            title = @"爱心妈咪小屋";
        }
            break;
    }
    self.navigationItem.title = title;
    
    [self initNaviBarItem];
    
    [self initTableView];
    
    [self initMapView];
    
    [KTCMapService shareKTCMapService].needToCheckServiceOnLine = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.mapView viewWillAppear];
    self.mapView.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.mapView viewWillDisappear];
    self.mapView.delegate = nil;
}

- (void)dealloc {
    [KTCMapUtil cleanMap:self.mapView];
    if (self.mapView) {
        self.mapView = nil;
    }
}

- (void)initNaviBarItem{
    
    self.navigationItem.rightBarButtonItem =
    [UIBarButtonItem itemWithImagePostion:UIBarButtonPositionRight target:self action:@selector(didClickRightBarButtonItem:) andGetButton:^(UIButton *btn) {
        [btn setImage:[UIImage imageNamed:@"navigation_locate"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"navigation_list"] forState:UIControlStateSelected];
    }];
}

- (void)initTableView{
    
    UITableView *tablView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
                                                        style:UITableViewStyleGrouped];
    tablView.delegate = self;
    tablView.dataSource = self;
    tablView.showsVerticalScrollIndicator = NO;
    tablView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tablView registerNib:[UINib nibWithNibName:@"WelfareStoreHospitalCell" bundle:nil] forCellReuseIdentifier:WelfareStoreHospitalCellID];
    [tablView registerNib:[UINib nibWithNibName:@"WelfareStoreLoveHouseCell" bundle:nil] forCellReuseIdentifier:WelfareStoreLoveHouseCellID];
    [self.view addSubview:tablView];
    self.tableView = tablView;
    
    WeakSelf(self)
    RefreshHeader *mj_header = [RefreshHeader headerWithRefreshingBlock:^{
        StrongSelf(self)
        [self loadDataRefresh:YES];
    }];
    mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_header = mj_header;
    
    RefreshFooter *mj_footer = [RefreshFooter footerWithRefreshingBlock:^{
        StrongSelf(self)
        [self loadDataRefresh:NO];
    }];
    mj_footer.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer = mj_footer;
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)initMapView{
    BMKMapView *mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    mapView.mapType = BMKMapTypeStandard;
    mapView.showsUserLocation = YES;
    mapView.isSelectedAnnotationViewFront = YES;
    mapView.showMapScaleBar = YES;
    mapView.mapScaleBarPosition = CGPointMake(4, SCREEN_HEIGHT-50);
    mapView.delegate = self;
    mapView.hidden = YES;
    [self.view addSubview:mapView];
    self.mapView = mapView;
}

- (void)loadDataRefresh:(BOOL)refresh{
    if (refresh) {
        self.page = 1;
    }else{
        self.page ++;
    }
    CLLocationCoordinate2D coordinate = [KTCMapService shareKTCMapService].currentLocation.location.coordinate;
    NSString *latitude = [NSString stringWithFormat:@"%f",coordinate.latitude];
    NSString *longitude = [NSString stringWithFormat:@"%f",coordinate.longitude];
    NSDictionary *param = @{@"type":@(self.type),
                            @"page":@(self.page),
                            @"pageCount":@(pageCount),
                            @"latitude":latitude,
                            @"longitude":longitude};
    [Request startWithName:@"WELFARE_GET" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        WelfareStoreModel *model = [WelfareStoreModel modelWithDictionary:dic];
        [self loadDataSuccessRefresh:refresh model:model];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self loadDataFailure];
    }];
}

- (void)loadDataSuccessRefresh:(BOOL)refresh model:(WelfareStoreModel *)model{
    [self dealWithHeaderFooter];
    
    if (refresh) {
        self.ary = [NSMutableArray arrayWithArray:model.data];
    }else{
        [self.ary addObjectsFromArray:model.data];
    }
    [self.tableView reloadData];
    
    if (model.data.count<1) [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

- (void)loadDataFailure{
    [self dealWithHeaderFooter];
}

- (void)dealWithHeaderFooter{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.ary.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (self.type) {
        case WelfareTypeHospital:
        {
            WelfareStoreItem *item = self.ary[indexPath.section];
            return item.cellHeight;
        }
            break;
        case WelfareTypeLoveHouse:
        {
            return 128;
        }
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section==0?0.01:8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (self.type) {
        case WelfareTypeHospital:
        {
            WelfareStoreHospitalCell *cell = [tableView dequeueReusableCellWithIdentifier:WelfareStoreHospitalCellID];
            cell.item = self.ary[indexPath.section];
            cell.delegate = self;
            return cell;
        }
            break;
        case WelfareTypeLoveHouse:
        {
            WelfareStoreLoveHouseCell *cell = [tableView dequeueReusableCellWithIdentifier:WelfareStoreLoveHouseCellID];
            cell.item = self.ary[indexPath.section];
            cell.delegate = self;
            return cell;
        }
            break;
    }
}

#pragma mark - WelfareStoreHospitalCellDelegate

- (void)welfareStoreHospitalCell:(WelfareStoreHospitalCell *)cell actionType:(WelfareStoreHospitalCellActionType)type{
    WelfareStoreItem *item = cell.item;
    switch (type) {
        case WelfareStoreHospitalCellActionTypePhone:
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", item.mobile]]];
            TCLog(@"item.mobile:%@",item.mobile);
        }
            break;
        case WelfareStoreHospitalCellActionTypeGoto:
        {
            [self gotoStoreWithCoordinate:item.coordinate2D];
        }
            break;
        case WelfareStoreHospitalCellActionTypeNearby:
        {
            [self nearbyStoreWithCoordinate:item.coordinate];
        }
            break;
    }
}

#pragma mark - WelfareStoreLoveHouseCellDelegate

- (void)welfareStoreLoveHouseCell:(WelfareStoreLoveHouseCell *)cell actionType:(WelfareStoreLoveHouseCellActionType)type{
     WelfareStoreItem *item = cell.item;
    switch (type) {
        case WelfareStoreLoveHouseCellActionTypeGoto:
        {
            [self gotoStoreWithCoordinate:item.coordinate2D];
        }
            break;
        case WelfareStoreLoveHouseCellActionTypeNearby:
        {
            [self nearbyStoreWithCoordinate:item.coordinate];
        }
            break;
    }
}


#pragma mark - didClickRightBarButtonItem

- (void)didClickRightBarButtonItem:(UIButton *)btn{
    btn.selected = !btn.selected;
    self.tableView.hidden = btn.selected;
    self.mapView.hidden = !btn.selected;
    if (!self.mapView.hidden) {
        [self resetMapViewAnnotations];
    }
}

- (void)resetMapViewAnnotations{
    [KTCMapUtil cleanMap:self.mapView];
    NSMutableArray *tempArray = [NSMutableArray array];
    [self.ary enumerateObjectsUsingBlock:^(WelfareStoreItem *obj, NSUInteger idx, BOOL *stop) {
        CLLocationCoordinate2D coordinate2D = obj.coordinate2D;
        if (CLLocationCoordinate2DIsValid(coordinate2D)) {
            RouteAnnotation *annotation = [[RouteAnnotation alloc]init];
            [annotation setCoordinate:coordinate2D];
            annotation.tag = idx;
            [self.mapView addAnnotation:annotation];
            [tempArray addObject:[[CLLocation alloc] initWithLatitude:coordinate2D.latitude longitude:coordinate2D.longitude]];
        }
    }];
    [KTCMapUtil resetMapView:self.mapView toFitLocations:tempArray];
}

#pragma mark - BMKMapViewDelegate

- (void)mapViewDidFinishLoading:(BMKMapView *)mapView {
    //指南针必须在加载完成后设置
    [self.mapView setCompassPosition:CGPointMake(SCREEN_WIDTH - 50, 70)];
}

static NSString *const annotationViewReuseIndentifier = @"annotationViewReuseIndentifier";
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation{
    BMKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:annotationViewReuseIndentifier];
    if (!annotationView) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewReuseIndentifier];
        annotationView.image = [KTCMapUtil poiAnnotationImage];
        annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    }
    annotationView.annotation = annotation;
    NSUInteger index = ((RouteAnnotation *)annotation).tag;
    if (self.ary.count>index) {
        switch (self.type) {
            case WelfareTypeHospital:
            {
                WelfareStoreHospitalAnnotationTipView *tipView = [[[NSBundle mainBundle] loadNibNamed:@"WelfareStoreHospitalAnnotationTipView" owner:self options:nil] firstObject];
                tipView.frame = CGRectMake(0, 0, 300, 150);
                tipView.delegate = self;
                tipView.item = self.ary[index];
                tipView.annotation = annotation;
                annotationView.paopaoView = [[BMKActionPaopaoView alloc]initWithCustomView:tipView];
            }
                break;
            case WelfareTypeLoveHouse:
            {
                WelfareStoreLoveHouseAnnotationTipView *tipView = [[[NSBundle mainBundle] loadNibNamed:@"WelfareStoreLoveHouseAnnotationTipView" owner:self options:nil] firstObject];
                tipView.frame = CGRectMake(0, 0, 216, 108);
                tipView.delegate = self;
                tipView.item = self.ary[index];
                tipView.annotation = annotation;
                annotationView.paopaoView = [[BMKActionPaopaoView alloc]initWithCustomView:tipView];
            }
            default:
                break;
        }
        //设置是否可以拖拽
        annotationView.draggable = NO;
    }
    
    return annotationView;
}

#pragma mark - WelfareStoreHospitalAnnotationTipViewDelegate

- (void)welfareStoreHospitalAnnotationTipView:(WelfareStoreHospitalAnnotationTipView *)view actionType:(WelfareStoreHospitalAnnotationTipViewActionType)type{
    [self.mapView deselectAnnotation:view.annotation animated:YES];
    WelfareStoreItem *item = view.item;
    switch (type) {
        case WelfareStoreHospitalAnnotationTipViewActionTypePhone:
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", item.mobile]]];
            TCLog(@"item.mobile:%@",item.mobile);
        }
            break;
        case WelfareStoreHospitalAnnotationTipViewActionTypeGoto:
        {
            [self gotoStoreWithCoordinate:item.coordinate2D];
        }
            break;
        case WelfareStoreHospitalAnnotationTipViewActionTypeNearby:
        {
            [self nearbyStoreWithCoordinate:item.coordinate];
        }
            break;
    }
}

#pragma mark - WelfareStoreLoveHouseAnnotationTipViewDelegate

- (void)welfareStoreLoveHouseAnnotationTipView:(WelfareStoreLoveHouseAnnotationTipView *)view actionType:(WelfareStoreLoveHouseAnnotationTipViewActionType)type{
    [self.mapView deselectAnnotation:view.annotation animated:YES];
    WelfareStoreItem *item = view.item;
    switch (type) {
        case WelfareStoreLoveHouseAnnotationTipViewActionTypeGoto:
        {
            [self gotoStoreWithCoordinate:item.coordinate2D];
        }
            break;
        case WelfareStoreLoveHouseAnnotationTipViewActionTypeNearby:
        {
            [self nearbyStoreWithCoordinate:item.coordinate];
        }
            break;
    }
}

#pragma mark - helpers

- (void)nearbyStoreWithCoordinate:(NSString *)coordinate{
    SearchResultViewController *controller = [[SearchResultViewController alloc]init];
#warning TODO...
//    SearchParmsProductOrStoreModel *searchParmsModel = [[SearchParmsProductOrStoreModel alloc]init];
//    searchParmsModel.mapaddr = coordinate;
//    searchParmsModel.st = @"6";
//    controller.searchParmsModel = searchParmsModel;
//    controller.searchType = SearchType_Store;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)gotoStoreWithCoordinate:(CLLocationCoordinate2D)coordinate{
    
    MapRouteViewController *controller = [[MapRouteViewController alloc]init];
    controller.destinationCoordinate = coordinate;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
