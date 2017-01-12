//
//  RadishProductDetailViewController.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/5.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishProductDetailViewController.h"
#import "GHeader.h"
#import "NSString+Category.h"
#import "ProductDetailDataManager.h"
#import "KTCBrowseHistoryView.h"
#import "ZPPopover.h"
#import "TabBarController.h"
#import "NavigationController.h"
#import "SegueMaster.h"
#import "KTCFavouriteManager.h"
#import "OnlineCustomerService.h"

#import "RadishProductDetailModel.h"
#import "RadishProductDetailView.h"

#import "SearchViewController.h"
#import "CommonShareViewController.h"
#import "StoreDetailViewController.h"
#import "ProductDetailCalendarViewController.h"
#import "ProductDetailAddressViewController.h"
#import "ProductDetailAddNewConsultViewController.h"
#import "ProductDetailConsultViewController.h"
#import "ProductDetailViewController.h"
#import "WebViewController.h"
#import "CommentListViewController.h"
#import "CommentDetailViewController.h"
#import "RadishSettlementViewController.h"

@interface RadishProductDetailViewController ()
<
RadishProductDetailViewDelegate,
ZPPopoverDelegate,
KTCBrowseHistoryViewDelegate,KTCBrowseHistoryViewDataSource,
ProductDetailAddNewConsultViewControllerDelegate
>
@property (nonatomic, strong) RadishProductDetailView *detailView;
@property (nonatomic, strong) RadishProductDetailData *data;
@property (nonatomic, strong) ProductDetailDataManager *dataManager;
@end

