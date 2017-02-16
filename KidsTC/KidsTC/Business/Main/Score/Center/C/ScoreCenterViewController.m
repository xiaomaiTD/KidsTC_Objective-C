//
//  ScoreCenterViewController.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/24.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreCenterViewController.h"
#import "GHeader.h"
#import "NSString+Category.h"

#import "ScoreCenterView.h"

#import "ScoreUserInfoModel.h"
#import "ScoreRecordModel.h"

#import "WebViewController.h"
#import "ScoreEarnViewController.h"
#import "ScoreConsumeViewController.h"
#import "ScoreRecordViewController.h"

@interface ScoreCenterViewController ()<ScoreCenterViewDelegate>
@property (strong, nonatomic) IBOutlet ScoreCenterView *centerView;
@property (nonatomic,strong) ScoreUserInfoData *userInfoData;
@property (nonatomic,assign) BOOL showSvp;
@end

@implementation ScoreCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"积分";
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.centerView.delegate = self;
    self.showSvp = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadBase];
    self.showSvp = NO;
}

- (void)loadBase {
    if(self.showSvp) [TCProgressHUD showSVP];
    [Request startWithName:@"GET_USER_RADISH_SCORE_INFO" param:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        ScoreUserInfoData *data = [ScoreUserInfoModel modelWithDictionary:dic].data;
        if (data) {
            [self loadBaseSuccess:data];
        }else{
            [self loadBaseFailure:nil];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self loadBaseFailure:error];
    }];
}

- (void)loadBaseSuccess:(ScoreUserInfoData *)data {
    self.userInfoData = data;
    self.centerView.userInfoData = data;
    [self loadScoreRecord];
}

- (void)loadBaseFailure:(NSError *)error {
    NSString *errMsg = @"获取用户积分信息失败！";
    NSString *text = [NSString stringWithFormat:@"%@",error.userInfo[@"data"]];
    if ([text isNotNull]) errMsg = text;
    [[iToast makeText:errMsg] show];
    [self back];
}

- (void)loadScoreRecord {
    NSDictionary *param = @{@"page":@(1),
                            @"pagecount":@(TCPAGECOUNT)};
    [Request startWithName:@"SCORE_FLOW_QUERY" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        NSArray<ScoreRecordItem *> *data = [ScoreRecordModel modelWithDictionary:dic].data;
        self.centerView.records = data;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        self.centerView.records = nil;
        [TCProgressHUD dismissSVP];
    }];
}

#pragma mark ScoreCenterViewDelegate

- (void)scoreCenterView:(ScoreCenterView *)view actionType:(ScoreCenterViewActionType)type vlaue:(id)value {
    switch (type) {
        case ScoreCenterViewActionTypeRule:
        {
            WebViewController *controller = [[WebViewController alloc] init];
            controller.urlString = self.userInfoData.socreRuleUrl;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case ScoreCenterViewActionTypeGet:
        {
            [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
                ScoreEarnViewController *controller = [[ScoreEarnViewController alloc] initWithNibName:@"ScoreEarnViewController" bundle:nil];
                [self.navigationController pushViewController:controller animated:YES];
            }];
        }
            break;
        case ScoreCenterViewActionTypeUse:
        {
            [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
                ScoreConsumeViewController *controller = [[ScoreConsumeViewController alloc] initWithNibName:@"ScoreConsumeViewController" bundle:nil];
                [self.navigationController pushViewController:controller animated:YES];
            }];
        }
            break;
        case ScoreCenterViewActionTypeMore:
        {
            ScoreRecordViewController *controller = [[ScoreRecordViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        default:
            break;
    }
}

@end
