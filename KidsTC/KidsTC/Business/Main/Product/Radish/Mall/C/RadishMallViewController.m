//
//  RadishMallViewController.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/5.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishMallViewController.h"
#import "GHeader.h"
#import "SegueMaster.h"
#import "NSString+Category.h"
#import "BuryPointManager.h"

#import "RadishMallModel.h"
#import "RadishUserModel.h"
#import "RadishPageModel.h"
#import "RadishMallView.h"

#import "WebViewController.h"

@interface RadishMallViewController ()<RadishMallViewDelegate>
@property (nonatomic, strong) RadishMallView *mallView;
@property (nonatomic, strong) RadishMallData *data;
@property (nonatomic, assign) NSUInteger page;
@end

@implementation RadishMallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"每日种萝卜";
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.pageId = 11300;
    
    RadishMallView *mallView = [[RadishMallView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    mallView.delegate = self;
    [self.view addSubview:mallView];
    self.mallView = mallView;
}

#pragma mark - RadishMallViewDelegate

- (void)radishMallView:(RadishMallView *)view actionType:(RadishMallViewActionType)type value:(id)value {
    
    switch (type) {
        case RadishMallViewActionTypeSegue:
        {
            [self segue:value];
        }
            break;
        case RadishMallViewActionTypePlant:
        {
            [self plant:value];
        }
            break;
        case RadishMallViewActionTypeRule:
        {
            [self rule:value];
        }
            break;
        case RadishMallViewActionTypeGrade:
        {
            [self grade:value];
        }
            break;
        case RadishMallViewActionTypeLoadData:
        {
            [self loadData:value];
        }
            break;
        default:
            break;
    }
}

- (void)segue:(id)value {
    [SegueMaster makeSegueWithModel:value fromController:self];
}

- (void)plant:(id)value {
    User *user = [User shareUser];
    if (user.hasLogin) {
        [self startPlant];
    }else{
        [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
            //[self startPlant];
            [self loadRadishUserData];
        }];
    }
    
}

- (void)startPlant {
    [Request startWithName:@"RADISH_SIGN_IN" param:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        RadishUserData *userData = self.data.userData;
        userData.isCheckIn = YES;
        userData.radishCount ++;
        userData.checkInDays ++;
        [self.mallView reloadData];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSString *errMsg = @"萝卜种植失败，请稍后再试";
        NSString *text = [[error userInfo] objectForKey:@"data"];
        if ([text isKindOfClass:[NSString class]] && [text length] > 0) errMsg = text;
        [[iToast makeText:errMsg] show];
    }];
    [BuryPointManager trackEvent:@"event_click_radish_sign" actionId:21900 params:nil];
}

- (void)rule:(id)value {
    NSString *url = self.data.ruleUrl;
    if (![url isNotNull]) {
        return;
    }
    WebViewController *controller = [[WebViewController alloc] init];
    controller.urlString = url;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)grade:(id)value {
    NSString *url = self.data.userData.radishGradeUrl;
    if (![url isNotNull]) {
        return;
    }
    WebViewController *controller = [[WebViewController alloc] init];
    controller.urlString = url;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)loadData:(id)value {
    if (![value respondsToSelector:@selector(boolValue)]) return;
    BOOL refresh = [value boolValue];
    if (refresh) {
        [self loadBaseData];
    }else{
        [self loadProducts:refresh];
    }
}

- (void)loadBaseData {
    [Request startWithName:@"GET_RADISH_HOME_PAGE" param:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        RadishMallData *data = [RadishMallModel modelWithDictionary:dic].data;
        if (data) {
            [self loadBaseDataSuccess:data];
        }else{
            [self loadBaseDataFaulure:nil];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self loadBaseDataFaulure:error];
    }];
}

- (void)loadBaseDataSuccess:(RadishMallData *)data {
    self.data = data;
    self.mallView.data = self.data;
    [self loadRadishUserData];
    [self loadProducts:YES];
}

- (void)loadBaseDataFaulure:(NSError *)error {
    [[iToast makeText:@"获取萝卜商城数据失败，请稍后再试"] show];
    [self back];
}

- (void)loadRadishUserData {
    [Request startWithName:@"GET_USER_RADISH" param:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        RadishUserData *data = [RadishUserModel modelWithDictionary:dic].data;
        if (!data) return;
        self.data.userData = data;
        [self.mallView reloadData];
    } failure:nil];
}

- (void)loadProducts:(BOOL)refresh{
    self.page = refresh?1:++self.page;
    NSDictionary *param = @{@"page":@(self.page),
                            @"pageCount":@(TCPAGECOUNT)};
    [Request startWithName:@"GET_HOME_RADISH_PRODUCTS" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        NSArray<RadishMallProduct *> *data = [RadishPageModel modelWithDictionary:dic].data;
        NSMutableArray *ary = [NSMutableArray arrayWithArray:self.data.showProducts];
        [ary addObjectsFromArray:data];
        self.data.showProducts = [NSArray arrayWithArray:ary];
        [self.mallView dealWithUI:data.count];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.mallView dealWithUI:0];
    }];
}

@end
