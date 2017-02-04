//
//  NormalProductDetailViewController.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/3.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "NormalProductDetailViewController.h"
#import "NSString+Category.h"
#import "GHeader.h"
#import "KTCMapService.h"
#import "BuryPointManager.h"
#import "SegueMaster.h"
#import "OnlineCustomerService.h"
#import "KTCFavouriteManager.h"
#import "ZPPopover.h"
#import "KTCBrowseHistoryView.h"
#import "RecommendDataManager.h"

#import "NormalProductDetailModel.h"
#import "NormalProductDetailConsultModel.h"
#import "ProductDetailGetCouponModel.h"


#import "NormalProductDetailView.h"
#import "NormalProductDetailNaviRightView.h"

#import "ProductDetailAddressViewController.h"
#import "ProductDetailAddNewConsultViewController.h"
#import "ProductDetailConsultViewController.h"
#import "CommentDetailViewController.h"
#import "CommentListViewController.h"
#import "ProductDetailGetCouponListViewController.h"
#import "ProductDetailCalendarViewController.h"
#import "ProductStandardViewController.h"
#import "ProductDetailViewController.h"
#import "ServiceSettlementViewController.h"
#import "WebViewController.h"
#import "TabBarController.h"
#import "NavigationController.h"
#import "SearchViewController.h"
#import "StoreDetailViewController.h"
#import "CommonShareViewController.h"

@interface NormalProductDetailViewController ()
<
NormalProductDetailNaviRightViewDelegate,
NormalProductDetailViewDelegate,
ProductDetailAddNewConsultViewControllerDelegate,
ProductDetailGetCouponListViewControllerDelegate,
ProductStandardViewControllerDelegate,
ZPPopoverDelegate,
KTCBrowseHistoryViewDelegate,
KTCBrowseHistoryViewDataSource
>
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, strong) NormalProductDetailView *productDetailView;
@property (nonatomic, strong) NormalProductDetailData *data;

@property (nonatomic, strong) NSString *consultStr;
@end

@implementation NormalProductDetailViewController

- (instancetype)initWithProductId:(NSString *)productId channelId:(NSString *)channelId {
    self = [super init];
    if (self) {
        _productId = productId;
        _channelId = channelId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![self.productId isNotNull]) {
        [[iToast makeText:@"商品编号为空！"] show];
        [self back];
        return;
    }
    if (![self.channelId isNotNull]) {
        self.channelId = @"0";
    }
    
    [self loadData];
    
    [self setupNavi];
    
    [self setupView];
    
}

#pragma mark - setupNavi

- (void)setupNavi {
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NormalProductDetailNaviRightView *naviRightView = [[NSBundle mainBundle] loadNibNamed:@"NormalProductDetailNaviRightView" owner:self options:nil].firstObject;
    naviRightView.delegate = self;
    naviRightView.bounds = CGRectMake(0, 0, 64, 26);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:naviRightView];
}

#pragma mark NormalProductDetailNaviRightViewDelegate

- (void)normalProductDetailNaviRightView:(NormalProductDetailNaviRightView *)view actionType:(NormalProductDetailNaviRightViewActionType)type value:(id)value {
    switch (type) {
        case NormalProductDetailNaviRightViewActionTypeHistory:
        {
            [self showHistoryView];
        }
            break;
        case NormalProductDetailNaviRightViewActionTypeMore:
        {
            [self showActionView];
        }
            break;
        default:
            break;
    }
}

#pragma mark - setupView

