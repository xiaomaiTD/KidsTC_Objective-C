//
//  SearchResultViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchResultViewController.h"
#import "SearchResultToolBar.h"
#import "Colours.h"
#import "GHeader.h"
#import "NSString+Category.h"
#import "UIBarButtonItem+Category.h"
#import "SearchHotKeywordsManager.h"
#import <AVFoundation/AVFoundation.h>
#import "KTCMapService.h"
#import "SegueMaster.h"

#import "SearchResultProductModel.h"
#import "SearchResultStoreModel.h"
#import "SearchResultView.h"

#import "SpeekViewController.h"

@interface SearchResultViewController ()<UITextFieldDelegate,SearchResultToolBarDelegate,SearchResultViewDelegate>
@property (nonatomic, weak) UITextField *tf;
@property (nonatomic, weak) SearchResultToolBar *toolBar;
@property (nonatomic, weak) SearchResultView *resultView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSString *userLocation;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UIButton *rightBarBtn;
@end

@implementation SearchResultViewController

- (void)setSearchType:(SearchType)searchType {
    _searchType = searchType;
    self.resultView.searchType = searchType;
    self.toolBar.searchType = searchType;
    self.rightBarBtn.enabled = (searchType == SearchTypeProduct);
}

- (void)setParams_product:(NSDictionary *)params_product {
    _params_product = params_product;
    self.params_current = _params_product;
}

- (void)setParams_store:(NSDictionary *)params_store {
    _params_store = params_store;
    self.params_current = _params_store;
}

- (void)setParams_current:(NSDictionary *)params_current {
    _params_current = params_current;
    self.toolBar.insetParam = _params_current;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupTf];
    
    [self buildNavigationBar];
    
    SearchResultView *resultView = [[SearchResultView alloc] initWithFrame:CGRectMake(0, 64 + kSearchResultToolBarH, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - kSearchResultToolBarH)];
    resultView.delegate = self;
    [self.view addSubview:resultView];
    self.resultView = resultView;
    
    [self setupToolBar];
    
    [NotificationCenter addObserver:self selector:@selector(userLocationDidChange) name:kUserLocationHasChangedNotification object:nil];
    [self userLocationDidChange];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tf.placeholder = [SearchHotKeywordsManager shareSearchHotKeywordsManager].firstItem.name;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.tf resignFirstResponder];
}

- (void)buildNavigationBar{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImagePostion:UIBarButtonPositionRight target:self action:@selector(changeProductShowState:) andGetButton:^(UIButton *btn) {
        [btn setImageEdgeInsets:UIEdgeInsetsMake(2, 2, 2, 2)];
        [btn setImage:[UIImage imageNamed:@"searchResult_large"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"searchResult_small"] forState:UIControlStateSelected];
        self.rightBarBtn = btn;
    }];
}

- (void)changeProductShowState:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (!btn.selected) {
        self.resultView.showType = SearchResultProductViewShowTypeSmall;
    }else{
        self.resultView.showType = SearchResultProductViewShowTypeLarge;
    }
}

- (void)setupTf {
    
    UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 400, 30)];
    tf.backgroundColor = [UIColor colorFromHexString:@"e8e8e8"];
    tf.font = [UIFont systemFontOfSize:15];
    tf.borderStyle = UITextBorderStyleNone;
    tf.layer.cornerRadius = 4;
    tf.returnKeyType = UIReturnKeySearch;
    tf.tintColor = [UIColor colorFromHexString:@"444444"];
    tf.textColor = [UIColor colorFromHexString:@"444444"];
    tf.layer.masksToBounds = YES;
    tf.delegate = self;
    tf.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    UIButton *leftBtn = [UIButton new];
    leftBtn.showsTouchWhenHighlighted = NO;
    leftBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [leftBtn setImage:[UIImage imageNamed:@"search_magnifier"] forState:UIControlStateNormal];
    leftBtn.bounds = CGRectMake(0, 0, 30, 30);
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    tf.leftView = leftBtn;
    tf.leftViewMode = UITextFieldViewModeAlways;
    
    UIButton *rightBtn = [UIButton new];
    rightBtn.showsTouchWhenHighlighted = NO;
    rightBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [rightBtn setImage:[UIImage imageNamed:@"search_microphone"] forState:UIControlStateNormal];
    rightBtn.bounds = CGRectMake(0, 0, 30, 30);
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [rightBtn addTarget:self action:@selector(speek) forControlEvents:UIControlEventTouchUpInside];
    tf.rightView = rightBtn;
    tf.rightViewMode = UITextFieldViewModeUnlessEditing;
    
    self.navigationItem.titleView = tf;
    self.tf = tf;
    
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self search];
    return NO;
}

- (void)speek {
    [self requestAccess:AVMediaTypeAudio name:@"麦克风" callBack:^{
        SpeekViewController *controller = [[SpeekViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }];
}

- (void)requestAccess:(NSString *)type name:(NSString *)name callBack:(void(^)())callBack {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:type];
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined:
        {
            [AVCaptureDevice requestAccessForMediaType:type completionHandler:^(BOOL granted) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (granted) {
                        if(callBack)callBack();
                        TCLog(@"授权成功");
                    }else{
                        TCLog(@"授权失败");
                    }
                });
            }];
        }
            break;
        case AVAuthorizationStatusAuthorized:
        {
            if(callBack)callBack();
        }
            break;
        default:
        {
            [self alertTipWithTarget:self name:name];
        }
            break;
    }
}

