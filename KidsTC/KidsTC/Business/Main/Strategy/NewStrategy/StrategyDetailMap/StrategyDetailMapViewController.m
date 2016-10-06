//
//  StrategyDetailMapViewController.m
//  KidsTC
//
//  Created by zhanping on 8/20/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "StrategyDetailMapViewController.h"
#import "KTCMapService.h"
#import "KTCMapUtil.h"
#import "StrategyDetailAnnotationTipView.h"
#import "MapRouteViewController.h"

@interface StrategyDetailMapViewController ()<BMKMapViewDelegate,StrategyDetailAnnotationTipViewDelegate>
@property (nonatomic, weak) BMKMapView *mapView;
@end

@implementation StrategyDetailMapViewController

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
    if (self.mapView) {
        self.mapView = nil;
    }
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

#pragma mark - BMKMapViewDelegate

- (void)mapViewDidFinishLoading:(BMKMapView *)mapView {
    //指南针必须在加载完成后设置
    [self.mapView setCompassPosition:CGPointMake(SCREEN_WIDTH - 50, 70)];
    CLLocationCoordinate2D coordinate = self.model.location.location.coordinate;
    [self setLocateAnnotationCoordinate:coordinate];
    [self.mapView setCenterCoordinate:coordinate];
    [self.mapView setZoomLevel:18];
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

    StrategyDetailAnnotationTipView *tipView = [[[NSBundle mainBundle] loadNibNamed:@"StrategyDetailAnnotationTipView" owner:self options:nil] firstObject];
    tipView.frame = CGRectMake(0, 0, 160, 60);
    tipView.delegate = self;
    tipView.tipLabel.text = self.model.location.locationDescription;
    tipView.annotation = annotation;
    annotationView.paopaoView = [[BMKActionPaopaoView alloc]initWithCustomView:tipView];
    //设置是否可以拖拽
    annotationView.draggable = NO;
    return annotationView;
}

#pragma mark - StrategyDetailAnnotationTipViewDelegate

- (void)strategyDetailAnnotationTipViewDidClickOnGotoBtn:(StrategyDetailAnnotationTipView *)view {
    MapRouteViewController *controller = [[MapRouteViewController alloc]init];
    controller.destinationCoordinate = view.annotation.coordinate;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark private

- (void)setLocateAnnotationCoordinate:(CLLocationCoordinate2D)coordinate {
    [KTCMapUtil cleanMap:self.mapView];
    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc]init];
    if (CLLocationCoordinate2DIsValid(coordinate)) {
        [annotation setCoordinate:coordinate];
    }
    NSArray *annos = [self.mapView annotations];
    if ([annos indexOfObject:annotation] == NSNotFound) {
        [self.mapView addAnnotation:annotation];
    }
}

@end
