//
//  NearbyViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyViewController.h"
#import "NavigationController.h"
#import "GHeader.h"

#import "NearbyModel.h"
#import "NearbyView.h"
#import "NearbyTitleView.h"
#import "NearbyCalendarViewController.h"
#import "MapLocateViewController.h"
#import "SearchViewController.h"
#import "NurseryViewController.h"


@interface NearbyViewController ()<NearbyTitleViewDelegate,NearbyViewDelegate>
@property (weak, nonatomic) NearbyView *nearbyView;
@property (nonatomic, strong) NSArray<NSArray<NearbyItem *> *> *items;
@end

@implementation NearbyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NearbyView *nearbyView = [[NearbyView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    nearbyView.delegate = self;
    [self.view addSubview:nearbyView];
    self.nearbyView = nearbyView;
    
    NearbyTitleView *titleView = [[NSBundle mainBundle] loadNibNamed:@"NearbyTitleView" owner:self options:nil].firstObject;
    titleView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    titleView.delegate = self;
    self.navigationItem.titleView = titleView;
    
}

#pragma mark - NearbyTitleViewDelegate

- (void)nearbyTitleView:(NearbyTitleView *)view actionType:(NearbyTitleViewActionType)type value:(id)v {
    switch (type) {
        case NearbyTitleViewActionTypeAddress:
        {
            MapLocateViewController *controller = [[MapLocateViewController alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
            
        case NearbyTitleViewActionTypeSearch:
        {
            SearchViewController *controller = [[SearchViewController alloc]init];
            NavigationController *navi = [[NavigationController alloc] initWithRootViewController:controller];
            [self presentViewController:navi animated:NO completion:nil];
        }
            break;
    }
}

#pragma mark - NearbyViewDelegate

- (void)nearbyView:(NearbyView *)view nearbyCollectionViewCell:(NearbyCollectionViewCell *)cell actionType:(NearbyViewActionType)type value:(id)value {
    switch (type) {
        case NearbyViewActionTypeNursery:
        {
            [self nursery:value];
        }
            break;
        case NearbyViewActionTypeExhibition:
        {
            [self nursery:value];
        }
            break;
        case NearbyViewActionTypeCalendar:
        {
            [self calendar:value];
        }
            break;
        case NearbyViewActionTypeLoadData:
        {
            [self loadData:value completionBlock:^(NSInteger count) {
                [cell dealWithUI:count];
            }];
        }
            break;
    }
}

#pragma mark ============ 育儿室 ============

- (void)nursery:(id)value {
    NurseryViewController *controller = [[NurseryViewController alloc] init];
    controller.type = NurseryTypeNursery;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark ============跳转日历============

- (void)calendar:(id)value {
    NearbyCalendarViewController *controller = [[NearbyCalendarViewController alloc] initWithNibName:@"NearbyCalendarViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark ============加载数据============

- (void)loadData:(id)value completionBlock:(void(^)(NSInteger count))completionBlock{
    
    NSDictionary *param = @{@"st":@"1",//排序规则
                            @"c":@"",//分类ID
                            @"s":@"",//地区
                            @"a":@"",//年龄段
                            @"k":@"",//关键字
                            @"pt":@"",//人群
                            @"page":@(1),
                            @"pageSize":@(TCPAGECOUNT)};
    
    [Request startWithName:@"SEARCH_NEARBY_PRODUCT" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        if(completionBlock)completionBlock(0);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(completionBlock)completionBlock(0);
    }];
}



@end
