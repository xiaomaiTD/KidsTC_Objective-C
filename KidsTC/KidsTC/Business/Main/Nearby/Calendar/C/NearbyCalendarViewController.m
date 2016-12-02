//
//  NearbyCalendarViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyCalendarViewController.h"
#import "Colours.h"
#import "UIBarButtonItem+Category.h"

#import "NearbyCalendarView.h"

@interface NearbyCalendarViewController ()<NearbyCalendarViewDelegate>
@property (strong, nonatomic) IBOutlet NearbyCalendarView *filterView;
@end

@implementation NearbyCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"日历";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.naviTheme = NaviThemeWihte;
    self.filterView.delegate = self;
}

#pragma mark - NearbyCalendarViewDelegate

- (void)nearbyCalendarView:(NearbyCalendarView *)view actionType:(NearbyCalendarViewActionType)type value:(id)value {
    
}







@end
