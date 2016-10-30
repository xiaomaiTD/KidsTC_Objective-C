//
//  ProductDetailViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/24.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "ProductDetailView.h"
#import "GHeader.h"
#import "KTCMapService.h"
#import "KTCFavouriteManager.h"
#import "NSString+Category.h"
#import "BuryPointManager.h"

#import "ProductDetailModel.h"
#import "ProductDetailRecommendModel.h"
#import "ProductDetailConsultModel.h"
#import "ProductDetailGetCouponModel.h"

#import "SegueMaster.h"
#import "WebViewController.h"
#import "CommentDetailViewController.h"
#import "CommentListViewController.h"
#import "ProductDetailCalendarViewController.h"
#import "ProductDetailAddressViewController.h"
#import "ProductDetailConsultViewController.h"
#import "ProductDetailAddNewConsultViewController.h"
#import "ServiceSettlementViewController.h"
#import "TabBarController.h"
#import "SearchTableViewController.h"
#import "CommonShareViewController.h"
#import "ServiceDetailViewController.h"
#import "StoreDetailViewController.h"
#import "ProductDetailGetCouponListViewController.h"

#import "KTCBrowseHistoryView.h"
#import "KTCActionView.h"


@interface ProductDetailViewController ()<ProductDetailViewDelegate,ProductDetailAddNewConsultViewControllerDelegate,KTCActionViewDelegate,KTCBrowseHistoryViewDataSource, KTCBrowseHistoryViewDelegate,ProductDetailGetCouponListViewControllerDelegate>
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *channelId;
@end

@implementation ProductDetailViewController

- (instancetype)initWithServiceId:(NSString *)serviceId channelId:(NSString *)channelId {
    self = [super init];
    if (self) {
        _productId = serviceId;
        _channelId = channelId;
    }
    return self;
}

- (void)loadView {
    ProductDetailView *view = [[ProductDetailView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.delegate = self;
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageId = 10401;
    
    //self.naviColor = [UIColor whiteColor];
    self.navigationItem.title = @"服务详情";
    
    [self loadData];
    
    [self buildRightBarButtons];
}

- (void)loadData {
    
    if (![_productId isNotNull]) {
        [[iToast makeText:@"商品编号为空！"] show];
        return;
    }
    if (![_channelId isNotNull])_channelId=@"0";
    NSString *location  = [[KTCMapService shareKTCMapService] currentLocationString];
    NSDictionary *param = @{@"pid":_productId,
                            @"chid":_channelId,
                            @"mapaddr":location};
    [TCProgressHUD showSVP];
    [Request startWithName:@"PRODUCT_GETDETAIL_NEW" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        ProductDetailModel *model = [ProductDetailModel modelWithDictionary:dic];
        if (model.data) {
            [self loadProductSuccess:model.data];
            [self loadRecommend];
        }else{
            [self loadProductFailure:nil];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self loadProductFailure:error];
    }];
}

- (void)loadProductSuccess:(ProductDetailData *)data{
    ProductDetailView *view = (ProductDetailView *)self.view;
    view.data = data;
    self.navigationItem.title = data.simpleName;
}

- (void)loadProductFailure:(NSError *)error {
    [[iToast makeText:@"商品信息查询失败"] show];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadRecommend {
    
    NSDictionary *param = @{@"pid":_productId};
    [Request startWithName:@"GET_PRODUCT_RECOMMENDS" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        ProductDetailRecommendModel *model = [ProductDetailRecommendModel modelWithDictionary:dic];
        if (model.data.count>0) {
            ProductDetailView *view = (ProductDetailView *)self.view;
            ProductDetailData *data = view.data;
            data.recommends = model.data;
            view.data = data;
        }
    } failure:nil];
    
}

#pragma mark - ProductDetailViewDelegate

- (void)productDetailView:(ProductDetailView *)view
               actionType:(ProductDetailViewActionType)type
                    value:(id)value
{
    switch (type) {
        case ProductDetailViewActionTypeSegue://通用跳转
        {
            [self segue:value];
        }
            break;
        case ProductDetailViewActionTypeDate://显示日期
        {
            [self showDate:value];
        }
            break;
        case ProductDetailViewActionTypeAddress://显示位置
        {
            [self showAddress:value];
        }
            break;
        case ProductDetailViewActionTypeLoadConsult://加载咨询
        {
            [self loadConsult:value];
        }
            break;
        case ProductDetailViewActionTypeAddNewConsult://新增咨询
        {
            [self addNewConsult:value];
        }
            break;
        case ProductDetailViewActionTypeMoreConsult://更多咨询
        {
            [self moreConsult:value];
        }
            break;
        case ProductDetailViewActionTypeStandard://套餐信息
        {
            [self standard:value];
        }
            break;
        case ProductDetailViewActionTypeBuyStandard://购买套餐
        {
            [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
                [self buyStandard:value];
            }];
        }
            break;
        case ProductDetailViewActionTypeCoupon://优惠券
        {
            [self coupon:value];
        }
            break;
        case ProductDetailViewActionTypeConsult://在线咨询
        {
            [self consult:value];
        }
            break;
        case ProductDetailViewActionTypeContact://联系商家
        {
            [self contact:value];
        }
            break;
        case ProductDetailViewActionTypeComment://查看评论
        {
            [self comment:value];
        }
            break;
        case ProductDetailViewActionTypeMoreComment://查看全部评论
        {
            [self moreComment:value];
        }
            break;
        case ProductDetailViewActionTypeRecommend://为您推荐
        {
            [self recommend:value];
        }
            break;
        case ProductDetailViewActionTypeAttention://关注
        {
            [self attention:value];
        }
            break;
        case ProductDetailViewActionTypeBuyNow://立即购买
        {
            [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
                [self buyNow:value];
            }];
        }
            break;
    }
}