- (void)setupView {
    NormalProductDetailView *productDetailView = [[NormalProductDetailView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    productDetailView.delegate = self;
    [self.view addSubview:productDetailView];
    self.productDetailView = productDetailView;
}

#pragma mark NormalProductDetailViewDelegate

- (void)normalProductDetailView:(NormalProductDetailView *)view actionType:(NormalProductDetailViewActionType)type value:(id)value {
    switch (type) {
        case NormalProductDetailViewActionTypeShowAddress:
        {
            [self showAddress:value];
        }
            break;
        case NormalProductDetailViewActionTypeAddNewConsult:
        {
            [self addNewConsult:value];
        }
            break;
        case NormalProductDetailViewActionTypeMoreConsult:
        {
            [self moreConsult:value];
        }
            break;
        case NormalProductDetailViewActionTypeComment:
        {
            [self comment:value];
        }
            break;
        case NormalProductDetailViewActionTypeMoreComment:
        {
            [self moreComment:value];
        }
            break;
        case NormalProductDetailViewActionTypeCoupon:
        {
            [self coupon:value];
        }
            break;
        case NormalProductDetailViewActionTypeShowDate:
        {
            [self showDate:value];
        }
            break;
        case NormalProductDetailViewActionTypeSegue:
        {
            [self segue:value];
        }
            break;
        case NormalProductDetailViewActionTypeSelectStandard:
        {
            [self selectStandard:value];
        }
            break;
        case NormalProductDetailViewActionTypeStandard:
        {
            [self standard:value];
        }
            break;
        case NormalProductDetailViewActionTypeBuyStandard:
        {
            [self buyStandard:value];
        }
            break;
        case NormalProductDetailViewActionTypeConsult:
        {
            [self consult:value];
        }
            break;
        case NormalProductDetailViewActionTypeContact:
        {
            [self contact:value];
        }
            break;
        case NormalProductDetailViewActionTypeToolBarConsult:
        {
            [self consult:value];
        }
            break;
        case NormalProductDetailViewActionTypeAttention:
        {
            [self attention:value];
        }
            break;
        case NormalProductDetailViewActionTypeBuyNow:
        {
            [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
                [self buyNow:value];
            }];
        }
            break;
        case NormalProductDetailViewActionTypeCountDownOver:
        {
            [self loadData];
        }
            break;
        default:
            break;
    }
}

#pragma mark showAddress

- (void)showAddress:(id)value{
    PlaceType placeType = _data.placeType;
    NSArray<ProductDetailAddressSelStoreModel *> *places = [ProductDetailAddressSelStoreModel modelsWithNormalProductDetailPlaceType:_data.placeType stores:_data.store places:_data.place];
    if (places.count<1) {
        return;
    }
    ProductDetailAddressViewController *controller = [[ProductDetailAddressViewController alloc] init];
    controller.placeType = placeType;
    controller.places = places;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark addNewConsult

- (void)addNewConsult:(id)value {
    ProductDetailAddNewConsultViewController *controller = [[ProductDetailAddNewConsultViewController alloc] initWithNibName:@"ProductDetailAddNewConsultViewController" bundle:nil];
    controller.type = ProductDetailTypeNormal;
    controller.productId = self.productId;
    controller.delegate = self;
    controller.consultStr = self.consultStr;
    controller.dellocBlock = ^(NSString *consultStr){
        self.consultStr = consultStr;
    };
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    controller.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:controller animated:NO completion:nil];
}

- (void)productDetailAddNewConsultViewController:(ProductDetailAddNewConsultViewController *)controller actionType:(ProductDetailAddNewConsultViewControllerActionType)type value:(id)value {
    
}

#pragma mark moreConsult

- (void)moreConsult:(id)value {
    ProductDetailConsultViewController *controller = [[ProductDetailConsultViewController alloc] init];
    controller.type = ProductDetailTypeNormal;
    controller.productId = self.productId;
    controller.consultStr = self.consultStr;
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark comment

- (void)comment:(id)value {
    NSUInteger index = [value integerValue];
    if (index<_data.commentItemsArray.count) {
        CommentListItemModel *model = _data.commentItemsArray[index];
        NSString *identifier = self.productId;
        CommentRelationType type = (CommentRelationType)(_data.productType);
        model.relationIdentifier = identifier;
        CommentDetailViewController *controller =
        [[CommentDetailViewController alloc] initWithSource:CommentDetailViewSourceServiceOrStore
                                               relationType:type
                                                headerModel:model];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark moreComment

- (void)moreComment:(id)value {
    
    NSString *identifier = self.productId;
    CommentRelationType type= (CommentRelationType)(_data.productType);
    NormalProductDetailComment *comment = _data.comment;
    NSDictionary *commentNumberDic = @{CommentListTabNumberKeyAll:@(comment.all),
                                       CommentListTabNumberKeyGood:@(comment.good),
                                       CommentListTabNumberKeyNormal:@(comment.normal),
                                       CommentListTabNumberKeyBad:@(comment.bad),
                                       CommentListTabNumberKeyPicture:@(comment.pic)};
    CommentListViewController *controller =
    [[CommentListViewController alloc] initWithIdentifier:identifier
                                             relationType:type
                                         commentNumberDic:commentNumberDic];
    [self.navigationController pushViewController:controller animated:YES];
    
    NSDictionary *params = @{@"pid":_productId,
                             @"cid":_channelId};
    [BuryPointManager trackEvent:@"event_skip_server_evalist" actionId:20403 params:params];
}

#pragma mark coupon

- (void)coupon:(id)value {
    BOOL canProvideCoupon = [value boolValue];
    if (canProvideCoupon) {
        NSDictionary *param = @{@"productId":self.productId};
        [TCProgressHUD showSVP];
        [Request startWithName:@"GET_PRODUCT_DETAIL_USER_COUPON" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
            [TCProgressHUD dismissSVP];
            ProductDetailGetCouponModel *model = [ProductDetailGetCouponModel modelWithDictionary:dic];
            if (model.data.count<1) {
                [[iToast makeText:@"该商品暂无优惠券哦~"] show];
                return;
            }
            ProductDetailGetCouponListViewController *controller = [[ProductDetailGetCouponListViewController alloc] initWithNibName:@"ProductDetailGetCouponListViewController" bundle:nil];
            controller.coupons = model.data;
            controller.productId = self.productId;
            controller.channelId = self.channelId;
            controller.delegate = self;
            controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
            controller.modalPresentationStyle = UIModalPresentationCustom;
            [self presentViewController:controller animated:NO completion:nil];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [TCProgressHUD dismissSVP];
            [[iToast makeText:@"获取优惠券列表失败，请稍后再试~"] show];
        }];
    }
}

- (void)productDetailGetCouponListViewController:(ProductDetailGetCouponListViewController *)controller
                                      actionType:(ProductDetailGetCouponListViewControllerActionType)type
                                           value:(id)value
{
    
}

#pragma mark showDate

- (void)showDate:(id)value {
    ProductDetailCalendarViewController *controller = [[ProductDetailCalendarViewController alloc] init];
    controller.times = self.data.time.times;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark segue

- (void)segue:(id)value {
    [SegueMaster makeSegueWithModel:value fromController:self];
}


#pragma mark selectStandard

- (void)selectStandard:(id)value {
    if (self.data.product_standards.count<2) {
        [[iToast makeText:@"无更多套餐信息"] show];
        return;
    }
    ProductStandardViewController *controller = [[ProductStandardViewController alloc] initWithNibName:@"ProductStandardViewController" bundle:nil];
    controller.delegate = self;
    controller.product_standards = self.data.product_standards;
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    controller.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:controller animated:NO completion:nil];
}

- (void)productStandardViewController:(ProductStandardViewController *)controller actionType:(ProductStandardViewControllerActionTyp)type value:(id)value {
    switch (type) {
        case ProductStandardViewControllerActionTypDidSelectStandard:
        {
            if (![value isNotNull]) {
                return;
            }
            if ([value isEqualToString:self.productId]) {
                return;
            }
            self.productId = value;
            [self loadData];
        }
            break;
        case ProductStandardViewControllerActionTypBuyStandard:
        {
            [self buyStandard:value];
        }
            break;
        default:
            break;
    }
}


#pragma mark standard

- (void)standard:(id)value {
    if (![value isKindOfClass:[ProductDetailStandard class]]) {
        return;
    }
    ProductDetailStandard *standard = value;
    ProductDetailViewController *controller = [[ProductDetailViewController alloc] initWithServiceId:standard.productId channelId:standard.channelId];
    controller.type = standard.productRedirect;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark buyStandard

- (void)buyStandard:(id)value {
    
    ProductDetailStandard *standard = value;
    
    NSString *productid = standard.productId;
    if (![productid isNotNull]) {
        [[iToast makeText:@"服务编号为空！"] show];
        return;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [param setObject:productid forKey:@"productid"];
    
    NSString *storeno = standard.storeNo;
    if ([storeno isNotNull]) {
        [param setObject:storeno forKey:@"storeno"];
    }
    
    NSString *chid = [standard.channelId isNotNull]?standard.channelId:@"0";
    [param setObject:chid forKey:@"chid"];
    
    NSInteger buynum = standard.buyMinNum>0?standard.buyMinNum:1;
    [param setObject:@(buynum) forKey:@"buynum"];
    
    if (_data.placeType == PlaceTypePlace) {
        if (_data.place.count>0) {
            NormalProductDetailPlace *place = _data.place.firstObject;
            NSString *placeNo = place.sysNo;
            if ([place.sysNo isNotNull]) {
                [param setObject:placeNo forKey:@"placeNo"];
            }
        }
    }
    
    [TCProgressHUD showSVP];
    [Request startWithName:@"SHOPPINGCART_SET_V2" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        [self goSettlement:ProductDetailTypeNormal];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [[iToast makeText:@"加入购物车失败，请稍后再试！"] show];
    }];
    
    NSDictionary *params = @{@"pid":_productId,
                             @"cid":_channelId,
                             @"num":@(buynum),
                             @"sid":storeno};
    [BuryPointManager trackEvent:@"event_result_server_addtocart" actionId:20404 params:params];
}

- (void)goSettlement:(ProductDetailType)type {
    ServiceSettlementViewController *controller = [[ServiceSettlementViewController alloc]init];
    controller.type = type;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark consult

- (void)consult:(id)value {
    NSString *str = [OnlineCustomerService onlineCustomerServiceLinkUrlString];
    if ([str isNotNull]) {
        WebViewController *controller = [[WebViewController alloc]init];
        controller.urlString = str;
        [self.navigationController pushViewController:controller animated:YES];
        [BuryPointManager trackEvent:@"event_click_server_ask" actionId:20407 params:nil];
    }
}

#pragma mark contact

- (void)contact:(id)value {
    
    NSArray<NormalProductDetailStore *> *store = _data.store;
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"请选择门店" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [store enumerateObjectsUsingBlock:^(NormalProductDetailStore *obj, NSUInteger idx, BOOL *stop) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:obj.storeName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self makePhoneCallWithNumbers:obj.phones];
        }];
        [controller addAction:action];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [controller addAction:cancelAction];
    if (controller.actions.count>1) {
        [self presentViewController:controller animated:YES completion:nil];
    }else{
        [[iToast makeText:@"暂无商户电话哦，您可选择在线咨询~"] show];
    }
}

- (void)makePhoneCallWithNumbers:(NSArray *)numbers {
    if (!numbers || numbers.count<1 || ![numbers isKindOfClass:[NSArray class]]) {
        [[iToast makeText:@"该门店暂无联系方式"] show];
        return;
    }
    if ([numbers count] == 0) {
        [[iToast makeText:@"该门店暂无联系方式"] show];
        return;
    } else if ([numbers count] == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", [numbers firstObject]]]];
    } else {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"请选择联系电话" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        for (NSString *phoneNumber in numbers) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:phoneNumber style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", phoneNumber]]];
            }];
            [controller addAction:action];
        }
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [controller addAction:cancelAction];
        [self presentViewController:controller animated:YES completion:nil];
    }
}

