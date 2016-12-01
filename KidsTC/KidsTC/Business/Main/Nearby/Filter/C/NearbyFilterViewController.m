//
//  NearbyFilterViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyFilterViewController.h"
#import "Colours.h"
#import "UIBarButtonItem+Category.h"

#import "NearbyFilterView.h"

@interface NearbyFilterViewController ()<NearbyFilterViewDelegate>
@property (strong, nonatomic) IBOutlet NearbyFilterView *filterView;
@end

@implementation NearbyFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"日历";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.naviTheme = NaviThemeWihte;
    
    self.filterView.delegate = self;
}

#pragma mark - NearbyFilterViewDelegate

- (void)nearbyFilterView:(NearbyFilterView *)view actionType:(NearbyFilterViewActionType)type value:(id)value {
    switch (type) {
        case NearbyFilterViewActionTypeDidSelectDate:
        {
            
        }
            break;
        case NearbyFilterViewActionTypeDidSelectCategory:
        {
            
        }
            break;
        default:
            break;
    }
    [self back];
}









@end
