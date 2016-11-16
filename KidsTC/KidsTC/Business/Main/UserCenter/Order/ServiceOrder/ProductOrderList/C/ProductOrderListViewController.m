//
//  ProductOrderListViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/16.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderListViewController.h"
#import "UIBarButtonItem+Category.h"

#import "ProductOrderListView.h"

@interface ProductOrderListViewController ()<ProductOrderListViewDelegate>
@property (nonatomic, strong) ProductOrderListView *listView;
@end

@implementation ProductOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"订单列表";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.naviTheme = NaviThemeWihte;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:@"编辑" postion:UIBarButtonPositionRight target:self action:@selector(edit) andGetButton:^(UIButton *btn) {
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    }];
    
    ProductOrderListView *listView = [[ProductOrderListView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    listView.delegate = self;
    [self.view addSubview:listView];
    self.listView = listView;
}


- (void)edit {
    TCLog(@"---");
}

#pragma mark - ProductOrderListViewDelegate

- (void)productOrderListView:(ProductOrderListView *)view actionType:(ProductOrderListViewActionType)type value:(id)value {
    switch (type) {
        case ProductOrderListViewActionTypeLoadData:
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
            [self.listView endRefresh:NO];
        });
    });
}

@end
