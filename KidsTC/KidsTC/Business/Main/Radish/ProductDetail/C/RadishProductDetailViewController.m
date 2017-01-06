//
//  RadishProductDetailViewController.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/5.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishProductDetailViewController.h"

#import "RadishProductDetailView.h"

@interface RadishProductDetailViewController ()<RadishProductDetailViewDelegate>
@property (nonatomic, strong) RadishProductDetailView *detailView;
@end

@implementation RadishProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"萝卜商详";
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    RadishProductDetailView *detailView = [[RadishProductDetailView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    detailView.delegate = self;
    [self.view addSubview:detailView];
    self.detailView = detailView;
    
}

#pragma mark - RadishProductDetailViewDelegate

- (void)radishProductDetailView:(RadishProductDetailView *)view actionType:(RadishProductDetailViewActionType)type value:(id)value {
    switch (type) {
        case RadishProductDetailViewActionTypeSegue:
        {
            
        }
            break;
        default:
            break;
    }
}

@end
