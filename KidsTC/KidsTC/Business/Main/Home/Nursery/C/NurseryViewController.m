//
//  NurseryViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/23.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NurseryViewController.h"

#import "KTCMapService.h"
#import "KTCMapUtil.h"
#import "RouteAnnotation.h"

#import "GHeader.h"
#import "UIBarButtonItem+Category.h"

#import "NurseryModel.h"
#import "NurseryCell.h"
#import "NurseryAnnoView.h"

#import "SearchResultViewController.h"
#import "MapRouteViewController.h"

static int const pageCount = 10;
static NSString *const ID = @"NurseryCell";

@interface NurseryViewController ()<BMKMapViewDelegate,UITableViewDelegate,UITableViewDataSource,NurseryCellDelegate,NurseryAnnoViewDelegate>
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, strong) NSArray<NurseryItem *> *data;
@end

@implementation NurseryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *titleStr = @"";
    switch (_type) {
        case NurseryTypeNursery:
        {
            titleStr = @"育儿室";
        }
            break;
        case NurseryTypeExhibitionHall:
        {
            titleStr = @"展览馆";
        }
            break;
        default:
            break;
    }
    self.navigationItem.title = titleStr;
    
    self.mapView.mapType = BMKMapTypeStandard;
    self.mapView.showsUserLocation = YES;
    self.mapView.isSelectedAnnotationViewFront = YES;
    self.mapView.showMapScaleBar = YES;
    self.mapView.mapScaleBarPosition = CGPointMake(4, SCREEN_HEIGHT-50);
    self.mapView.delegate = self;
    self.mapView.hidden = YES;
    
    self.tableView.estimatedRowHeight = 340;
    [self.tableView registerNib:[UINib nibWithNibName:@"NurseryCell" bundle:nil] forCellReuseIdentifier:ID];
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
    
    [self initNaviBarItem];
}

- (void)initNaviBarItem{
    
    self.navigationItem.rightBarButtonItem =
    [UIBarButtonItem itemWithImagePostion:UIBarButtonPositionRight target:self action:@selector(didClickRightBarButtonItem:) andGetButton:^(UIButton *btn) {
        [btn setImage:[UIImage imageNamed:@"navigation_locate"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"navigation_list"] forState:UIControlStateSelected];
    }];
}

- (void)loadDataRefresh:(BOOL)refresh {
    self.page = refresh?1:++self.page;
    NSDictionary *param = @{@"type":@(self.type),
                            @"page":@(self.page),
                            @"pageCount":@(pageCount)};
    [Request startWithName:@"QUERY_PLACE_INFO" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        NurseryModel *model = [NurseryModel modelWithDictionary:dic];
        [self loadDataSuccessRefresh:refresh model:model];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self loadDataFailure];
    }];
}

- (void)loadDataSuccessRefresh:(BOOL)refresh model:(NurseryModel *)model{
    [self dealWithHeaderFooter];
    
    if (refresh) {
        self.data = [NSMutableArray arrayWithArray:model.data];
    }else{
        NSMutableArray *data = [NSMutableArray arrayWithArray:self.data];
        [data addObjectsFromArray:model.data];
        self.data = [NSArray arrayWithArray:data];
    }
    [self.tableView reloadData];
    
    if (model.data.count<pageCount) [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

- (void)loadDataFailure{
    [self dealWithHeaderFooter];
}

- (void)dealWithHeaderFooter{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NurseryCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.delegate = self;
    NSUInteger row = indexPath.row;
    if (row<self.data.count) {
        cell.item = self.data[row];
    }
    return cell;
}

#pragma mark - NurseryCellDelegate

- (void)nurseryCell:(NurseryCell *)cell actionType:(NurseryCellActionType)type value:(id)value {
    NurseryItem *item = cell.item;
    switch (type) {
        case NurseryCellActionTypeNearby:
        {
            [self nearbyStoreWithCoordinate:item.mapAddress];
        }
            break;
        case NurseryCellActionTypeRoute:
        {
            [self gotoStoreWithCoordinate:item.coordinate2D];
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
    [self.data enumerateObjectsUsingBlock:^(NurseryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
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
    if (self.data.count>index) {
        NurseryAnnoView *annoView = [[NSBundle mainBundle] loadNibNamed:@"NurseryAnnoView" owner:self options:nil].firstObject;
        annoView.frame = CGRectMake(0, 0, 216, 108);
        annoView.delegate = self;
        annoView.item = self.data[index];
        annoView.annotation = annotation;
        annotationView.paopaoView = [[BMKActionPaopaoView alloc]initWithCustomView:annoView];;
        //设置是否可以拖拽
        annotationView.draggable = NO;
    }
    
    return annotationView;
}

#pragma mark - NurseryAnnoViewDelegate

- (void)nurseryAnnoView:(NurseryAnnoView *)view actionType:(NurseryAnnoViewActionType)type value:(id)value {
    [self.mapView deselectAnnotation:view.annotation animated:YES];
    NurseryItem *item = view.item;
    switch (type) {
        case NurseryAnnoViewActionTypeNearby:
        {
            [self nearbyStoreWithCoordinate:item.mapAddress];
        }
            break;
        case NurseryAnnoViewActionTypeRoute:
        {
            [self gotoStoreWithCoordinate:item.coordinate2D];
        }
            break;
    }
}

#pragma mark - helpers

- (void)nearbyStoreWithCoordinate:(NSString *)coordinate{
    SearchResultViewController *controller = [[SearchResultViewController alloc]init];
    SearchParmsProductOrStoreModel *searchParmsModel = [[SearchParmsProductOrStoreModel alloc]init];
    searchParmsModel.mapaddr = coordinate;
    searchParmsModel.st = @"6";
    controller.searchParmsModel = searchParmsModel;
    controller.searchType = SearchType_Store;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)gotoStoreWithCoordinate:(CLLocationCoordinate2D)coordinate{
    MapRouteViewController *controller = [[MapRouteViewController alloc]init];
    controller.destinationCoordinate = coordinate;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
