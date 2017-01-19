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
#import "BuryPointManager.h"
#import "OnlineCustomerService.h"

#import "WholesaleOrderDetailModel.h"
#import "WholesaleOrderDetailPartnerModel.h"
#import "WholesaleOrderDetailView.h"

#import "WebViewController.h"
#import "WholesaleSettlementViewController.h"
#import "WolesaleProductDetailViewController.h"
#import "CommonShareViewController.h"
#import "TabBarController.h"
#import "WholesalePickDateViewController.h"

@interface WholesaleOrderDetailViewController ()<WholesaleOrderDetailViewDelegate,WholesalePickDateViewControllerDelegate>
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
    
    
    self.trackParams = @{@"pid":_productId,
                         @"gid":_openGroupId};
    
    self.navigationItem.title = @"拼团";
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    WholesaleOrderDetailView *orderDetailView = [[WholesaleOrderDetailView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    orderDetailView.delegate = self;
    [self.view addSubview:orderDetailView];
    self.orderDetailView = orderDetailView;
    
    if (!self.navigationItem.leftBarButtonItem) {
        self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"navi_back_black" highImageName:@"navi_back_black" postion:UIBarButtonPositionLeft target:self action:@selector(back)];
    }
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImagePostion:UIBarButtonPositionRight target:self action:@selector(share) andGetButton:^(UIButton *btn) {
        [btn setImageEdgeInsets:UIEdgeInsetsMake(3, 3, 3, 3)];
        [btn setImage:[UIImage imageNamed:@"wholesale_share"] forState:UIControlStateNormal];
    }];
    
    [self loadData];
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
    
    if (data.fightGroupBase.detailV2) {
        self.pageId = 10409;
    }else{
        self.pageId = 10407;
    }
}

- (void)loadDataFailure:(NSError *)error{
    [iToast makeText:@"拼团详情获取失败，请稍后再试"];
    [self back];
}



#pragma mark - WholesaleOrderDetailViewDelegate

- (void)wholesaleOrderDetailView:(WholesaleOrderDetailView *)view actionType:(WholesaleOrderDetailViewActionType)type value:(id)value {
    
    switch (type) {
        case WholesaleOrderDetailViewActionTypeRule://拼团玩法
        {
            [self rule];
        }
            break;
        case WholesaleOrderDetailViewActionTypeLoadPartners://加载参团记录
        {
            [self loadPartners:value showProgress:YES];
        }
            break;
        case WholesaleOrderDetailViewActionTypeBuy://去支付
        {
            [self buy];
        }
            break;
        case WholesaleOrderDetailViewActionTypeMySale://用户自己的拼团信息
        {
            [self mySale];
        }
            break;
        case WholesaleOrderDetailViewActionTypeProductHome://更多拼团
        {
            [self productHome];
        }
            break;
        case WholesaleOrderDetailViewActionTypeShare://分享
        {
            [self share];
        }
            break;
        case WholesaleOrderDetailViewActionTypeConsult://在线咨询
        {
            [self consult];
        }
            break;
    }
}

#pragma mark 拼团玩法

- (void)rule {
    NSString *url = self.data.fightGroupBase.flowUrl;
    if ([url isNotNull]) {
        WebViewController *controller = [[WebViewController alloc] init];
        controller.urlString = url;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark 加载参团记录

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

#pragma mark 去支付

- (void)buy {
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        if (self.data.sku.isShowTime) {
            WholesalePickDateViewController *controller = [[WholesalePickDateViewController alloc] initWithNibName:@"WholesalePickDateViewController" bundle:nil];
            controller.delegate = self;
            controller.sku = self.data.sku;
            controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            controller.modalPresentationStyle = UIModalPresentationCustom;
            [self presentViewController:controller animated:NO completion:nil];
        }else{
            [self addShoppingCart];
        }
    }];
}

// WholesalePickDateViewControllerDelegate
- (void)wholesalePickDateViewController:(WholesalePickDateViewController *)controller actionType:(WholesalePickDateViewControllerActionType)type value:(id)value {
    switch (type) {
        case WholesalePickDateViewControllerActionTypeBuy:
        {
            [self addShoppingCart];
        }
            break;
            
        default:
            break;
    }
}

