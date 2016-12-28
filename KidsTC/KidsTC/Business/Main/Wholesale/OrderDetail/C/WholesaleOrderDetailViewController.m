//
//  WholesaleOrderDetailViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleOrderDetailViewController.h"
#import "UIBarButtonItem+Category.h"
#import "NSString+Category.h"
#import "GHeader.h"

#import "WholesaleOrderDetailModel.h"
#import "WholesaleOrderDetailPartnerModel.h"
#import "WholesaleOrderDetailView.h"

@interface WholesaleOrderDetailViewController ()
@property (nonatomic, strong) WholesaleOrderDetailView *orderDetailView;
@property (nonatomic, strong) WholesaleOrderDetailData *data;
@end

@implementation WholesaleOrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![self.productId isNotNull]) {
        [[iToast makeText:@"商品编号为空"] show];
        [self back];
        return;
    }
    if (![self.openGroupId isNotNull]) {
        [[iToast makeText:@"开团编号为空"] show];
        [self back];
        return;
    }
    
    self.navigationItem.title = @"拼团";
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    WholesaleOrderDetailView *orderDetailView = [[WholesaleOrderDetailView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    [self.view addSubview:orderDetailView];
    self.orderDetailView = orderDetailView;
    
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
    NSDictionary *param = @{@"fightGroupId":_productId,
                            @"openGroupId":_openGroupId};
    [TCProgressHUD showSVP];
    [Request startWithName:@"GET_PRODUCT_TUAN_DETAIL_GROUP" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        WholesaleOrderDetailData *data = [WholesaleOrderDetailModel modelWithDictionary:dic].data;
        if (data) {
            [self loadDataSuccess:data];
        }else{
            [self loadDataFailure:nil];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self loadDataFailure:error];
    }];
}

- (void)loadDataSuccess:(WholesaleOrderDetailData *)data{
    self.data = data;
    self.orderDetailView.data = data;
    [self loadPartners:@(1) showProgress:NO];
}

- (void)loadDataFailure:(NSError *)error{
    [iToast makeText:@"拼团详情获取失败，请稍后再试"];
    [self back];
}

- (void)loadPartners:(id)value showProgress:(BOOL)showProgress {
    if (![value respondsToSelector:@selector(integerValue)]) return;
    NSInteger pageIndex = [value integerValue];
    NSDictionary *param = @{@"page":@(pageIndex),
                            @"pageCount":@(5),
                            @"openGroupId":_openGroupId};
    if(showProgress)[TCProgressHUD showSVP];
    [Request startWithName:@"GET_PRODUCT_TUAN_USER" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        if(showProgress)[TCProgressHUD dismissSVP];
        WholesaleOrderDetailPartnerModel *model = [WholesaleOrderDetailPartnerModel modelWithDictionary:dic];
        self.data.partners = model.data;
        if (self.data.partnerCounts.count<1) {
            self.data.partnerCounts = model.counts;
        }
        self.orderDetailView.data = self.data;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(showProgress)[TCProgressHUD dismissSVP];
        [self loadDataFailure:error];
    }];
}

@end
