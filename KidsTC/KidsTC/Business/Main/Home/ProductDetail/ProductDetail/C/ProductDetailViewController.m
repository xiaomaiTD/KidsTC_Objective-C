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
#import "GuideManager.h"
#import "OnlineCustomerService.h"
#import "UIBarButtonItem+Category.h"
#import "ZPPopover.h"

#import "ProductDetailDataManager.h"
#import "ProductDetailSubViewsProvider.h"
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
#import "SearchViewController.h"
#import "CommonShareViewController.h"
#import "StoreDetailViewController.h"
#import "ProductDetailGetCouponListViewController.h"
#import "ProductDetailTicketSelectSeatViewController.h"
#import "ProductDetailFreeApplyViewController.h"
#import "StoreDetailViewController.h"

#import "KTCBrowseHistoryView.h"

@interface ProductDetailViewController ()<ProductDetailViewDelegate,ProductDetailAddNewConsultViewControllerDelegate,KTCBrowseHistoryViewDataSource, KTCBrowseHistoryViewDelegate,ProductDetailGetCouponListViewControllerDelegate,ZPPopoverDelegate>
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, strong) ProductDetailView *detailView;
@property (nonatomic, strong) ProductDetailDataManager *dataManager;
@property (nonatomic, strong) ProductDetailSubViewsProvider *subViewsProvider;
@property (nonatomic, strong) UIButton *historyBtn;
@property (nonatomic, strong) UIButton *shareBtn;
@property (nonatomic, assign) BOOL isNaviBGClearColor;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _type = ProductDetailTypeFree;
    _productId = @"3000000004";//100001  //3000000004
    _channelId = @"0";

    switch (_type) {
        case ProductDetailTypeNormal:
        case ProductDetailTypeTicket:
        case ProductDetailTypeFree:
            break;
        default:
        {
            _type = ProductDetailTypeNormal;
        }
            break;
    }
    
    if (![_productId isNotNull]) {
        [[iToast makeText:@"商品编号为空！"] show];
        [self back];
        return;
    }
    if (![_channelId isNotNull])_channelId=@"0";
    
    self.pageId = 10401;
    self.trackParams = @{@"pid":_productId,
                         @"cid":_channelId};
    
    self.navigationItem.title = @"服务详情";
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.naviTheme = NaviThemeWihte;
    
    switch (_type) {
        case ProductDetailTypeNormal:
        {
            
        }
            break;
        case ProductDetailTypeTicket:
        {
            self.naviColor = [UIColor clearColor];
        }
            break;
        case ProductDetailTypeFree:
        {
            
        }
            break;
    }
    
    _dataManager = [ProductDetailDataManager shareProductDetailDataManager];
    _dataManager.type = _type;
    _dataManager.productId = _productId;
    _dataManager.channelId = _channelId;
    
    _subViewsProvider = [ProductDetailSubViewsProvider shareProductDetailSubViewsProvider];
    _subViewsProvider.type = _type;
    
    [self loadData];
    
    [self buildRightBarButtons];
}

