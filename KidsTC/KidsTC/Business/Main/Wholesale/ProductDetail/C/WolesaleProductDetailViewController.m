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

#import "WebViewController.h"
#import "WholesaleOrderDetailViewController.h"
#import "ProductDetailCalendarViewController.h"
#import "ProductDetailAddressViewController.h"
#import "WholesaleSettlementViewController.h"
#import "CommonShareViewController.h"


@interface WolesaleProductDetailViewController ()<WolesaleProductDetailViewDelegate>
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
    productDetailView.delegate = self;
    [self.view addSubview:productDetailView];
    self.productDetailView = productDetailView;
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImagePostion:UIBarButtonPositionRight target:self action:@selector(share) andGetButton:^(UIButton *btn) {
        [btn setImageEdgeInsets:UIEdgeInsetsMake(3, 3, 3, 3)];
        [btn setImage:[UIImage imageNamed:@"wholesale_share"] forState:UIControlStateNormal];
    }];
    
    [self loadData];
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
    [self loadJoinTeam:@(1) showProgress:NO];
    [self loadOtherProduct:@(1) showProgress:NO];
}

- (void)loadDataFailure:(NSError *)error{
    [iToast makeText:@"商品详情获取失败，请稍后再试"];
    [self back];
}


#pragma mark - WolesaleProductDetailViewDelegate

- (void)wolesaleProductDetailView:(WolesaleProductDetailView *)view actionType:(WolesaleProductDetailViewActionType)type value:(id)value {

    switch (type) {
        case WolesaleProductDetailViewActionTypeRule://活动规则
        {
            [self rule];
        }
            break;
        case WolesaleProductDetailViewActionTypeJoinOther://参加其他团
        {
            [self joinOther:value];
        }
            break;
        case WolesaleProductDetailViewActionTypeTime://显示时间
        {
            [self time];
        }
            break;
        case WolesaleProductDetailViewActionTypeAddress://显示位置
        {
            [self address];
        }
            break;
        case WolesaleProductDetailViewActionTypeOtherProduct://其他拼团
        {
            [self otherProduct:value];
        }
            break;
        case WolesaleProductDetailViewActionTypeWebLoadFinish://web加载完毕
        {
            //刷新当前页面
        }
            break;
        case WolesaleProductDetailViewActionTypeLoadTeam://加载参加其他团
        {
            [self loadJoinTeam:value showProgress:YES];
        }
            break;
        case WolesaleProductDetailViewActionTypeLoadOtherProduct://加载其他拼团
        {
            [self loadOtherProduct:value showProgress:YES];
        }
            break;
        case WolesaleProductDetailViewActionTypeShare://分享
        {
            [self share];
        }
            break;
        case WolesaleProductDetailViewActionTypeJoin://我要参团
        {
            //滚动到其他团的位置
        }
            break;
        case WolesaleProductDetailViewActionTypeSale://我要组团
        {
            [self sale];
        }
            break;
        case WolesaleProductDetailViewActionTypeMySale://我的拼团
        {
            [self mySale:value];
        }
            break;
        case WolesaleProductDetailViewActionTypeCountDownOver://倒计时结束
        {
            [self loadData];
        }
            break;
    }
}

#pragma mark 活动规则