#pragma mark - segue 

- (void)segue:(id)value {
    [SegueMaster makeSegueWithModel:value fromController:self];
}

#pragma mark - showDate

- (void)showDate:(id)value {
    ProductDetailCalendarViewController *controller = [[ProductDetailCalendarViewController alloc] init];
    controller.times = value;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - showAddress

- (void)showAddress:(id)value{
    
    ProductDetailAddressViewController *controller = [[ProductDetailAddressViewController alloc] init];
    controller.store = value;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - loadConsult

- (void)loadConsult:(id)value {
    NSDictionary *param = @{@"relationNo":self.productId,
                            @"advisoryType":@"1",
                            @"pageIndex":@(1),
                            @"pageSize":@(20)};
    [TCProgressHUD showSVP];
    [Request startWithName:@"GET_ADVISORY_ADN_REPLIES" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        ProductDetailConsultModel *model = [ProductDetailConsultModel modelWithDictionary:dic];
        ProductDetailView *view = (ProductDetailView *)self.view;
        ProductDetailData *data = view.data;
        data.consults = model.items;
        view.data = data;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [[iToast makeText:@"获取咨询信息失败"] show];
    }];
}

#pragma mark - addNewConsult

- (void)addNewConsult:(id)value {
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        ProductDetailAddNewConsultViewController *controller = [[ProductDetailAddNewConsultViewController alloc] initWithNibName:@"ProductDetailAddNewConsultViewController" bundle:nil];
        controller.productId = self.productId;
        controller.delegate = self;
        controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        controller.modalPresentationStyle = UIModalPresentationCustom;
        [self presentViewController:controller animated:NO completion:nil];
    }];
}

#pragma mark ProductDetailAddNewConsultViewControllerDelegate

- (void)productDetailAddNewConsultViewController:(ProductDetailAddNewConsultViewController *)controller actionType:(ProductDetailAddNewConsultViewControllerActionType)type value:(id)value {
    switch (type) {
        case ProductDetailAddNewConsultViewControllerActionTypeReload:
        {
            [self loadConsult:nil];
        }
            break;
    }
}

#pragma mark - moreConsult 

