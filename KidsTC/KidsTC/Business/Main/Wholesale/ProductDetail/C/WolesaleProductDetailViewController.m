//
//  WolesaleProductDetailViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WolesaleProductDetailViewController.h"
#import "UIBarButtonItem+Category.h"

#import "WolesaleProductDetailView.h"

@interface WolesaleProductDetailViewController ()
@property (nonatomic, strong) WolesaleProductDetailView *productDetailView;
@end

@implementation WolesaleProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"拼团";
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    WolesaleProductDetailView *productDetailView = [[WolesaleProductDetailView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    [self.view addSubview:productDetailView];
    self.productDetailView = productDetailView;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImageName:@"wholesale_share" highImageName:nil postion:UIBarButtonPositionRight target:self action:@selector(rightBarButtonItemAction:)];
}

- (void)rightBarButtonItemAction:(UIButton *)btn {
    TCLog(@"");
}


@end
