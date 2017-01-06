//
//  RadishProductOrderListViewController.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/5.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishProductOrderListViewController.h"

#import "RadishProductOrderListView.h"

@interface RadishProductOrderListViewController ()
@property (nonatomic, strong) RadishProductOrderListView *listView;
@end

@implementation RadishProductOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"萝卜";
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    RadishProductOrderListView *listView = [[RadishProductOrderListView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    listView.delegate = self;
    [self.view addSubview:listView];
    self.listView = listView;
}


@end
