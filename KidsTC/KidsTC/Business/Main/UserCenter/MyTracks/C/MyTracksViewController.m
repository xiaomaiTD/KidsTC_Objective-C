//
//  MyTracksViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "MyTracksViewController.h"
#import "UIBarButtonItem+Category.h"

#import "MyTracksView.h"

@interface MyTracksViewController ()<MyTracksViewDelegate>
@property (nonatomic, strong) MyTracksView *tracksView;
@end

@implementation MyTracksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的足迹👣";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.naviTheme = NaviThemeWihte;
    
    MyTracksView *tracksView = [[MyTracksView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    tracksView.delegate = self;
    [self.view addSubview:tracksView];
    self.tracksView = tracksView;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"编辑" postion:UIBarButtonPositionRight target:self action:@selector(edit) andGetButton:^(UIButton *btn) {
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    }];
    
}

- (void)edit {
    TCLog(@"---");
}

#pragma mark - MyTracksViewDelegate

- (void)myTracksView:(MyTracksView *)view actionType:(MyTracksViewActionType)type value:(id)value {
    switch (type) {
        case MyTracksViewActionTypeLoadData:
        {
            [self loadData:[value boolValue]];
        }
            break;
            
        default:
            break;
    }
}

- (void)loadData:(BOOL)refresh {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [NSThread sleepForTimeInterval:2];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tracksView endRefresh:NO];
        });
    });
}


@end