- (void)rule {
    NSString *url = self.data.fightGroupBase.flowUrl;
    if ([url isNotNull]) {
        WebViewController *controller = [[WebViewController alloc] init];
        controller.urlString = url;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark 参加其他团

- (void)joinOther:(id)value {
    if ([value isKindOfClass:[WholesaleProductDetailTeam class]]) {
        WholesaleProductDetailTeam *team = value;
        WholesaleOrderDetailViewController *controller = [[WholesaleOrderDetailViewController alloc] init];
        controller.productId = self.productId;
        controller.openGroupId = team.openGroupSysNo;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark 显示时间

- (void)time {
    NSArray<ProductDetailTimeItem *> *times = self.data.fightGroupBase.productTime.times;
    if (times.count>0) {
        ProductDetailCalendarViewController *controller = [[ProductDetailCalendarViewController alloc] init];
        controller.times = times;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark 显示位置

- (void)address {
    WholesaleProductDetailBase *base = self.data.fightGroupBase;
    PlaceType placeType = base.placeType;
    NSArray<ProductDetailAddressSelStoreModel *> *places = [ProductDetailAddressSelStoreModel modelsWithWolesaleProductDetailPlaceType:placeType stores:base.stores places:base.place];
    if (places.count<1) {
        return;
    }
    ProductDetailAddressViewController *controller = [[ProductDetailAddressViewController alloc] init];
    controller.placeType = self.data.fightGroupBase.placeType;
    controller.places = places;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark 其他拼团

- (void)otherProduct:(id)value {
    if ([value isKindOfClass:[WholesaleProductDetailOtherProduct class]]) {
        WholesaleProductDetailOtherProduct *otherProduct = value;
        WolesaleProductDetailViewController *controller = [[WolesaleProductDetailViewController alloc] init];
        controller.productId = otherProduct.sysNo;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark 加载参加其他团

- (void)loadJoinTeam:(id)value showProgress:(BOOL)showProgress{
    if (![value respondsToSelector:@selector(integerValue)]) return;
    NSInteger pageIndex = [value integerValue];
    NSDictionary *param = @{@"page":@(pageIndex),
                            @"pageCount":@(5),
                            @"fightGroupId":_productId};
    if(showProgress)[TCProgressHUD showSVP];
    [Request startWithName:@"GET_PRODUCT_TUAN_OPEN_GROUP" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        if(showProgress)[TCProgressHUD dismissSVP];
        WholesaleProductDetailTeamModel *model = [WholesaleProductDetailTeamModel modelWithDictionary:dic];
        WholesaleProductDetailBase *base = self.data.fightGroupBase;
        base.teams = model.data;
        if (base.teamCounts.count<1) {
            base.teamCounts = model.counts;
        }
        self.productDetailView.data = self.data;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(showProgress)[TCProgressHUD dismissSVP];
    }];
}

#pragma mark 加载其他拼团

- (void)loadOtherProduct:(id)value showProgress:(BOOL)showProgress{
    if (![value respondsToSelector:@selector(integerValue)]) return;
    NSInteger pageIndex = [value integerValue];
    NSDictionary *param = @{@"page":@(pageIndex),
                            @"pageCount":@(5),
                            @"fightGroupId":_productId};
    if(showProgress)[TCProgressHUD showSVP];
    [Request startWithName:@"GET_OTHER_PRODUCT_TUAN" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        if(showProgress)[TCProgressHUD dismissSVP];
        WholesaleProductDetailOtherProductModel *model = [WholesaleProductDetailOtherProductModel modelWithDictionary:dic];
        WholesaleProductDetailBase *base = self.data.fightGroupBase;
        base.otherProducts = model.data;
        if (base.otherProductCounts.count<1) {
            base.otherProductCounts = model.counts;
        }
        self.productDetailView.data = self.data;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if(showProgress)[TCProgressHUD dismissSVP];
    }];
}

#pragma mark 分享

- (void)share {
    CommonShareViewController *controller = [CommonShareViewController instanceWithShareObject:self.data.fightGroupBase.shareObject sourceType:KTCShareServiceTypeWholesale];
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark 我要组团

- (void)sale {
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        WholesaleSettlementViewController *controller = [[WholesaleSettlementViewController alloc] init];
        controller.productId = self.productId;
        controller.openGroupId = [NSString stringWithFormat:@"%zd",self.data.openGroupSysNo];
        [self.navigationController pushViewController:controller animated:YES];
    }];
}

#pragma mark 我的拼团

- (void)mySale:(id)value {
    long long openGroupSysNo = self.data.openGroupSysNo;
    WholesaleOrderDetailViewController *controller = [[WholesaleOrderDetailViewController alloc] init];
    controller.productId = self.productId;
    controller.openGroupId = [NSString stringWithFormat:@"%lld",openGroupSysNo];
    [self.navigationController pushViewController:controller animated:YES];
}



@end
