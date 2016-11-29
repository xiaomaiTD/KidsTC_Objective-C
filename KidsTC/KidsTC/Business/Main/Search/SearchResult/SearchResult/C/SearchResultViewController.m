//
//  SearchResultViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchResultViewController.h"
#import "SearchResultToolBar.h"

@interface SearchResultViewController ()

@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupToolBar];
}

- (void)setupToolBar {
    SearchResultToolBar *toolBar = [[NSBundle mainBundle] loadNibNamed:@"SearchResultToolBar" owner:self options:nil].firstObject;
    toolBar.frame = CGRectMake(0, 64, SCREEN_WIDTH, 44);
    [self.view addSubview:toolBar];
}


@end
