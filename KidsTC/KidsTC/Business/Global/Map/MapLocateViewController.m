//
//  MapLocateViewController.m
//  KidsTC
//
//  Created by 詹平 on 16/7/24.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "MapLocateViewController.h"
#import "KTCMapUtil.h"
#import "UIBarButtonItem+Category.h"
#import "TCProgressHUD.h"
#import "iToast.h"
#import "MapLocateAnnotationTipView.h"
#import "RouteAnnotation.h"
#import "AUIPickerView.h"
@interface MapLocateViewController ()<BMKMapViewDelegate,UITextFieldDelegate,MapLocateAnnotationTipViewDelegate,AUIPickerViewDataSource,AUIPickerViewDelegate>
@property (nonatomic, weak) BMKMapView *mapView;
@property (nonatomic, weak) UITextField *textField;
@property (nonatomic, strong) AUIPickerView *pickerView;
@property (nonatomic, strong) NSArray *pickerDataArray;
@property (nonatomic, strong) KTCLocation *currentLocation;
@end

@implementation MapLocateViewController

- (AUIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[AUIPickerView alloc] initWithDataSource:self delegate:self];
    }
    return _pickerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initui];
    
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
    
    self.naviTheme = NaviThemeWihte;
    
    self.navigationItem.title = @"位置";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initMapView];
    
    [self initTextField];

}

- (void)initMapView{
    BMKMapView *mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    mapView.mapType = BMKMapTypeStandard;
    mapView.showsUserLocation = YES;
    mapView.isSelectedAnnotationViewFront = YES;
    mapView.showMapScaleBar = YES;
    mapView.mapScaleBarPosition = CGPointMake(4, SCREEN_HEIGHT-50);
    mapView.delegate = self;
    [self.view addSubview:mapView];
    self.mapView = mapView;
}

- (void)initTextField{
    
    CGFloat textFieldH = 44;
    
    UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(15, 72, SCREEN_WIDTH - 30, textFieldH)];
    textField.font = [UIFont systemFontOfSize:13];
    textField.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.96];
    textField.placeholder = @"请搜索或长按地图选择位置";
    textField.delegate = self;
    textField.returnKeyType = UIReturnKeySearch;
    textField.clearButtonMode = UITextFieldViewModeAlways;
    
    UIButton *rightBtn = [[UIButton alloc] init];
    [rightBtn setTitle:@"搜索" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [rightBtn setTitleColor:COLOR_PINK forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0, 0, textFieldH, textFieldH);
    [rightBtn addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    textField.rightView = rightBtn;
    textField.rightViewMode = UITextFieldViewModeAlways;
    
    textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 12, 12)];
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    textField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textField.layer.borderWidth = LINE_H;
    
    [self.view addSubview:textField];
    
    self.textField = textField;
}

#pragma mark - BMKMapViewDelegate

- (void)mapViewDidFinishLoading:(BMKMapView *)mapView{
    [self.mapView setCompassPosition:CGPointMake(SCREEN_WIDTH - 50, 70)];
    [self setLocateAnnotationCoordinate:[KTCMapService shareKTCMapService].currentLocation.location.coordinate];
    [self.mapView setCenterCoordinate:self.currentLocation.location.coordinate];
    [self.mapView setZoomLevel:18];
}

- (void)mapview:(BMKMapView *)mapView onLongClick:(CLLocationCoordinate2D)coordinate {
    [self setLocateAnnotationCoordinate:coordinate];
}

static NSString *const annotationViewReuseIndentifier = @"annotationViewReuseIndentifier";
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation{
    BMKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:annotationViewReuseIndentifier];
    if (!annotationView) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:annotationViewReuseIndentifier];
        annotationView.image = [KTCMapUtil poiAnnotationImage];
        annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    }
    
    MapLocateAnnotationTipView *tipView = [[[NSBundle mainBundle] loadNibNamed:@"MapLocateAnnotationTipView" owner:self options:nil]firstObject];;
    tipView.frame = CGRectMake(0, 0, 114, 57);
    tipView.deletate = self;
    tipView.annotation = annotation;
    annotationView.paopaoView = [[BMKActionPaopaoView alloc]initWithCustomView:tipView];
    annotationView.draggable = NO;
    
    annotationView.annotation = annotation;
    
    return annotationView;
}

#pragma mark private

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)setLocateAnnotationCoordinate:(CLLocationCoordinate2D)coordinate {
    [KTCMapUtil cleanMap:self.mapView];
    BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc]init];
    if (CLLocationCoordinate2DIsValid(coordinate)) {
        [annotation setCoordinate:coordinate];
        CLLocation *clLocation = [[CLLocation alloc]initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
        self.currentLocation = [[KTCLocation alloc]init];
        self.currentLocation.location = clLocation;
    }
    NSArray *annos = [self.mapView annotations];
    if ([annos indexOfObject:annotation] == NSNotFound) {
        [self.mapView addAnnotation:annotation];
    }
}

#pragma mark - MapLocateAnnotationTipViewDelegate

- (void)MapLocateAnnotationTipView:(MapLocateAnnotationTipView *)view actionType:(MapLocateAnnotationTipViewActionType)type{
    [self.mapView deselectAnnotation:view.annotation animated:YES];
    if (type == MapLocateAnnotationTipViewActionTypeSure) {
        [self startSearchWithCoordinate:view.annotation.coordinate];
    }
}

- (void)startSearchWithCoordinate:(CLLocationCoordinate2D)coordinate {
    if (CLLocationCoordinate2DIsValid(coordinate)) {
        [TCProgressHUD showSVP];
        [[KTCMapService shareKTCMapService] getAddressDescriptionWithCoordinate:coordinate succeed:^(BMKReverseGeoCodeResult *result) {
            [TCProgressHUD dismissSVP];
            [self fullFillPickerViewWithReverseGeoCodeSearchResult:result];
        } failure:^(NSError *error) {
            [TCProgressHUD dismissSVP];
        }];
    }
}

- (void)fullFillPickerViewWithReverseGeoCodeSearchResult:(BMKReverseGeoCodeResult *)result {
    
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (BMKPoiInfo *poi in result.poiList) {
        [tempArray addObject:poi.address];
    }
    self.pickerDataArray = [NSArray arrayWithArray:tempArray];
    if ([self.pickerDataArray count] > 0) {
        [self.pickerView show];
    } else {
        [[iToast makeText:@"查询失败"] show];
    }
}

#pragma mark AUIPickerViewDataSource & AUIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(AUIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(AUIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.pickerDataArray count];
}

- (UIView *)pickerView:(AUIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.minimumScaleFactor = 0.5;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    pickerLabel.text = [self.pickerDataArray objectAtIndex:row];
    return pickerLabel;
}

- (void)didCanceledPickerView:(AUIPickerView *)pickerView {
    self.pickerDataArray = nil;
}

- (void)pickerView:(AUIPickerView *)pickerView didConfirmedWithSelectedIndexArrayOfAllComponent:(NSArray *)indexArray {
    NSString *pickedString = [self.pickerDataArray objectAtIndex:[[indexArray firstObject] integerValue]];
    self.currentLocation.locationDescription = pickedString;
    [[KTCMapService shareKTCMapService] stopUpdateLocation];
    [[KTCMapService shareKTCMapService] setCurrentLocation:[self.currentLocation copy]];
    [self back];
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
            [self setLocateAnnotationCoordinate:result.location];
            self.currentLocation.locationDescription = result.address;
            [[KTCMapService shareKTCMapService] setCurrentLocation:[self.currentLocation copy]];
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

@end
