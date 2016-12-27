//
//  WolesaleProductDetailViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WolesaleProductDetailViewController.h"
#import "UIBarButtonItem+Category.h"
#import "GHeader.h"
#import "NSString+Category.h"

#import "WolesaleProductDetailModel.h"
#import "WolesaleProductDetailView.h"

#import "WholesaleProductDetailTeamModel.h"
#import "WholesaleProductDetailOtherProductModel.h"

@interface WolesaleProductDetailViewController ()
@property (nonatomic, strong) WolesaleProductDetailView *productDetailView;
@property (nonatomic, strong) WolesaleProductDetailData *data;
@end

@implementation WolesaleProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![_productId isNotNull]) {
        [iToast makeText:@"商品编号为空"];
        [self back];
        return;
    }
    
    self.navigationItem.title = @"拼团";
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    WolesaleProductDetailView *productDetailView = [[WolesaleProductDetailView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    [self.view addSubview:productDetailView];
    self.productDetailView = productDetailView;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImagePostion:UIBarButtonPositionRight target:self action:@selector(rightBarButtonItemAction:) andGetButton:^(UIButton *btn) {
        [btn setImageEdgeInsets:UIEdgeInsetsMake(3, 3, 3, 3)];
        [btn setImage:[UIImage imageNamed:@"wholesale_share"] forState:UIControlStateNormal];
    }];
    
    [self loadData];
}

- (void)rightBarButtonItemAction:(UIButton *)btn {
    TCLog(@"");
}

- (void)loadData {
    NSDictionary *param = @{@"fightGroupId":_productId};
    [TCProgressHUD showSVP];
    [Request startWithName:@"GET_PRODUCT_TUAN_DETAIL" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        WolesaleProductDetailData *data = [WolesaleProductDetailModel modelWithDictionary:dic].data;
        if (data.fightGroupBase) {
            [self loadDataSuccess:data];
        }else{
            [self loadDataFailure:nil];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self loadDataFailure:error];
    }];
}

- (void)loadDataSuccess:(WolesaleProductDetailData *)data{
    self.data = data;
    self.productDetailView.data = data;
    [self loadJoinTeam];
    [self loadOtherProduct];
}

- (void)loadDataFailure:(NSError *)error{
    [iToast makeText:@"商品详情获取失败，请稍后再试"];
    [self back];
}

- (void)loadJoinTeam {
    NSDictionary *param = @{@"page":@(1),
                            @"pageCount":@(5),
                            @"fightGroupId":_productId};
    [TCProgressHUD showSVP];
    [Request startWithName:@"GET_PRODUCT_TUAN_OPEN_GROUP" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        self.data.fightGroupBase.teams = [WholesaleProductDetailTeamModel modelWithDictionary:dic].data;
        self.productDetailView.data = self.data;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
    }];
}

- (void)loadOtherProduct {
    NSDictionary *param = @{@"page":@(1),
                            @"pageCount":@(5),
                            @"fightGroupId":_productId};
    [TCProgressHUD showSVP];
    [Request startWithName:@"GET_OTHER_PRODUCT_TUAN" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        self.data.fightGroupBase.otherProducts = [WholesaleProductDetailOtherProductModel modelWithDictionary:dic].data;
        self.productDetailView.data = self.data;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
    }];
}


@end
