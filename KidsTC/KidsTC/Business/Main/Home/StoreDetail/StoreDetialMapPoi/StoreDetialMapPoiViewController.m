//
//  StoreDetialMapPoiViewController.m
//  KidsTC
//
//  Created by zhanping on 8/3/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "StoreDetialMapPoiViewController.h"
#import "KTCMapService.h"
#import "KTCMapUtil.h"
#import "RouteAnnotation.h"
#import "StoreDetialMapPoiAnnotationView.h"
#import "MapRouteViewController.h"

@interface StoreDetialMapPoiViewController ()<BMKMapViewDelegate,StoreDetialMapPoiAnnotationViewDelegate>
@property (nonatomic, weak) BMKMapView *mapView;
@end

@implementation StoreDetialMapPoiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initui];
}

- (void)initui{
    
    self.navigationItem.title = @"位置信息";
    
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
    if (self.mapView)self.mapView = nil;
}

- (void)initMapView{
    BMKMapView *mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    mapView.mapType = BMKMapTypeStandard;
    mapView.showsUserLocation = YES;
    mapView.isSelectedAnnotationViewFront = YES;
    mapView.showMapScaleBar = YES;
    mapView.mapScaleBarPosition = CGPointMake(4, SCREEN_HEIGHT-50);
    mapView.delegate = self;
    [self.view addSubview:mapView];
    self.mapView = mapView;
}

- (void)resetMapViewAnnotations{
    [KTCMapUtil cleanMap:self.mapView];
    NSMutableArray *tempArray = [NSMutableArray array];
    [self.locations enumerateObjectsUsingBlock:^(KTCLocation *obj, NSUInteger idx, BOOL *stop) {
        CLLocationCoordinate2D coordinate2D = obj.location.coordinate;
        if (CLLocationCoordinate2DIsValid(coordinate2D)) {
            RouteAnnotation *annotation = [[RouteAnnotation alloc]init];
            [annotation setCoordinate:coordinate2D];
            annotation.tag = idx;
            [self.mapView addAnnotation:annotation];
            [tempArray addObject:[[CLLocation alloc] initWithLatitude:coordinate2D.latitude longitude:coordinate2D.longitude]];
        }
    }];
    [KTCMapUtil resetMapView:self.mapView toFitLocations:[NSArray arrayWithArray:tempArray]];
}

#pragma mark - BMKMapViewDelegate

- (void)mapViewDidFinishLoading:(BMKMapView *)mapView {
    //指南针必须在加载完成后设置
    [self.mapView setCompassPosition:CGPointMake(SCREEN_WIDTH - 50, 70)];
    [self resetMapViewAnnotations];
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
    if (self.locations.count>index) {
        StoreDetialMapPoiAnnotationView *tipView = [[[NSBundle mainBundle] loadNibNamed:@"StoreDetialMapPoiAnnotationView" owner:self options:nil] firstObject];
        tipView.frame = CGRectMake(0, 0, 132, 66);
        tipView.delegate = self;
        tipView.item = self.locations[index];
        tipView.annotation = annotation;
        annotationView.paopaoView = [[BMKActionPaopaoView alloc]initWithCustomView:tipView];
        //设置是否可以拖拽
        annotationView.draggable = NO;
    }
    
    return annotationView;
}

#pragma mark - StoreDetialMapPoiAnnotationViewDelegate

- (void)storeDetialMapPoiAnnotationViewDidClickGotoBtn:(StoreDetialMapPoiAnnotationView *)view{
    MapRouteViewController *controller = [[MapRouteViewController alloc]init];
    controller.destinationCoordinate = view.annotation.coordinate;
    [self.navigationController pushViewController:controller animated:YES];
}

@end
