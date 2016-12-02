//
//  NearbyViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyViewController.h"
#import "NavigationController.h"

#import "NearbyView.h"
#import "NearbyTitleView.h"
#import "NearbyCalendarViewController.h"
#import "MapLocateViewController.h"
#import "SearchViewController.h"
#import "NurseryViewController.h"

@interface NearbyViewController ()<NearbyTitleViewDelegate,NearbyViewDelegate>
@property (weak, nonatomic) NearbyView *nearbyView;
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
            SearchViewController *controller = [[SearchViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
    }
}

#pragma mark - NearbyViewDelegate

- (void)nearbyView:(NearbyView *)view actionType:(NearbyViewActionType)type value:(id)value {
    switch (type) {
        case NearbyViewActionTypeNursery:
        {
            NurseryViewController *controller = [[NurseryViewController alloc] init];
            controller.type = NurseryTypeNursery;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case NearbyViewActionTypeExhibition:
        {
            
        }
            break;
        case NearbyViewActionTypeCalendar:
        {
            NearbyCalendarViewController *controller = [[NearbyCalendarViewController alloc] initWithNibName:@"NearbyCalendarViewController" bundle:nil];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
    }
}



@end