- (void)moreConsult:(id)value {
    ProductDetailConsultViewController *controller = [[ProductDetailConsultViewController alloc] init];
    controller.productId = self.productId;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Standard

- (void)standard:(id)value {
    ProductDetailStandard *standard = value;
    ProductDetailViewController *controller = [[ProductDetailViewController alloc] initWithServiceId:standard.productId channelId:standard.channelId];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - buyStandard

- (void)buyStandard:(id)value {
    
    ProductDetailStandard *standard = value;
    NSString *storeno = standard.storeNo;
    if (![storeno isNotNull]) {
        [[iToast makeText:@"门店编号为空！"] show];
        return;
    }
    NSString *productid = standard.productId;
    if (![productid isNotNull]) {
        [[iToast makeText:@"服务编号为空！"] show];
        return;
    }
    NSString *chid = [standard.channelId isNotNull]?standard.channelId:@"0";
    NSInteger buynum = standard.buyMinNum>0?standard.buyMinNum:1;
    
    NSDictionary *param = @{@"storeno":storeno,
                            @"productid":productid,
                            @"chid":chid,
                            @"buynum":@(buynum)};
    [TCProgressHUD showSVP];
    [Request startWithName:@"SHOPPINGCART_SET_V2" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        [self goSettlement];
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

#pragma mark - coupon

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

#pragma mark ProductDetailGetCouponListViewControllerDelegate

- (void)productDetailGetCouponListViewController:(ProductDetailGetCouponListViewController *)controller
                                      actionType:(ProductDetailGetCouponListViewControllerActionType)type
                                           value:(id)value
{
    
}

#pragma mark - consult

- (void)consult:(id)value {
    WebViewController *controller = [[WebViewController alloc]init];
    controller.urlString = value;
    [self.navigationController pushViewController:controller animated:YES];
    
    [BuryPointManager trackEvent:@"event_click_server_ask" actionId:20407 params:nil];
}

#pragma mark - Contact

- (void)contact:(id)value {
    NSArray<ProductDetailStore *> *store = value;
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"请选择门店" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [store enumerateObjectsUsingBlock:^(ProductDetailStore *obj, NSUInteger idx, BOOL *stop) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:obj.storeName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self makePhoneCallWithNumbers:obj.phones];
        }];
        [controller addAction:action];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [controller addAction:cancelAction];
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)makePhoneCallWithNumbers:(NSArray *)numbers {
    if (!numbers || ![numbers isKindOfClass:[NSArray class]]) {
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

#pragma mark - Comment

- (void)comment:(id)value {
    ProductDetailView *view = (ProductDetailView *)self.view;
    ProductDetailData *data = view.data;
    NSUInteger index = [value integerValue];
    if (index<data.commentItemsArray.count) {
        CommentListItemModel *model = data.commentItemsArray[index];
        model.relationIdentifier = self.productId;
        CommentDetailViewController *controller =
        [[CommentDetailViewController alloc] initWithSource:CommentDetailViewSourceServiceOrStore
                                               relationType:(CommentRelationType)(data.productType)
                                                headerModel:model];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark - MoreComment

- (void)moreComment:(id)value {
    ProductDetailData *data = value;
    ProductDetailComment *comment = data.comment;
    NSDictionary *commentNumberDic = @{CommentListTabNumberKeyAll:@(comment.all),
                                       CommentListTabNumberKeyGood:@(comment.good),
                                       CommentListTabNumberKeyNormal:@(comment.normal),
                                       CommentListTabNumberKeyBad:@(comment.bad),
                                       CommentListTabNumberKeyPicture:@(comment.pic)};
    CommentListViewController *controller =
    [[CommentListViewController alloc] initWithIdentifier:self.productId
                                             relationType:(CommentRelationType)(data.productType)
                                         commentNumberDic:commentNumberDic];
    [self.navigationController pushViewController:controller animated:YES];
    
    NSDictionary *params = @{@"pid":_productId,
                             @"cid":_channelId};
    [BuryPointManager trackEvent:@"event_skip_server_evalist" actionId:20403 params:params];
}

#pragma mark - recommend

- (void)recommend:(id)value {
    ProductDetailRecommendItem *item = value;
    ProductDetailViewController *controller = [[ProductDetailViewController alloc] initWithServiceId:item.productNo channelId:item.channelId];
    [self.navigationController pushViewController:controller animated:YES];
    
    [BuryPointManager trackEvent:@"event_skip_server_promserver" actionId:20405 params:nil];
}

#pragma mark - attention

- (void)attention:(id)value {
    ProductDetailData *data = value;
    NSString *identifier = data.serveId;
    KTCFavouriteType type = KTCFavouriteTypeService;
    //WeakSelf(self)
    if (data.isFavor) {
        [[KTCFavouriteManager sharedManager] deleteFavouriteWithIdentifier:identifier type:type succeed:^(NSDictionary *dic) {
            //StrongSelf(self)
            //data.isFavor = NO;
        } failure:^(NSError *error) {
            //[[iToast makeText:@"添加关注失败!"] show];
        }];
    } else {
        [[KTCFavouriteManager sharedManager] addFavouriteWithIdentifier:identifier type:type succeed:^(NSDictionary *dic) {
            //StrongSelf(self)
            //data.isFavor = YES;
        } failure:^(NSError *error) {
            //[[iToast makeText:@"取消关注失败!"] show];
        }];
    }
    NSDictionary *params = @{@"pid":_productId,
                             @"cid":_channelId};
    [BuryPointManager trackEvent:@"event_result_server_favor" actionId:20401 params:params];
}

#pragma mark - buyNow

- (void)buyNow:(id)value {
    ProductDetailData *data = value;
    NSString *storeno = data.store.firstObject.storeId;
    if (![storeno isNotNull]) {
        [[iToast makeText:@"门店编号为空！"] show];
        return;
    }
    NSString *productid = data.serveId;
    if (![productid isNotNull]) {
        [[iToast makeText:@"服务编号为空！"] show];
        return;
    }
    NSString *chid = [data.chId isNotNull]?data.chId:@"0";
    NSInteger buynum = data.buyMinNum>0?data.buyMinNum:1;
    
    NSDictionary *param = @{@"storeno":storeno,
                            @"productid":productid,
                            @"chid":chid,
                            @"buynum":@(buynum)};
    [TCProgressHUD showSVP];
    [Request startWithName:@"SHOPPINGCART_SET_V2" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        [self goSettlement];
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

- (void)goSettlement {
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        ServiceSettlementViewController *controller = [[ServiceSettlementViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }];
}

#pragma mark - buildRightBarButtons

- (void)buildRightBarButtons {
    CGFloat buttonWidth = 24;
    CGFloat buttonHeight = 24;
    CGFloat buttonGap = 15;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, buttonWidth * 2 + buttonGap, buttonHeight)];
    [bgView setBackgroundColor:[UIColor clearColor]];
    
    CGFloat xPosition = 0;
    UIButton *historyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [historyButton setFrame:CGRectMake(xPosition, 0, buttonWidth, buttonHeight)];
    [historyButton setBackgroundColor:[UIColor clearColor]];
    [historyButton setImage:[UIImage imageNamed:@"navigation_time"] forState:UIControlStateNormal];
    [historyButton setImage:[UIImage imageNamed:@"navigation_time"] forState:UIControlStateSelected];
    [historyButton addTarget:self action:@selector(showHistoryView) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:historyButton];
    
    xPosition += buttonWidth + buttonGap;
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setFrame:CGRectMake(xPosition, 0, buttonWidth, buttonHeight)];
    [shareButton setBackgroundColor:[UIColor clearColor]];
    [shareButton setImage:[UIImage imageNamed:@"navigation_more"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(showActionView) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:shareButton];
    
    UIBarButtonItem *rItem = [[UIBarButtonItem alloc] initWithCustomView:bgView];
    self.navigationItem.rightBarButtonItem = rItem;
}

- (void)showHistoryView {
    
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        [[KTCActionView actionView] hide];
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
    if ([[KTCActionView actionView] isShowing]) {
        [[KTCActionView actionView] hide];
        [[KTCActionView actionView] setDelegate:nil];
    } else {
        [[KTCActionView actionView] showInViewController:self];
        [[KTCActionView actionView] setDelegate:self];
    }
}

#pragma mark KTCActionViewDelegate

- (void)actionViewDidClickedWithTag:(KTCActionViewTag)tag {
    [[KTCActionView actionView] hide];
    switch (tag) {
        case KTCActionViewTagHome:
        {
            [self.navigationController popToRootViewControllerAnimated:YES];
            [[TabBarController shareTabBarController] selectIndex:0];
        }
            break;
        case KTCActionViewTagSearch:
        {
            SearchTableViewController *controller = [[SearchTableViewController alloc]init];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case KTCActionViewTagShare:
        {
            ProductDetailView *view = (ProductDetailView *)self.view;
            ProductDetailData *data = view.data;
            CommonShareViewController *controller = [CommonShareViewController instanceWithShareObject:data.shareObject sourceType:KTCShareServiceTypeService];
            [self presentViewController:controller animated:YES completion:nil];
            
            NSDictionary *param = @{@"pid":_productId,
                                    @"cid":_channelId};
            [BuryPointManager trackEvent:@"event_result_server_share" actionId:20406 params:param];
        }
            break;
        default:
            break;
    }
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