- (ProductDetailView *)detailView {
    if (!_detailView) {
        _detailView = [[ProductDetailView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _detailView.delegate = self;
        [self.view addSubview:_detailView];
    }
    return _detailView;
}

- (void)loadData {
    [TCProgressHUD showSVP];
    [_dataManager loadDataWithSuccessBlock:^(ProductDetailData *data) {
        [TCProgressHUD dismissSVP];
        [self loadDataSuccess:data];
    } failureBlock:^(NSError *error) {
        [TCProgressHUD dismissSVP];
        [self loadDataFailure:error];
    }];
}

- (void)loadDataSuccess:(ProductDetailData *)data{
    _data = data;
    _data.type = _type;
    self.detailView.data = data;
    self.navigationItem.title = data.simpleName;
    [[GuideManager shareGuideManager] checkGuideWithTarget:self type:GuideTypeProductDetail resultBlock:nil];
    [self loadRecommend];
    [self loadConsult];
}

- (void)loadDataFailure:(NSError *)error {
    [[iToast makeText:@"商品信息查询失败"] show];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - loadRecommend

- (void)loadRecommend {
    [_dataManager loadRecommendSuccessBlock:^(NSArray<ProductDetailRecommendItem *> *recommends) {
        _data.recommends = recommends;
        self.detailView.data = _data;
    } failureBlock:nil];
}

#pragma mark - loadConsult

- (void)loadConsult {
    [_dataManager loadConsultSuccessBlock:^(NSArray<ProductDetailConsultItem *> *items) {
        _data.consults = items;
        self.detailView.data = _data;
    } failureBlock:nil];
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
        case ProductDetailViewActionTypeShowDate://显示日期
        {
            [self showDate:value];
        }
            break;
        case ProductDetailViewActionTypeShowAddress://显示位置
        {
            [self showAddress:value];
        }
            break;
        case ProductDetailViewActionTypeOpenWebView://展开detail
        {}
            break;
        case ProductDetailViewActionTypeAddNewConsult://新增咨询
        {
            [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
                [self addNewConsult:value];
            }];
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
        case ProductDetailViewActionTypeTicketLike://票务 - 想看
        {
            [self attentionType:KTCFavouriteTypeTicketService value:value];
        }
            break;
        case ProductDetailViewActionTypeTicketStar://票务 - 评分
        {
            
        }
            break;
        case ProductDetailViewActionTypeTicketOpenDes://票务 - 展开描述
        {
            
        }
            break;
        case ProductDetailViewActionTypeFreeStoreDetail://免费 - 门店详情
        {
            [self freeStoreDetail:value];
        }
            break;
        case ProductDetailViewActionTypeFreeMoreTricks://免费 - 更多生活小窍门
        {
            [self freeMoreTricks:value];
        }
            break;
        case ProductDetailViewActionTypeTwoColumnToolBarDetail://展示商品H5详情
        {}
            break;
        case ProductDetailViewActionTypeTwoColumnToolBarConsult://展示商品咨询
        {}
            break;
            
        case ProductDetailViewActionTypeCountDonwFinished://倒计时结束
        {
            [self loadData];
        }
            break;
            
        case ProductDetailViewActionTypeToolBarConsult://300,//在线咨询
        {
            [self consult:value];
        }
            break;
        case ProductDetailViewActionTypeToolBarAttention://(添加/取消)关注
        {
            [self attentionType:KTCFavouriteTypeService value:value];
        }
            break;
        case ProductDetailViewActionTypeToolBarBuyNow://立即购买
        {
            [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
                [self buyNow:value];
            }];
        }
            break;
        case ProductDetailViewActionTypeTicketToolBarComment://票务 - 评价
        {
            [self ticketToolBarComment:value];
        }
            break;
        case ProductDetailViewActionTypeTicketToolBarStar://票务 - 想看
        {
            [self attentionType:KTCFavouriteTypeTicketService value:value];
        }
            break;
        case ProductDetailViewActionTypeTicketToolBarSelectSeat://票务 - 选座购票
        {
            [self ticketSelectSeat:value];
        }
            break;
        case ProductDetailViewActionTypeTicketHeaderLike://票务 - 想看
        {
            [self attentionType:KTCFavouriteTypeTicketService value:value];
        }
            break;
        case ProductDetailViewActionTypeTicketHeaderStar://票务 - 评分
        {
            
        }
            break;
        case ProductDetailViewActionTypeFreeToolBarLike://免费商详 - 喜欢、收藏
        {
            [self attentionType:KTCFavouriteTypeFreeService value:value];
        }
            break;
        case ProductDetailViewActionTypeFreeToolBarApply://免费商详 - 我要报名
        {
            [self freeToolBarApply:value];
        }
            break;
        case ProductDetailViewActionTypeFreeToolBarShare://免费商详 - 分享
        {
            [self freeToolBarShare:value]; 
        }
            break;
        case ProductDetailViewDidScroll://滚动
        {
            [self didScroll:value];
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
    if (_data.store.count<1) {
        return;
    }
    ProductDetailAddressViewController *controller = [[ProductDetailAddressViewController alloc] init];
    controller.store = _data.store;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - addNewConsult

- (void)addNewConsult:(id)value {
    ProductDetailAddNewConsultViewController *controller = [[ProductDetailAddNewConsultViewController alloc] initWithNibName:@"ProductDetailAddNewConsultViewController" bundle:nil];
    controller.type = _type;
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

#pragma mark ProductDetailAddNewConsultViewControllerDelegate

- (void)productDetailAddNewConsultViewController:(ProductDetailAddNewConsultViewController *)controller actionType:(ProductDetailAddNewConsultViewControllerActionType)type value:(id)value {
    switch (type) {
        case ProductDetailAddNewConsultViewControllerActionTypeReload:
        {
            [self loadConsult];
        }
            break;
    }
}

#pragma mark - moreConsult 

- (void)moreConsult:(id)value {
    ProductDetailConsultViewController *controller = [[ProductDetailConsultViewController alloc] init];
    controller.type = _type;
    controller.productId = self.productId;
    controller.consultStr = self.consultStr;
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

#pragma mark ProductDetailGetCouponListViewControllerDelegate

- (void)productDetailGetCouponListViewController:(ProductDetailGetCouponListViewController *)controller
                                      actionType:(ProductDetailGetCouponListViewControllerActionType)type
                                           value:(id)value
{
    
}

#pragma mark - consult

- (void)consult:(id)value {
    NSString *str = [OnlineCustomerService onlineCustomerServiceLinkUrlString];
    if (str.length>0) {
        WebViewController *controller = [[WebViewController alloc]init];
        controller.urlString = str;
        [self.navigationController pushViewController:controller animated:YES];
        [BuryPointManager trackEvent:@"event_click_server_ask" actionId:20407 params:nil];
    }
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
    if (controller.actions.count>0) {
        [self presentViewController:controller animated:YES completion:nil];
    }else{
        [[iToast makeText:@"暂无商户电话哦，您可选择在线咨询~"] show];
    }
    
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
    NSUInteger index = [value integerValue];
    if (index<_data.commentItemsArray.count) {
        CommentListItemModel *model = _data.commentItemsArray[index];
        model.relationIdentifier = self.productId;
        CommentDetailViewController *controller =
        [[CommentDetailViewController alloc] initWithSource:CommentDetailViewSourceServiceOrStore
                                               relationType:(CommentRelationType)(_data.productType)
                                                headerModel:model];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark - MoreComment

- (void)moreComment:(id)value {
    ProductDetailComment *comment = _data.comment;
    NSDictionary *commentNumberDic = @{CommentListTabNumberKeyAll:@(comment.all),
                                       CommentListTabNumberKeyGood:@(comment.good),
                                       CommentListTabNumberKeyNormal:@(comment.normal),
                                       CommentListTabNumberKeyBad:@(comment.bad),
                                       CommentListTabNumberKeyPicture:@(comment.pic)};
    CommentListViewController *controller =
    [[CommentListViewController alloc] initWithIdentifier:self.productId
                                             relationType:(CommentRelationType)(_data.productType)
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

- (void)attentionType:(KTCFavouriteType)type value:(id)value {
    if (_data.isFavor) {
        [[KTCFavouriteManager sharedManager] deleteFavouriteWithIdentifier:_data.serveId type:type succeed:nil failure:nil];
    } else {
        [[KTCFavouriteManager sharedManager] addFavouriteWithIdentifier:_data.serveId type:type succeed:nil failure:nil];
    }
    NSDictionary *params = @{@"pid":_productId,
                             @"cid":_channelId};
    [BuryPointManager trackEvent:@"event_result_server_favor" actionId:20401 params:params];
}

#pragma mark - freeStoreDetail

- (void)freeStoreDetail:(id)value {
    NSArray<ProductDetailStore *> *stores = self.data.store;
    if (stores.count<1) return;
    StoreDetailViewController *controller = [[StoreDetailViewController alloc] initWithStoreId:stores.firstObject.storeId];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - freeMoreTricks

- (void)freeMoreTricks:(id)value {
    
}

#pragma mark - buyNow

- (void)buyNow:(id)value {
    NSString *storeno = _data.store.firstObject.storeId;
    if (![storeno isNotNull]) {
        [[iToast makeText:@"门店编号为空！"] show];
        return;
    }
    NSString *productid = _data.serveId;
    if (![productid isNotNull]) {
        [[iToast makeText:@"服务编号为空！"] show];
        return;
    }
    NSString *chid = [_data.chId isNotNull]?_data.chId:@"0";
    NSInteger buynum = _data.buyMinNum>0?_data.buyMinNum:1;
    
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
    ServiceSettlementViewController *controller = [[ServiceSettlementViewController alloc]init];
    controller.type = _type;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)ticketToolBarComment:(id)value {
    
}

#pragma mark - ticketSelectSeat

- (void)ticketSelectSeat:(id)value {
    ProductDetailTicketSelectSeatViewController *controller = [[ProductDetailTicketSelectSeatViewController alloc] initWithNibName:@"ProductDetailTicketSelectSeatViewController" bundle:nil];
    controller.productId = self.productId;
    controller.channelId = self.channelId;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - FreeToolBarApply

- (void)freeToolBarApply:(id)value {
    ProductDetailFreeApplyViewController *controller = [[ProductDetailFreeApplyViewController alloc] init];
    controller.data = self.data;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - FreeToolBarShare

- (void)freeToolBarShare:(id)value {
    [self share];
}

- (void)didScroll:(id)value {
    switch (_type) {
        case ProductDetailTypeNormal:
        {
            
        }
            break;
        case ProductDetailTypeTicket:
        {
            CGFloat offsetY = [value floatValue];
            self.naviColor = [[UIColor whiteColor] colorWithAlphaComponent:offsetY/64];
            if (offsetY<64) {
                if (!self.isNaviBGClearColor) {
                    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
                    [self.backBtn setImage:[UIImage imageNamed:@"navi_back_white"] forState:UIControlStateNormal];
                    UINavigationBar *navigationBar = self.navigationController.navigationBar;
                    NSDictionary *textAttrs = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
                    [navigationBar setTitleTextAttributes:textAttrs];
                    [self.historyBtn setImage:[UIImage imageNamed:@"ProductDetail_ticket_time"] forState:UIControlStateNormal];
                    [self.shareBtn setImage:[UIImage imageNamed:@"ProductDetail_navi_more_white"] forState:UIControlStateNormal];
                    self.isNaviBGClearColor = YES;
                }
            }else{
                if (self.isNaviBGClearColor) {
                    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
                    [self.backBtn setImage:[UIImage imageNamed:@"navi_back_black"] forState:UIControlStateNormal];
                    UINavigationBar *navigationBar = self.navigationController.navigationBar;
                    NSDictionary *textAttrs = @{NSForegroundColorAttributeName:[UIColor blackColor]};
                    [navigationBar setTitleTextAttributes:textAttrs];
                    [self.historyBtn setImage:[UIImage imageNamed:@"ProductDetail_navi_clock"] forState:UIControlStateNormal];
                    [self.shareBtn setImage:[UIImage imageNamed:@"ProductDetail_navi_more"] forState:UIControlStateNormal];
                    self.isNaviBGClearColor = NO;
                }
            }
        }
            break;
        case ProductDetailTypeFree:
        {
            
        }
            break;
    }
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
    historyButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [historyButton setImage:[UIImage imageNamed:@"ProductDetail_navi_clock"] forState:UIControlStateNormal];
    [historyButton addTarget:self action:@selector(showHistoryView) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:historyButton];
    self.historyBtn = historyButton;
    
    xPosition += buttonWidth + buttonGap;
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setFrame:CGRectMake(xPosition, 0, buttonWidth, buttonHeight)];
    [shareButton setBackgroundColor:[UIColor clearColor]];
    [shareButton setImageEdgeInsets:UIEdgeInsetsMake(2, 0, 2, 0)];
    shareButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [shareButton setImage:[UIImage imageNamed:@"ProductDetail_navi_more"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(showActionView) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:shareButton];
    self.shareBtn = shareButton;
    
    UIBarButtonItem *rItem = [[UIBarButtonItem alloc] initWithCustomView:bgView];
    self.navigationItem.rightBarButtonItem = rItem;
}

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
    [self rightBarButtonItemAction];
}

- (void)rightBarButtonItemAction{
    CGFloat rightMargin = 28;
    if ([UIScreen mainScreen].bounds.size.width>400) rightMargin = 32;
    CGFloat barBtnX = CGRectGetWidth([[UIScreen mainScreen] bounds]) - rightMargin;
    CGFloat barBtnY = 46;
    
    ZPPopoverItem *popoverItem1 = [ZPPopoverItem makeZpMenuItemWithImageName:@"menu_home"  title:@"首页"];
    ZPPopoverItem *popoverItem2 = [ZPPopoverItem makeZpMenuItemWithImageName:@"menu_share" title:@"搜索"];
    ZPPopoverItem *popoverItem3 = [ZPPopoverItem makeZpMenuItemWithImageName:@"menu_topic" title:@"分享"];
    ZPPopover *popover = [ZPPopover popoverWithTopPointInWindow:CGPointMake(barBtnX, barBtnY) items:@[popoverItem1,popoverItem2,popoverItem3]];
    popover.delegate = self;
    [popover show];
}

#pragma mark - ZPPopoverDelegate

- (void)didSelectMenuItemAtIndex:(NSUInteger)index {
    if (index == 0) {
        [[TabBarController shareTabBarController] selectIndex:0];
    }else if (index == 1) {
        SearchViewController *controller = [[SearchViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
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

- (void)dealloc {
    [_subViewsProvider nilViews];
}

@end
