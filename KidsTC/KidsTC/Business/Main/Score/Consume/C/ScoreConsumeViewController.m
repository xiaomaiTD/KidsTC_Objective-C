//
//  ScoreConsumeViewController.m
//  KidsTC
//
//  Created by 童成mac-dev1 on 2017/2/14.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreConsumeViewController.h"
#import "GHeader.h"
#import "SegueMaster.h"

#import "ScoreUserInfoModel.h"
#import "ScoreConsumeTopicModel.h"
#import "ScoreConsumeProductModel.h"

#import "ScoreConsumeView.h"

@interface ScoreConsumeViewController ()<ScoreConsumeViewDelegate>
@property (strong, nonatomic) IBOutlet ScoreConsumeView *consumeView;
@property (nonatomic,assign) NSInteger page;
@end

@implementation ScoreConsumeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationItem.title = @"童成会员";
    self.consumeView.delegate = self;
}

#pragma mark ScoreConsumeViewDelegate

- (void)scoreConsumeView:(ScoreConsumeView *)view actionType:(ScoreConsumeViewActionType)type value:(id)value {
    switch (type) {
        case ScoreConsumeViewActionTypeLoadData:
        {
            [self loadData:value];
        }
            break;
        case ScoreConsumeViewActionTypeSegue:
        {
            [SegueMaster makeSegueWithModel:value fromController:self];
        }
            break;
        default:
            break;
    }
}

- (void)loadData:(id)value {
    if (![value respondsToSelector:@selector(boolValue)]) {
        return;
    }
    BOOL refresh = [value boolValue];
    if (refresh) {
        [self loadBase];
        [self loadTopic:refresh];
    }else{
        [self loadList:refresh];
    }
}

- (void)loadBase {
    [Request startWithName:@"GET_USER_RADISH_SCORE_INFO" param:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        ScoreUserInfoData *data = [ScoreUserInfoModel modelWithDictionary:dic].data;
        if (data) {
            self.consumeView.userInfoData = data;
            [self.consumeView reloadData];
        }
    } failure:nil];
}

- (void)loadTopic:(BOOL)refresh {
    [Request startWithName:@"GET_TOPIC_PRODUCTS" param:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        NSArray<ScoreConsumeTopicItem *> *data = [ScoreConsumeTopicModel modelWithDictionary:dic].data;
        if (data.count>0) {
            self.consumeView.topicItems = data;
        }
        [self loadList:refresh];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self loadList:refresh];
    }];
}

- (void)loadList:(BOOL)refresh {
    self.page = refresh?1:++self.page;
    NSDictionary *params = @{@"page":@(self.page),
                             @"pageCount":@(TCPAGECOUNT)};
    [Request startWithName:@"GET_VIP_MEMBER_PRODUCTS" param:params progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        ScoreConsumeProductData *data = [ScoreConsumeProductModel modelWithDictionary:dic].data;
        if (data.products.count>0) {
            if (refresh || !self.consumeView.productData) {
                self.consumeView.productData = data;
            }else{
                NSMutableArray *ary = [NSMutableArray arrayWithArray:self.consumeView.productData.products];
                [ary addObjectsFromArray:data.products];
                self.consumeView.productData.products = [NSArray arrayWithArray:ary];
            }
        }
        [self.consumeView dealWithUI:data.products.count];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.consumeView dealWithUI:0];
    }];
}

@end