- (void)addShoppingCart {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    if (![self.productId isNotNull]) {
        [[iToast makeText:@"商品编号为空"] show];
        return;
    }
    [param setObject:self.productId forKey:@"fightGroupId"];
    //time
    NSArray<WholesalePickDateTime *> *times = self.data.sku.times;
    __block WholesalePickDateTime *time = nil;
    if (times.count>0) {
        [times enumerateObjectsUsingBlock:^(WholesalePickDateTime *obj, NSUInteger idx, BOOL *stop) {
            if (obj.select) {
                time = obj;
                *stop = YES;
            }
        }];
        if(!time) time = times.firstObject;
    }
    if (time) {
        NSString *skuId = time.skuId;
        if ([skuId isNotNull]) {
            [param setObject:skuId forKey:@"skuId"];
        }
    }
    //place
    NSArray<WholesalePickDatePlace *> *places = self.data.sku.places;
    __block WholesalePickDatePlace *place = nil;
    if (places.count>0) {
        [places enumerateObjectsUsingBlock:^(WholesalePickDatePlace *obj, NSUInteger idx, BOOL *stop) {
            if (obj.select) {
                place = obj;
                *stop = YES;
            }
        }];
        if(!place) place = places.firstObject;
    }
    if (place) {
        NSString * placeID = place.ID;
        if ([placeID isNotNull]) {
            switch (self.data.fightGroupBase.placeType) {
                case PlaceTypeStore:
                {
                    [param setObject:placeID forKey:@"storeNo"];
                }
                    break;
                case PlaceTypePlace:
                {
                    [param setObject:placeID forKey:@"placeNo"];
                }
                    break;
                default:
                    break;
            }
        }
    }
    
    [TCProgressHUD showSVP];
    [Request startWithName:@"ADD_FIGHT_GROUP_SHOPPING_CART" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        [self addShoppingCartSuccess];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self addShoppingCartFailure:error];
    }];
}

- (void)addShoppingCartSuccess {
    if (self.presentedViewController) {
        [self.presentedViewController dismissViewControllerAnimated:YES completion:^{
            [self gotoSettlement];
        }];
    }else{
        [self gotoSettlement];
    }
}

- (void)addShoppingCartFailure:(NSError *)error {
    NSString *errMsg = @"加入购物车失败，请稍后再试！";
    NSString *text = [NSString stringWithFormat:@"%@",error.userInfo[@"data"]];
    if ([text isNotNull]) errMsg = text;
    [[iToast makeText:errMsg] show];
}

- (void)gotoSettlement {
    WholesaleSettlementViewController *controller = [[WholesaleSettlementViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark 用户自己的拼团信息

- (void)mySale {
    long long openGroupSysNo = self.data.openGroupSysNo;
    WholesaleOrderDetailViewController *controller = [[WholesaleOrderDetailViewController alloc] init];
    controller.productId = self.productId;
    controller.openGroupId = [NSString stringWithFormat:@"%lld",openGroupSysNo];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark 更多拼团

- (void)productHome {
    WolesaleProductDetailViewController *controller = [[WolesaleProductDetailViewController alloc] init];
    controller.productId = self.productId;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark 分享

- (void)share {
    CommonShareViewController *controller = [CommonShareViewController instanceWithShareObject:self.data.fightGroupBase.shareObject sourceType:KTCShareServiceTypeWholesale];
    [self presentViewController:controller animated:YES completion:nil];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if ([self.productId isNotNull]) {
        [params setObject:self.productId forKey:@"pid"];
    }
    [params setObject:@(self.data.openGroupSysNo) forKey:@"gid"];
    [BuryPointManager trackEvent:@"event_click_group_share" actionId:21801 params:params];
}

#pragma mark 在线咨询

- (void)consult {
    NSString *str = [OnlineCustomerService onlineCustomerServiceLinkUrlString];
    if ([str isNotNull]) {
        WebViewController *controller = [[WebViewController alloc]init];
        controller.urlString = str;
        [self.navigationController pushViewController:controller animated:YES];
        [BuryPointManager trackEvent:@"event_click_server_ask" actionId:20407 params:nil];
    }
}

@end