#pragma mark attention

- (void)attention:(id)value {
    if (_data.isFavor) {
        [[KTCFavouriteManager sharedManager] deleteFavouriteWithIdentifier:_data.serveId type:KTCFavouriteTypeService succeed:nil failure:nil];
    } else {
        [[KTCFavouriteManager sharedManager] addFavouriteWithIdentifier:_data.serveId type:KTCFavouriteTypeService succeed:nil failure:nil];
    }
    NSDictionary *params = @{@"pid":_productId,
                             @"cid":_channelId};
    [BuryPointManager trackEvent:@"event_result_server_favor" actionId:20401 params:params];
}


#pragma mark buyNow

- (void)buyNow:(id)value {
    
    NSString *productid = _data.serveId;
    if (![productid isNotNull]) {
        [[iToast makeText:@"服务编号为空！"] show];
        return;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [param setObject:productid forKey:@"productid"];
    
    NSString *storeno = _data.store.firstObject.storeId;
    if ([storeno isNotNull]) {
        [param setObject:storeno forKey:@"storeno"];
    }
    
    NSString *chid = [_data.chId isNotNull]?_data.chId:@"0";
    [param setObject:chid forKey:@"chid"];
    
    NSInteger buynum = _data.buyMinNum>0?_data.buyMinNum:1;
    [param setObject:@(buynum) forKey:@"buynum"];
    
    if (_data.placeType == PlaceTypePlace) {
        if (_data.place.count>0) {
            NormalProductDetailPlace *place = _data.place.firstObject;
            NSString *placeNo = place.sysNo;
            if ([place.sysNo isNotNull]) {
                [param setObject:placeNo forKey:@"placeNo"];
            }
        }
    }
    
    [TCProgressHUD showSVP];
    [Request startWithName:@"SHOPPINGCART_SET_V2" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        [self goSettlement:ProductDetailTypeNormal];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [[iToast makeText:@"加入购物车失败，请稍后再试！"] show];
    }];
    
    NSDictionary *params = @{@"pid":_productId,
                             @"cid":_channelId,
                             @"num":@(buynum),
                             @"sid":storeno};
    [BuryPointManager trackEvent:@"event_result_server_addtocart" actionId:20404 params:params];
}

