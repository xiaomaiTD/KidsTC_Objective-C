//
//  MapRouteViewController.m
//  KidsTC
//
//  Created by 詹平 on 16/7/24.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "MapRouteViewController.h"
#import "KTCMapUtil.h"
#import "UIBarButtonItem+Category.h"
#import "TCProgressHUD.h"
#import "iToast.h"
#import "RouteAnnotation.h"

CGFloat const RouteTypeButtonSize = 40;

@interface MapRouteViewController ()<BMKMapViewDelegate,UITextFieldDelegate>
@property (nonatomic, weak) BMKMapView *mapView;
@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, weak) UIButton *routeTypeButton;
@property (nonatomic, strong) BMKPointAnnotation* startAnnotation;
@property (nonatomic, strong) BMKPointAnnotation *destinationAnnotation;
@end

@implementation MapRouteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initui];
    
    BMKPointAnnotation *destinationAnnotation = [[BMKPointAnnotation alloc]init];
    destinationAnnotation.coordinate = self.destinationCoordinate;
    self.destinationAnnotation = destinationAnnotation;
    
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

#pragma mark - init

- (void)initui{
    
    self.naviColor = [UIColor clearColor];
    
    [self initMapView];
    
    [self initTextField];
    
    [self initNaviBarItems];
    
    [self initRouteTypeButton];
}

- (void)initMapView{
    BMKMapView *mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    mapView.mapType = BMKMapTypeStandard;
    mapView.showsUserLocation = YES;
    mapView.isSelectedAnnotationViewFront = YES;
    mapView.showMapScaleBar = YES;
    mapView.mapScaleBarPosition = CGPointMake(5, SCREEN_HEIGHT-50);
    mapView.delegate = self;
    
    [self.view addSubview:mapView];
    self.mapView = mapView;
}

- (void)initTextField{
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    textField.font = [UIFont systemFontOfSize:15];
    textField.backgroundColor = [COLOR_PINK colorWithAlphaComponent:0.5];
    textField.placeholder = @"请搜索或长按地图选择起点";
    textField.delegate = self;
    textField.returnKeyType = UIReturnKeySearch;
    textField.clearButtonMode = UITextFieldViewModeAlways;
    self.navigationItem.titleView = textField;
    self.textField = textField;
    
    textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 12, 12)];
    textField.leftViewMode = UITextFieldViewModeAlways;
}

- (void)initNaviBarItems{
    self.navigationItem.leftBarButtonItem =
    [UIBarButtonItem itemWithImageName:@"navigation_back_h" highImageName:@"navigation_back_h" postion:UIBarButtonPositionLeft target:self action:@selector(back)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"搜索" postion:UIBarButtonPositionRightCenter target:self action:@selector(search) andGetButton:^(UIButton *btn) {
        [btn setTitleColor:COLOR_PINK forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, CGRectGetWidth(btn.frame)+12, 30);
        btn.backgroundColor = [COLOR_PINK colorWithAlphaComponent:0.5];
    }];
}

- (void)initRouteTypeButton{
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-RouteTypeButtonSize-24, SCREEN_HEIGHT-RouteTypeButtonSize-24, RouteTypeButtonSize, RouteTypeButtonSize)];
    btn.backgroundColor = [COLOR_PINK colorWithAlphaComponent:0.5];
    [btn setTitleColor:COLOR_PINK forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = RouteTypeButtonSize*0.5;
    [btn setTitle:@"公交" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(choiceRouteType:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.routeTypeButton = btn;
}

#pragma mark - BMKMapViewDelegate

- (void)mapViewDidFinishLoading:(BMKMapView *)mapView{
    [self.mapView setCompassPosition:CGPointMake(SCREEN_WIDTH - 50, 70)];
    [self setStartAnnotationCoordinate:[KTCMapService shareKTCMapService].currentLocation.location.coordinate];
    [self setDestinationAnnotationCoordinate:self.destinationAnnotation.coordinate];
    [self startRouteSearchWithType:MapRouteSearchTypeBus];
}

- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate {
    [self.textField endEditing:YES];
}

- (void)mapview:(BMKMapView *)mapView onLongClick:(CLLocationCoordinate2D)coordinate {
    [KTCMapUtil cleanMap:self.mapView];
    [self setStartAnnotationCoordinate:coordinate];
    [self setDestinationAnnotationCoordinate:self.destinationAnnotation.coordinate];
    [self startRouteSearchWithType:MapRouteSearchTypeBus];
}

static NSString *const annotationViewReuseIndentifier = @"annotationViewReuseIndentifier";
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation{
    BMKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:annotationViewReuseIndentifier];
    if (!annotationView) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewReuseIndentifier];
    }
    annotationView.annotation = annotation;
    annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    
    if (annotation == self.startAnnotation) {
        annotationView.image = [KTCMapUtil startAnnotationImage];
    }else if (annotation == self.destinationAnnotation){
        annotationView.image = [KTCMapUtil endAnnotationImage];
    }
    
    if ([annotation isKindOfClass:[RouteAnnotation class]]) {
        return [RouteAnnotation routeAnnotationView:mapView viewForAnnotation:(RouteAnnotation*)annotation];
    }
    
    return annotationView;
}

- (BMKOverlayView*)mapView:(BMKMapView *)mapView viewForOverlay:(id<BMKOverlay>)overlay {
    if ([overlay isKindOfClass:[BMKPolyline class]]) {
        BMKPolylineView* polylineView = [[BMKPolylineView alloc] initWithOverlay:overlay];
        polylineView.fillColor = COLOR_BLUE;
        polylineView.strokeColor = COLOR_BLUE;
        polylineView.lineWidth = 3.0;
        return polylineView;
    }
    return nil;
}