@implementation RadishProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _productId = @"16";
    
    if (![_productId isNotNull]) {
        [[iToast makeText:@"商品编号为空"] show];
        [self back];
        return;
    }
    if (![_channelId isNotNull]) {
        _channelId = @"0";
    }
    
    _dataManager = [ProductDetailDataManager new];
    _dataManager.type = ProductDetailTypeRadish;
    _dataManager.productId = _productId;
    _dataManager.channelId = _channelId;
    
    [self loadData];
    
    self.navigationItem.title = @"萝卜商详";
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    RadishProductDetailView *detailView = [[RadishProductDetailView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    detailView.delegate = self;
    [self.view addSubview:detailView];
    self.detailView = detailView;
    
    [self buildRightBarButtons];
}

- (void)loadData {
    NSDictionary *param = @{@"pId":_productId,
                            @"chId":_channelId};
    [TCProgressHUD showSVP];
    [Request startWithName:@"GET_RADISH_PRODUCT_DETAIL_V2" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        RadishProductDetailData *data = [RadishProductDetailModel modelWithDictionary:dic].data;
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

- (void)loadDataSuccess:(RadishProductDetailData *)data{
    _data = data;
    self.detailView.data = data;
    self.navigationItem.title = data.simpleName;
    [self loadRecommend];
    [self loadConsult];
}

- (void)loadDataFailure:(NSError *)error {
    [[iToast makeText:@"商品信息查询失败"] show];
    [self back];
}

#pragma mark - loadRecommend

- (void)loadRecommend {
    [_dataManager loadRecommendSuccessBlock:^(NSArray<RecommendProduct *> *recommends) {
        _data.recommends = recommends;
        self.detailView.data = _data;
    } failureBlock:nil];
}

#pragma mark - loadConsult

- (void)loadConsult {
    NSString *relationNo = self.data.advisoryNo;
    if (![relationNo isNotNull]) return;
    NSUInteger type = self.data.advisoryType;
    
    NSDictionary *param = @{@"relationNo":relationNo,
                            @"advisoryType":@(type),
                            @"pageIndex":@(1),
                            @"pageSize":@(30)};
    [Request startWithName:@"GET_ADVISORY_ADN_REPLIES" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        NSArray<ProductDetailConsultItem *> *items = [ProductDetailConsultModel modelWithDictionary:dic].items;
        if (items.count>0) {
            _data.consults = items;
            self.detailView.data = _data;
        }
    } failure:nil];
}

#pragma mark - RadishProductDetailViewDelegate

- (void)radishProductDetailView:(RadishProductDetailView *)view actionType:(RadishProductDetailViewActionType)type value:(id)value {
    switch (type) {
        case RadishProductDetailViewActionTypeSegue:
        {
            [self segue:value];
        }
            break;
        case RadishProductDetailViewActionTypeShowDate://显示日期
        {
            [self showDate:value];
        }
            break;
        case RadishProductDetailViewActionTypeShowAddress://显示位置
        {
            [self showAddress:value];
        }
            break;
        case RadishProductDetailViewActionTypeOpenWebView://展开web
        {
            
        }
            break;
        case RadishProductDetailViewActionTypeWebLoadFinish://WebView完成加载
        {
            
        }
            break;
        case RadishProductDetailViewActionTypeAddNewConsult://新增咨询
        {
            [self addNewConsult:value];
        }
            break;
        case RadishProductDetailViewActionTypeMoreConsult://查看更多咨询
        {
            [self moreConsult:value];
        }
            break;
        case RadishProductDetailViewActionTypeStandard://套餐信息
        {
            [self standard:value];
        }
            break;
        case RadishProductDetailViewActionTypeBuyStandard://购买套餐
        {
            [self buyStandard:value];
        }
            break;
        case RadishProductDetailViewActionTypeConsult://在线咨询
        {
            [self consult:value];
        }
            break;
        case RadishProductDetailViewActionTypeContact://联系商家
        {
            [self contact:value];
        }
            break;
        case RadishProductDetailViewActionTypeComment://查看评论
        {
            [self comment:value];
        }
            break;
        case RadishProductDetailViewActionTypeMoreComment://查看全部评论
        {
            [self moreComment:value];
        }
            break;
        case RadishProductDetailViewActionTypeToolBarCountDonwFinished://倒计时结束
        {
            [self loadData];
        }
            break;
        case RadishProductDetailViewActionTypeToolBarConsult://在线咨询
        {
            [self consult:value];
        }
            break;
        case RadishProductDetailViewActionTypeToolBarAttention://(添加/取消)关注
        {
            [self attentionType:KTCFavouriteTypeRadish value:value];
        }
            break;
        case RadishProductDetailViewActionTypeToolBarBuyNow://立即购买
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
    PlaceType placeType = _data.placeType;
    NSArray<ProductDetailAddressSelStoreModel *> *places = [ProductDetailAddressSelStoreModel modelsWithRadishProductDetailPlaceType:placeType stores:_data.store places:_data.place];
    if (places.count<1) {
        return;
    }
    ProductDetailAddressViewController *controller = [[ProductDetailAddressViewController alloc] init];
    controller.placeType = placeType;
    controller.places = places;
    controller.showAll = [value boolValue];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - addNewConsult

- (void)addNewConsult:(id)value {
    ProductDetailAddNewConsultViewController *controller = [[ProductDetailAddNewConsultViewController alloc] initWithNibName:@"ProductDetailAddNewConsultViewController" bundle:nil];
    controller.type = (ProductDetailType)self.data.advisoryType;
    controller.productId = self.data.advisoryNo;
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
    controller.type = (ProductDetailType)self.data.advisoryType;
    controller.productId = self.data.advisoryNo;
    controller.consultStr = self.consultStr;
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark - Standard

- (void)standard:(id)value {
    RadishProductDetailStandard *standard = value;
    ProductDetailViewController *controller = [[ProductDetailViewController alloc] initWithServiceId:standard.productId channelId:standard.channelId];
    controller.type = standard.productRedirect;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - buyStandard

- (void)buyStandard:(id)value {
    
    RadishProductDetailStandard *standard = value;
    
    NSString *productid = standard.productId;
    if (![productid isNotNull]) {
        [[iToast makeText:@"服务编号为空！"] show];
        return;
    }
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [param setObject:productid forKey:@"pId"];
    
    NSString *chid = [standard.channelId isNotNull]?standard.channelId:@"0";
    [param setObject:chid forKey:@"chId"];
    
    NSInteger buynum = standard.buyMinNum>0?standard.buyMinNum:1;
    [param setObject:@(buynum) forKey:@"buyNum"];
    
    NSString *storeno = standard.storeNo;
    if ([storeno isNotNull]) {
        [param setObject:storeno forKey:@"storeNo"];
    }
    if (_data.placeType == PlaceTypePlace) {
        if (_data.place.count>0) {
            RadishProductDetailPlace *place = _data.place.firstObject;
            NSString *placeNo = place.sysNo;
            if ([place.sysNo isNotNull]) {
                [param setObject:placeNo forKey:@"place"];
            }
        }
    }
    
    [TCProgressHUD showSVP];
    [Request startWithName:@"ADD_RADISH_SHOPPING_CART" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        [self goSettlement];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [[iToast makeText:@"加入购物车失败，请稍后再试！"] show];
    }];
}


#pragma mark - consult

- (void)consult:(id)value {
    NSString *str = [OnlineCustomerService onlineCustomerServiceLinkUrlString];
    if (str.length>0) {
        WebViewController *controller = [[WebViewController alloc]init];
        controller.urlString = str;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark - Contact

- (void)contact:(id)value {
    [self contactByStore:value];
}

- (void)contactByStore:(id)value {
    NSArray<RadishProductDetailStore *> *store = _data.store;
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"请选择门店" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [store enumerateObjectsUsingBlock:^(RadishProductDetailStore *obj, NSUInteger idx, BOOL *stop) {
        if (obj.phones.count>0) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:obj.storeName style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self makePhoneCallWithNumbers:obj.phones];
            }];
            [controller addAction:action];
        }
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

#pragma mark - Comment

- (void)comment:(id)value {
    NSUInteger index = [value integerValue];
    if (index<_data.commentItemsArray.count) {
        CommentListItemModel *model = _data.commentItemsArray[index];
        model.relationIdentifier = self.data.commentNo;
        CommentRelationType type = (CommentRelationType)self.data.commentRelationType;
        CommentDetailViewController *controller =
        [[CommentDetailViewController alloc] initWithSource:CommentDetailViewSourceServiceOrStore
                                               relationType:type
                                                headerModel:model];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark - MoreComment

- (void)moreComment:(id)value {
    NSString *identifier = self.data.commentNo;
    RadishProductDetailComment *comment = _data.comment;
    CommentRelationType type = (CommentRelationType)self.data.commentRelationType;
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
}

#pragma mark - attention

- (void)attentionType:(KTCFavouriteType)type value:(id)value {
    if (_data.isFavor) {
        [[KTCFavouriteManager sharedManager] deleteFavouriteWithIdentifier:_data.serverId type:type succeed:nil failure:nil];
    } else {
        [[KTCFavouriteManager sharedManager] addFavouriteWithIdentifier:_data.serverId type:type succeed:nil failure:nil];
    }
}


#pragma mark - buyNow

- (void)buyNow:(id)value {
    
    NSString *productid = _data.serverId;
    if (![productid isNotNull]) {
        [[iToast makeText:@"服务编号为空！"] show];
        return;
    }
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [param setObject:productid forKey:@"pId"];
    
    NSString *chid = [_data.chId isNotNull]?_data.chId:@"0";
    [param setObject:chid forKey:@"chId"];
    
    NSInteger buynum = _data.buyMinNum>0?_data.buyMinNum:1;
    [param setObject:@(buynum) forKey:@"buyNum"];
    
    if (self.data.store.count>0) {
        NSString *storeno = _data.store.firstObject.storeId;
        if ([storeno isNotNull]) {
            [param setObject:storeno forKey:@"storeNo"];
        }
    }
    
    if (_data.placeType == PlaceTypePlace) {
        if (_data.place.count>0) {
            RadishProductDetailPlace *place = _data.place.firstObject;
            NSString *placeNo = place.sysNo;
            if ([placeNo isNotNull]) {
                [param setObject:placeNo forKey:@"place"];
            }
        }
    }
    
    [TCProgressHUD showSVP];
    [Request startWithName:@"ADD_RADISH_SHOPPING_CART" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        [self goSettlement];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [[iToast makeText:@"加入购物车失败，请稍后再试！"] show];
    }];
}

- (void)goSettlement {
    RadishSettlementViewController *controller = [[RadishSettlementViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
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
    historyButton.imageEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2);
    [historyButton setImage:[UIImage imageNamed:@"ProductDetail_navi_clock"] forState:UIControlStateNormal];
    [historyButton addTarget:self action:@selector(showHistoryView) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:historyButton];
    
    xPosition += buttonWidth + buttonGap;
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setFrame:CGRectMake(xPosition, 0, buttonWidth, buttonHeight)];
    [shareButton setBackgroundColor:[UIColor clearColor]];
    [shareButton setImageEdgeInsets:UIEdgeInsetsMake(2, 0, 2, 0)];
    shareButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [shareButton setImage:[UIImage imageNamed:@"ProductDetail_navi_more"] forState:UIControlStateNormal];
    [shareButton addTarget:self action:@selector(showActionView) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:shareButton];
    
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
    CGFloat barBtnY = 48;
    
    ZPPopoverItem *popoverItem1 = [ZPPopoverItem makeZpMenuItemWithImageName:@"productDetail_popover_home"  title:@"首页"];
    ZPPopoverItem *popoverItem2 = [ZPPopoverItem makeZpMenuItemWithImageName:@"productDetail_popover_search" title:@"搜索"];
    ZPPopoverItem *popoverItem3 = [ZPPopoverItem makeZpMenuItemWithImageName:@"productDetail_popover_share" title:@"分享"];
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
        NavigationController *navi = [[NavigationController alloc] initWithRootViewController:controller];
        [self presentViewController:navi animated:NO completion:nil];
    }else if (index == 2){
        [self share];
    }
}

- (void)share {
    CommonShareViewController *controller = [CommonShareViewController instanceWithShareObject:self.data.shareObject sourceType:KTCShareServiceTypeRadish];
    [self presentViewController:controller animated:YES completion:nil];
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
            /*
             ProductDetailViewController *controller = [[ProductDetailViewController alloc] initWithServiceId:model.identifier channelId:model.channelId];
             controller.type = model.productRedirect;
             [self.navigationController pushViewController:controller animated:YES];
             */
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