#pragma mark loadData

- (void)loadData {
    NSString *location  = [[KTCMapService shareKTCMapService] currentLocationString];
    NSDictionary *param = @{@"pid":_productId,
                            @"chid":_channelId,
                            @"mapaddr":location};
    [TCProgressHUD showSVP];
    [Request startWithName:@"PRODUCT_GETDETAIL_NEW" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        NormalProductDetailData *data = [NormalProductDetailModel modelWithDictionary:dic].data;
        if (data) {
            [self loadDataSuccessWithData:data];
        }else{
            [self loadDataFailure:nil];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self loadDataFailure:error];
    }];
}

- (void)loadDataSuccessWithData:(NormalProductDetailData *)data {
    self.data = data;
    self.productDetailView.data = data;
    self.navigationItem.title = data.simpleName;
    
    [self loadConsult];
    
    [self loadRecommend];
}

- (void)loadDataFailure:(NSError *)error {
    NSString *errMsg = @"商品信息获取失败！";
    NSString *text = [NSString stringWithFormat:@"%@",error.userInfo[@"data"]];
    if ([text isNotNull]) errMsg = text;
    [[iToast makeText:errMsg] show];
    [self back];
}

- (void)loadConsult {
    NSDictionary *param = @{@"relationNo":_productId,
                            @"advisoryType":@(ProductDetailTypeNormal),
                            @"pageIndex":@(1),
                            @"pageSize":@(20)};
    [Request startWithName:@"GET_ADVISORY_ADN_REPLIES" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        NSArray<NormalProductDetailConsultItem *> *items = [NormalProductDetailConsultModel modelWithDictionary:dic].items;
        if (items.count>0) {
            self.data.consults = items;
            self.productDetailView.data = self.data;
        }
    } failure:nil];
}