#pragma mark private

- (void)setStartAnnotationCoordinate:(CLLocationCoordinate2D)coordinate {
    if (!self.startAnnotation) {
        self.startAnnotation = [[BMKPointAnnotation alloc]init];
    }
    if (CLLocationCoordinate2DIsValid(coordinate)) {
        [self.startAnnotation setCoordinate:coordinate];
    }
    NSArray *annos = [self.mapView annotations];
    if ([annos indexOfObject:self.startAnnotation] == NSNotFound) {
        [self.mapView addAnnotation:self.startAnnotation];
    }
}

- (void)setDestinationAnnotationCoordinate:(CLLocationCoordinate2D)coordinate {
    if (!self.destinationAnnotation) {
        self.destinationAnnotation = [[BMKPointAnnotation alloc]init];
    }
    if (CLLocationCoordinate2DIsValid(coordinate)) {
        [self.destinationAnnotation setCoordinate:coordinate];
    }
    NSArray *annos = [self.mapView annotations];
    if ([annos indexOfObject:self.destinationAnnotation] == NSNotFound) {
        [self.mapView addAnnotation:self.destinationAnnotation];
    }
}

#pragma mark - search

- (void)search{
    NSString *text = self.textField.text;
    if (text.length==0) {
        [[iToast makeText:@"请输入搜索地址"] show];
        return;
    }
    [self.textField endEditing:YES];
    [self startSearchWithAddress:text];
}

- (void)startSearchWithAddress:(NSString *)address {
    NSString *searchText = [address stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([searchText length] > 0) {
        [TCProgressHUD showSVP];
        [[KTCMapService shareKTCMapService] getCoordinateWithCity:@"上海" address:address succeed:^(BMKGeoCodeResult *result) {
            [TCProgressHUD dismissSVP];
            [KTCMapUtil cleanMap:self.mapView];
            [self setStartAnnotationCoordinate:result.location];
            [self setDestinationAnnotationCoordinate:self.destinationAnnotation.coordinate];
            [self startRouteSearchWithType:MapRouteSearchTypeBus];
        } failure:^(NSError *error) {
            [TCProgressHUD dismissSVP];
            [[iToast makeText:@"查询失败"] show];
        }];
    }
}

#pragma mark UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self search];
    return NO;
}

#pragma mark - choiceRouteType

- (void)choiceRouteType:(UIButton *)btn{
    TCLog(@"");
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"请选择路径规划方式" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *driveAction = [UIAlertAction actionWithTitle:@"驾车" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self startRouteSearchWithType:MapRouteSearchTypeDrive];
    }];
    UIAlertAction *busAction = [UIAlertAction actionWithTitle:@"公交" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self startRouteSearchWithType:MapRouteSearchTypeBus];
    }];
    UIAlertAction *walkAction = [UIAlertAction actionWithTitle:@"步行" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self startRouteSearchWithType:MapRouteSearchTypeWalk];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [controller addAction:driveAction];
    [controller addAction:busAction];
    [controller addAction:walkAction];
    [controller addAction:cancelAction];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)startRouteSearchWithType:(MapRouteSearchType)type {
    [self resetRouteTypeButtonWithType:type];
    [TCProgressHUD showSVP];
    [[KTCMapService shareKTCMapService] startRouteSearchWithType:type startCoordinate:self.startAnnotation.coordinate endCoordinate:self.destinationAnnotation.coordinate succeed:^(id result) {
        [TCProgressHUD dismissSVP];
        [self drawRouteLineDetailWithSearchResult:result];
    } failure:^(NSError *error) {
        [TCProgressHUD dismissSVP];
        [[iToast makeText:@"没有找到合适的路线"] show];
    }];
}

- (void)resetRouteTypeButtonWithType:(MapRouteSearchType)type {
    [self.routeTypeButton setHidden:NO];
    switch (type) {
        case MapRouteSearchTypeDrive:
        {
            [self.routeTypeButton setTitle:@"驾车" forState:UIControlStateNormal];
        }
            break;
        case MapRouteSearchTypeBus:
        {
            [self.routeTypeButton setTitle:@"公交" forState:UIControlStateNormal];
        }
            break;
        case MapRouteSearchTypeWalk:
        {
            [self.routeTypeButton setTitle:@"步行" forState:UIControlStateNormal];
        }
            break;
        default:
            break;
    }
}

- (NSDictionary *)drawRouteLineDetailWithSearchResult:(id)result {
    NSDictionary *routeLineDic = nil;
    //解析
    if ([result isKindOfClass:[BMKDrivingRouteResult class]]) {
        //驾车
        routeLineDic = [KTCMapUtil drawRoutePolyLineOnMapView:self.mapView withStartCoord:self.startAnnotation.coordinate endCoord:self.destinationAnnotation.coordinate andDrivingRouteResult:result autoResetToFit:YES];
    } else if ([result isKindOfClass:[BMKTransitRouteResult class]]) {
        //公交
        routeLineDic = [KTCMapUtil drawRoutePolyLineOnMapView:self.mapView withStartCoord:self.startAnnotation.coordinate endCoord:self.destinationAnnotation.coordinate andTransitRouteResult:result autoResetToFit:YES];
    } else if ([result isKindOfClass:[BMKWalkingRouteResult class]]) {
        //步行
        routeLineDic = [KTCMapUtil drawRoutePolyLineOnMapView:self.mapView withStartCoord:self.startAnnotation.coordinate endCoord:self.destinationAnnotation.coordinate andWalkingRouteResult:result autoResetToFit:YES];
    }
    return routeLineDic;
}

@end
