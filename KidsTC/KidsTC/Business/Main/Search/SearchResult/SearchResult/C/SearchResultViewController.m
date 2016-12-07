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

#import "SearchResultProductModel.h"
#import "SearchResultView.h"

#import "SpeekViewController.h"

@interface SearchResultViewController ()<UITextFieldDelegate,SearchResultViewDelegate>
@property (nonatomic, weak) UITextField *tf;
@property (nonatomic, weak) SearchResultView *resultView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSString *userLocation;
@property (nonatomic, strong) NSArray<SearchResultProduct *> *products;
@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupToolBar];
    
    [self setupTf];
    
    [self buildNavigationBar];
    
    SearchResultView *resultView = [[SearchResultView alloc] initWithFrame:CGRectMake(0, 64 + kSearchResultToolBarH, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - kSearchResultToolBarH)];
    resultView.delegate = self;
    [self.view addSubview:resultView];
    self.resultView = resultView;
    
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
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"搜索" postion:UIBarButtonPositionRight target:self action:@selector(search) andGetButton:^(UIButton *btn) {
        [btn setTitleColor:[UIColor colorFromHexString:@"5B5B5B"] forState:UIControlStateNormal];
    }];
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
    [self.view addSubview:toolBar];
    toolBar.insetParam = self.search_parms;
}


#pragma mark - SearchResultViewDelegate

- (void)searchResultView:(SearchResultView *)view actionType:(SearchResultViewActionType)type value:(id)value {
    switch (type) {
        case SearchResultViewActionTypeLoadData:
        {
            if ([value respondsToSelector:@selector(boolValue)]) {
                [self loadData:[value boolValue]];
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)loadData:(BOOL)refresh {
    self.page = refresh?1:++self.page;
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.search_parms];
    [dic setObject:@(self.page) forKey:@"page"];
    [dic setObject:@(kSearchResultViewPageCount) forKey:@"pageSize"];
    if ([self.userLocation isNotNull]) {
        [dic setObject:self.userLocation forKey:@"mapaddr"];
    }
    NSDictionary *param = [NSDictionary dictionaryWithDictionary:dic];
    [Request startWithName:@"SEARCH_NEW" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        SearchResultProductModel *model = [SearchResultProductModel modelWithDictionary:dic];
        if (refresh) {
            self.products = model.data;
        }else{
            NSMutableArray *products = [NSMutableArray arrayWithArray:self.products];
            [products addObjectsFromArray:model.data];
            self.products = [NSArray arrayWithArray:products];
        }
        self.resultView.products = self.products;
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