- (void)loadRecommend {
    [[RecommendDataManager shareRecommendDataManager] loadRecommendProductType:RecommendProductTypeNormal refresh:YES pageCount:TCPAGECOUNT productNos:_productId successBlock:^(NSArray<RecommendProduct *> *data) {
        if (data.count>0) {
            self.data.recommends = data;
            self.productDetailView.data = self.data;
        }
    } failureBlock:nil];
}

#pragma mark - 待处理垃圾

- (void)showHistoryView {
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        if ([[KTCBrowseHistoryView historyView] isShowing]) {
            [[KTCBrowseHistoryView historyView] startLoadingAnimation:NO];
            [[KTCBrowseHistoryView historyView] setDelegate:nil];
            [[KTCBrowseHistoryView historyView] setDataSource:nil];
            [[KTCBrowseHistoryView historyView] hide];
        } else {
            [[KTCBrowseHistoryView historyView] startLoadingAnimation:YES];
            [[KTCBrowseHistoryView historyView] setDelegate:self];
            [[KTCBrowseHistoryView historyView] setDataSource:self];
            [[KTCBrowseHistoryView historyView] showInViewController:self];
            [self getHistoryDataForTag:KTCBrowseHistoryViewTagService needMore:NO];
        }
    }];
}

- (void)showActionView {
    [[KTCBrowseHistoryView historyView] hide];
    
    CGFloat rightMargin = 28;
    if ([UIScreen mainScreen].bounds.size.width>400) rightMargin = 32;
    CGFloat barBtnX = CGRectGetWidth([[UIScreen mainScreen] bounds]) - rightMargin;
    CGFloat barBtnY = 48;
    
    ZPPopoverItem *popoverItem1 = [ZPPopoverItem makeZpMenuItemWithImageName:@"productDetail_popover_home"  title:@"首页"];
    ZPPopoverItem *popoverItem2 = [ZPPopoverItem makeZpMenuItemWithImageName:@"productDetail_popover_search" title:@"搜索"];
    ZPPopoverItem *popoverItem3 = [ZPPopoverItem makeZpMenuItemWithImageName:@"productDetail_popover_share" title:@"分享"];
    ZPPopover *popover = [ZPPopover popoverWithTopPointInWindow:CGPointMake(barBtnX, barBtnY) items:@[popoverItem1,popoverItem2,popoverItem3]];
    popover.delegate = self;
    [popover show];
}

