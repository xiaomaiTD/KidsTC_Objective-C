//
//  StoreDetialMapViewController.m
//  KidsTC
//
//  Created by zhanping on 8/2/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "StoreDetialMapViewController.h"
#import "KTCMapService.h"
#import "KTCMapUtil.h"
#import "UIBarButtonItem+Category.h"
#import "StoreDetailAnnotationTipView.h"
#import "MapRouteViewController.h"
#import "RouteAnnotation.h"
#import "TCStoreDetailViewController.h"
@interface StoreDetialMapViewController ()<BMKMapViewDelegate,StoreDetailAnnotationTipViewDelegate>
@property (nonatomic, weak) BMKMapView *mapView;
@end

@implementation StoreDetialMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initui];
}

- (void)initui{
    
    self.navigationItem.title = @"相关门店";
    
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

- (void)resetMapViewAnnotations{
    [KTCMapUtil cleanMap:self.mapView];
    NSMutableArray *tempArray = [NSMutableArray array];
    
    [self.models enumerateObjectsUsingBlock:^(StoreListItemModel *obj, NSUInteger idx, BOOL *stop) {
        CLLocationCoordinate2D coordinate2D = obj.location.location.coordinate;
        if (CLLocationCoordinate2DIsValid(coordinate2D)) {
            RouteAnnotation *annotation = [[RouteAnnotation alloc]init];
            [annotation setCoordinate:coordinate2D];
            annotation.tag = idx;
            [self.mapView addAnnotation:annotation];
            [tempArray addObject:[[CLLocation alloc] initWithLatitude:coordinate2D.latitude longitude:coordinate2D.longitude]];
        }
    }];

    if (self.selectedModel.location) {
        [KTCMapUtil resetMapView:self.mapView toFitLocations:[NSArray arrayWithObject:self.selectedModel.location.location]];
    } else {
        [KTCMapUtil resetMapView:self.mapView toFitLocations:[NSArray arrayWithArray:tempArray]];
    }
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
    
    annotationView.annotation = annotation;
    NSUInteger index = ((RouteAnnotation *)annotation).tag;
    if (self.models.count>index) {
        StoreDetailAnnotationTipView *tipView = [[[NSBundle mainBundle] loadNibNamed:@"StoreDetailAnnotationTipView" owner:self options:nil] firstObject];
        tipView.frame = CGRectMake(0, 0, 216, 108);
        tipView.delegate = self;
        tipView.model = self.models[index];
        tipView.annotation = annotation;
        annotationView.paopaoView = [[BMKActionPaopaoView alloc]initWithCustomView:tipView];
        //设置是否可以拖拽
        annotationView.draggable = NO;
    }
    
    return annotationView;
}

- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    if (self.selectedModel) {
        [views enumerateObjectsUsingBlock:^(BMKAnnotationView *view, NSUInteger idx, BOOL *stop) {
            StoreListItemModel *model = self.models[idx];
            if ([model.identifier isEqualToString:self.selectedModel.identifier]) {
                [self.mapView selectAnnotation:view.annotation animated:YES];
                *stop = YES;
            }
        }];
    }
}

#pragma mark - StoreDetailAnnotationTipViewDelegate

- (void)storeDetailAnnotationTipView:(StoreDetailAnnotationTipView *)view actionType:(StoreDetailAnnotationTipViewActionType)type{

    switch (type) {
        case StoreDetailAnnotationTipViewActionTypeGoto:
        {
            MapRouteViewController *controller = [[MapRouteViewController alloc]init];
            controller.destinationCoordinate = view.annotation.coordinate;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
            
        case StoreDetailAnnotationTipViewActionTypeShow:
        {
            StoreListItemModel *model = view.model;

            TCStoreDetailViewController *controller = [[TCStoreDetailViewController alloc] init];
            controller.storeId = model.identifier;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
    }
}

@end