- (void)alertTipWithTarget:(UIViewController *)target name:(NSString *)name{
    NSString *prodName = [[NSBundle mainBundle] infoDictionary][@"CFBundleDisplayName"];
    NSString *title = [NSString stringWithFormat:@"%@授权",name];
    NSString *message = [NSString stringWithFormat:@"您尚未开启%@APP%@授权，不能使用该功能。请到“设置-%@-%@”中开启",prodName,name,prodName,name];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"设置" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            [[UIApplication sharedApplication] openURL:url];
        }
    }];
    [alert addAction:cancle];
    [alert addAction:sure];
    [target presentViewController:alert animated:YES completion:nil];
}

- (void)search {
    NSString *key = self.tf.text;
    SearchHotKeywordsItem *item;
    if ([key isNotNull]) {
        item = [SearchHotKeywordsItem itemWithName:key];
    }else{
        item = [SearchHotKeywordsManager shareSearchHotKeywordsManager].firstItem;
    }
}

- (void)setupToolBar {
    SearchResultToolBar *toolBar = [[NSBundle mainBundle] loadNibNamed:@"SearchResultToolBar" owner:self options:nil].firstObject;
    toolBar.frame = CGRectMake(0, 64, SCREEN_WIDTH, kSearchResultToolBarH);
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
    toolBar.insetParam = _params_current;
    self.toolBar = toolBar;
}

#pragma mark - SearchResultToolBarDelegate

- (void)searchResultToolBar:(SearchResultToolBar *)toolBar actionType:(SearchResultToolBarActionType)type value:(id)value {
    switch (type) {
        case SearchResultToolBarActionTypeBtnClicked:
        {
            [self.tf resignFirstResponder];
        }
            break;
        case SearchResultToolBarActionTypeDidSelectParam:
        {
            switch (self.searchType) {
                case SearchTypeProduct:
                {
                    if ([value isKindOfClass:[NSDictionary class]]) {
                        self.params_product = value;
                        [self.resultView beginRefreshing];
                    }
                }
                    break;
                case SearchTypeStore:
                {
                    if ([value isKindOfClass:[NSDictionary class]]) {
                        self.params_store = value;
                        [self.resultView beginRefreshing];
                    }
                }
                    break;
            }
        }
            break;
        case SearchResultToolBarActionTypeDidSelectProduct:
        {
            self.resultView.items = nil;
            [self.resultView reloadData];
            self.searchType = SearchTypeProduct;
        }
            break;
        case SearchResultToolBarActionTypeDidSeltctStore:
        {
            self.resultView.items = nil;
            [self.resultView reloadData];
            self.params_current = self.params_store;
            self.searchType = SearchTypeStore;
            [self.resultView beginRefreshing];
        }
            break;
        default:
            break;
    }
}





#pragma mark - SearchResultViewDelegate

- (void)searchResultView:(SearchResultView *)view actionType:(SearchResultViewActionType)type value:(id)value {
    switch (type) {
        case SearchResultViewActionTypeLoadData:
        {
            [self loadData:value];
        }
            break;
        case SearchResultViewActionTypeSegue:
        {
            [SegueMaster makeSegueWithModel:value fromController:self];
        }
            break;
        default:
            break;
    }
}

- (void)loadData:(id)value {
    if ([value respondsToSelector:@selector(boolValue)]) {
        switch (_searchType) {
            case SearchTypeProduct:
            {
                [self loadProductData:[value boolValue]];
            }
                break;
            case SearchTypeStore:
            {
                [self loadStoreData:[value boolValue]];
            }
                break;
            default:
            {
                [self.resultView dealWithUI:0];
            }
                break;
        }
    }else{
        [self.resultView dealWithUI:0];
    }
    
}

- (void)loadProductData:(BOOL)refresh {
    self.page = refresh?1:++self.page;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.params_current];
    [dic setObject:@(self.page) forKey:@"page"];
    [dic setObject:@(kSearchResultViewPageCount) forKey:@"pageSize"];
    if ([self.userLocation isNotNull]) {
        [dic setObject:self.userLocation forKey:@"mapaddr"];
    }
    NSDictionary *param = [NSDictionary dictionaryWithDictionary:dic];
    [Request startWithName:@"SEARCH_NEW" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        SearchResultProductModel *model = [SearchResultProductModel modelWithDictionary:dic];
        if (refresh) {
            self.items = model.data;
        }else{
            NSMutableArray *items = [NSMutableArray arrayWithArray:self.items];
            [items addObjectsFromArray:model.data];
            self.items = [NSArray arrayWithArray:items];
        }
        self.resultView.items = self.items;
        [self.resultView dealWithUI:model.data.count];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.resultView dealWithUI:0];
    }];
}

- (void)loadStoreData:(BOOL)refresh {
    self.page = refresh?1:++self.page;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.params_current];
    [dic setObject:@(self.page) forKey:@"page"];
    [dic setObject:@(kSearchResultViewPageCount) forKey:@"pageSize"];
    if ([self.userLocation isNotNull]) {
        [dic setObject:self.userLocation forKey:@"mapaddr"];
    }
    //NSString *pt = [NSString stringWithFormat:<#(nonnull NSString *), ...#>];
    NSDictionary *param = [NSDictionary dictionaryWithDictionary:dic];
    [Request startWithName:@"STORE_SEARCH_V2" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        SearchResultStoreModel *model = [SearchResultStoreModel modelWithDictionary:dic];
        if (refresh) {
            self.items = model.data;
        }else{
            NSMutableArray *items = [NSMutableArray arrayWithArray:self.items];
            [items addObjectsFromArray:model.data];
            self.items = [NSArray arrayWithArray:items];
        }
        self.resultView.items = self.items;
        [self.resultView dealWithUI:model.data.count];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.resultView dealWithUI:0];
    }];
}

#pragma mark - userLocation

- (void)userLocationDidChange {
    self.userLocation = [KTCMapService shareKTCMapService].currentLocationString;
}

- (void)dealloc{
    [NotificationCenter removeObserver:self name:kUserLocationHasChangedNotification object:nil];
}

@end