#pragma mark ZPPopoverDelegate

- (void)didSelectMenuItemAtIndex:(NSUInteger)index {
    if (index == 0) {
        [[TabBarController shareTabBarController] selectIndex:0];
    }else if (index == 1) {
        SearchViewController *controller = [[SearchViewController alloc]init];
        NavigationController *navi = [[NavigationController alloc] initWithRootViewController:controller];
        [self presentViewController:navi animated:NO completion:nil];
    }else if (index == 2){
        [self share];
    }
}

- (void)share {
    CommonShareViewController *controller = [CommonShareViewController instanceWithShareObject:self.data.shareObject sourceType:KTCShareServiceTypeService];
    [self presentViewController:controller animated:YES completion:nil];
    
    NSDictionary *param = @{@"pid":_productId,
                            @"cid":_channelId};
    [BuryPointManager trackEvent:@"event_result_server_share" actionId:20406 params:param];
}

#pragma mark KTCBrowseHistoryViewDataSource & KTCBrowseHistoryViewDelegate

- (NSString *)titleForBrowseHistoryView:(KTCBrowseHistoryView *)view withTag:(KTCBrowseHistoryViewTag)tag {
    NSString *title = @"浏览足迹";
    if (![[User shareUser] hasLogin]) {
        title = @"尚未登录";
    }
    return title;
}

- (NSArray *)itemModelsForBrowseHistoryView:(KTCBrowseHistoryView *)view withTag:(KTCBrowseHistoryViewTag)tag {
    if ([[User shareUser] hasLogin]) {
        KTCBrowseHistoryType type = [KTCBrowseHistoryView typeOfViewTag:tag];
        NSArray *array = [[KTCBrowseHistoryManager sharedManager] resultForType:type];
        return [NSArray arrayWithArray:array];
    }
    return nil;
}

- (void)browseHistoryView:(KTCBrowseHistoryView *)view didSelectedItemAtIndex:(NSUInteger)index {
    KTCBrowseHistoryType type = [KTCBrowseHistoryView typeOfViewTag:view.currentTag];
    NSArray *array = [[KTCBrowseHistoryManager sharedManager] resultForType:type];
    switch (type) {
        case KTCBrowseHistoryTypeService:
        {
            BrowseHistoryServiceListItemModel *model = [array objectAtIndex:index];
            ProductDetailViewController *controller = [[ProductDetailViewController alloc] initWithServiceId:model.identifier channelId:model.channelId];
            controller.type = model.productRedirect;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case KTCBrowseHistoryTypeStore:
        {
            BrowseHistoryStoreListItemModel *model = [array objectAtIndex:index];
            StoreDetailViewController *controller = [[StoreDetailViewController alloc] initWithStoreId:model.identifier];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)browseHistoryView:(KTCBrowseHistoryView *)view didChangedTag:(KTCBrowseHistoryViewTag)tag {
    [self getHistoryDataForTag:tag needMore:NO];
}

- (void)browseHistoryView:(KTCBrowseHistoryView *)view didPulledUpToloadMoreForTag:(KTCBrowseHistoryViewTag)tag {
    [self getHistoryDataForTag:tag needMore:YES];
}

- (void)getHistoryDataForTag:(KTCBrowseHistoryViewTag)tag needMore:(BOOL)need {
    KTCBrowseHistoryType type = [KTCBrowseHistoryView typeOfViewTag:tag];
    [[KTCBrowseHistoryView historyView] endLoadMore];
    
    [[KTCBrowseHistoryManager sharedManager] getUserBrowseHistoryWithType:type needMore:need succeed:^(NSArray *modelsArray) {
        [[KTCBrowseHistoryView historyView] reloadDataForTag:tag];
        [[KTCBrowseHistoryView historyView] startLoadingAnimation:NO];
        [[KTCBrowseHistoryView historyView] noMoreData:need forTag:tag];
    } failure:^(NSError *error) {
        [[KTCBrowseHistoryView historyView] reloadDataForTag:tag];
        [[KTCBrowseHistoryView historyView] startLoadingAnimation:NO];
    }];
    
}

@end
