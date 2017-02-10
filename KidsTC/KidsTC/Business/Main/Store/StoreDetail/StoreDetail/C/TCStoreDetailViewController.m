//
//  TCStoreDetailViewController.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "TCStoreDetailViewController.h"
#import "GHeader.h"
#import "NSString+Category.h"
#import "ZPPopover.h"
#import "KTCBrowseHistoryView.h"
#import "BuryPointManager.h"
#import "SegueMaster.h"
#import "KTCFavouriteManager.h"

#import "TCStoreDetailModel.h"
#import "TCStoreDetailNearbyModel.h"

#import "TCStoreDetailView.h"
#import "TCStoreDetailNaviRightView.h"

#import "TabBarController.h"
#import "NavigationController.h"
#import "SearchViewController.h"
#import "CommonShareViewController.h"
#import "CommentListViewController.h"
#import "CommentDetailViewController.h"
#import "CommentFoundingViewController.h"
#import "StoreDetailAppointmentViewController.h"
#import "StoreDetailPackageMoreViewController.h"
#import "StoreDetialMapPoiViewController.h"
#import "ProductDetailGetCouponListViewController.h"
#import "StoreDetailCouponMoreViewController.h"

@interface TCStoreDetailViewController ()
<
TCStoreDetailNaviRightViewDelegate,
TCStoreDetailViewDelegate,
ZPPopoverDelegate,
KTCBrowseHistoryViewDelegate,
KTCBrowseHistoryViewDataSource,
CommentFoundingViewControllerDelegate,
StoreDetailCouponMoreViewControllerDelegate
>
@property (nonatomic, strong) TCStoreDetailView *detailView;
@property (nonatomic, strong) TCStoreDetailData *data;
@end

@implementation TCStoreDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![self.storeId isNotNull]) {
        [[iToast makeText:@"门店编号为空！"] show];
        [self back];
        return;
    }
    
    [self loadData];
    
    [self setupNavi];
    
    [self setupView];
    
}

#pragma mark - setupNavi

- (void)setupNavi {
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    TCStoreDetailNaviRightView *naviRightView = [[NSBundle mainBundle] loadNibNamed:@"TCStoreDetailNaviRightView" owner:self options:nil].firstObject;
    naviRightView.delegate = self;
    naviRightView.bounds = CGRectMake(0, 0, 64, 26);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:naviRightView];
}

#pragma mark TCStoreDetailNaviRightViewDelegate

- (void)tcStoreDetailNaviRightView:(TCStoreDetailNaviRightView *)view actionType:(TCStoreDetailNaviRightViewActionType)type value:(id)value {
    switch (type) {
        case TCStoreDetailNaviRightViewActionTypeHistory:
        {
            [self showHistoryView];
        }
            break;
        case TCStoreDetailNaviRightViewActionTypeMore:
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
    TCStoreDetailView *detailView = [[TCStoreDetailView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    detailView.delegate = self;
    [self.view addSubview:detailView];
    self.detailView = detailView;
}

#pragma mark TCStoreDetailViewDelegate

- (void)tcStoreDetailView:(TCStoreDetailView *)view actionType:(TCStoreDetailViewActionType)type value:(id)value{

    switch (type) {
        case TCStoreDetailViewActionTypeCollect:
        {
            [self collect];
        }
            break;
        case TCStoreDetailViewActionTypePhone:
        {
            [self phone];
        }
            break;
        case TCStoreDetailViewActionTypeCoupon:
        {
            [self coupon:value];
        }
            break;
        case TCStoreDetailViewActionTypeCouponMore:
        {
            [self couponMore];
        }
            break;
        case TCStoreDetailViewActionTypeSegue:
        {
            [self segue:value];
        }
            break;
        case TCStoreDetailViewActionTypePackageMore:
        {
            [self packageMore];
        }
            break;
        case TCStoreDetailViewActionTypeCommentWrite:
        {
            [self commentWrite];
        }
            break;
        case TCStoreDetailViewActionTypeComment:
        {
            [self comment:value];
        }
            break;
        case TCStoreDetailViewActionTypeCommentMore:
        {
            [self commentMore];
        }
            break;
        case TCStoreDetailViewActionTypeLike:
        {
            [self collect];
        }
            break;
        case TCStoreDetailViewActionTypeWrite:
        {
            [self commentWrite];
        }
            break;
        case TCStoreDetailViewActionTypeAppoiment:
        {
            [self appoiment];
        }
            break;
        case TCStoreDetailViewActionTypeFacility:
        {
            [self facility:value];
        }
            break;
        default:
            break;
    }
}

- (void)collect{
    
    if (self.data.isFavor) {
        [[KTCFavouriteManager sharedManager] deleteFavouriteWithIdentifier:self.storeId type:KTCFavouriteTypeStore succeed:nil failure:nil];
    } else {
        [[KTCFavouriteManager sharedManager] addFavouriteWithIdentifier:self.storeId type:KTCFavouriteTypeStore succeed:nil failure:nil];
    }
}

- (void)phone {
    NSArray *numbers = self.data.storeBase.phones;
    if (numbers.count == 1) {
        NSString *telString = [NSString stringWithFormat:@"telprompt://%@",numbers.firstObject];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telString]];
    } else {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"请选择需要拨打的号码" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        for (NSString *phoneNumber in numbers) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:phoneNumber style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSString *telString = [NSString stringWithFormat:@"telprompt://%@", phoneNumber];
                NSLog(@"%@", [NSURL URLWithString:telString]);
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telString]];
            }];
            [controller addAction:action];
        }
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [controller addAction:action];
        [self presentViewController:controller animated:YES completion:nil];
    }
}

- (void)coupon:(id)value {
    if (![value respondsToSelector:@selector(integerValue)]) {
        return;
    }
    NSInteger index = [value integerValue];
    if (index>=self.data.coupons.count) {
        return;
    }
    TCStoreDetailCoupon *coupon = self.data.coupons[index];
    if (coupon.isProvider) {
        [[iToast makeText:@"不可重复领取哦~"] show];
        return;
    }
    NSString *batchNo = coupon.batchNo;
    if (![batchNo isNotNull]) {
        [[iToast makeText:@"该优惠券暂不支持领取"] show];
        return;
    }
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        NSDictionary *param = @{@"batchid":batchNo};
        [TCProgressHUD showSVP];
        [Request startWithName:@"COUPON_FETCH" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
            [TCProgressHUD dismissSVP];
            NSString *errMsg = @"恭喜您，优惠券领取成功！";
            [[iToast makeText:errMsg] show];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [TCProgressHUD dismissSVP];
            NSString *errMsg = @"领取优惠券失败，请稍后再试~";
            NSString *text = [NSString stringWithFormat:@"%@",error.userInfo[@"data"]];
            if ([text isNotNull]) errMsg = text;
            [[iToast makeText:errMsg] show];
        }];
    }];
}

- (void)couponMore {
    StoreDetailCouponMoreViewController *controller = [[StoreDetailCouponMoreViewController alloc] initWithNibName:@"StoreDetailCouponMoreViewController" bundle:nil];
    controller.coupons = self.data.coupons;
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    controller.modalPresentationStyle = UIModalPresentationCustom;
    [self presentViewController:controller animated:NO completion:nil];
}

- (void)couponStatusHasChangeStoreDetailCouponMoreViewController:(StoreDetailCouponMoreViewController *)controller {
    [self.detailView relodData];
}

- (void)segue:(id)value {
    [SegueMaster makeSegueWithModel:value fromController:self];
}

- (void)packageMore {
    StoreDetailPackageMoreViewController *controller = [[StoreDetailPackageMoreViewController alloc] initWithNibName:@"StoreDetailPackageMoreViewController" bundle:nil];
    controller.products = self.data.moreProductPackage.products;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)commentWrite {
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        CommentFoundingViewController *controller = [[CommentFoundingViewController alloc] initWithCommentFoundingModel:[CommentFoundingModel modelFromTCStore:self.data]];
        controller.delegate = self;
        [controller setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:controller animated:YES];
    }];
}

- (void)commentFoundingViewControllerDidFinishSubmitComment:(CommentFoundingViewController *)vc {
    [self loadData];
}

- (void)comment:(id)value {
    if (![value respondsToSelector:@selector(integerValue)]) {
        return;
    }
    NSInteger index = [value integerValue];
    if (index>=self.data.commentItemsArray.count) {
        return;
    }
    CommentListItemModel *model = [self.data.commentItemsArray objectAtIndex:index];
    model.relationIdentifier = self.storeId;
    CommentDetailViewController *controller = [[CommentDetailViewController alloc] initWithSource:CommentDetailViewSourceServiceOrStore relationType:CommentRelationTypeStore headerModel:model];
    [self.navigationController pushViewController:controller animated:YES];
}



- (void)commentMore {
    NSDictionary *commentNumberDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                      [NSNumber numberWithInteger:self.data.comment.all], CommentListTabNumberKeyAll,
                                      [NSNumber numberWithInteger:self.data.comment.good], CommentListTabNumberKeyGood,
                                      [NSNumber numberWithInteger:self.data.comment.normal], CommentListTabNumberKeyNormal,
                                      [NSNumber numberWithInteger:self.data.comment.bad], CommentListTabNumberKeyBad,
                                      [NSNumber numberWithInteger:self.data.comment.pic], CommentListTabNumberKeyPicture, nil];
    
    CommentListViewController *controller = [[CommentListViewController alloc] initWithIdentifier:self.storeId relationType:CommentRelationTypeStore commentNumberDic:commentNumberDic];
    [self.navigationController pushViewController:controller animated:YES];
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    if ([_storeId isNotNull]) {
        [params setValue:_storeId forKey:@"sid"];
    }
    [BuryPointManager trackEvent:@"event_result_store_evaluations" actionId:20507 params:params];
}

- (void)appoiment {
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        StoreDetailAppointmentViewController *controller = [[StoreDetailAppointmentViewController alloc] initWithNibName:@"StoreDetailAppointmentViewController" bundle:nil];
        controller.storeId = self.storeId;
        controller.activeModelsArray = self.data.activeModelsArray;
        controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        controller.modalPresentationStyle = UIModalPresentationCustom;
        [self presentViewController:controller animated:NO completion:nil];
    }];
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    if ([_storeId isNotNull]) {
        [params setValue:_storeId forKey:@"sid"];
    }
    [BuryPointManager trackEvent:@"event_result_store_appoint" actionId:20503 params:params];
}

- (void)facility:(id)value {
    if (![value respondsToSelector:@selector(integerValue)]) {
        return;
    }
    NSInteger index = [value integerValue];
    if (index>=self.data.commentItemsArray.count) {
        return;
    }
    StoreDetailNearbyModel *model = [self.data.nearbyFacilities objectAtIndex:index];
    if (model.locations) {
        StoreDetialMapPoiViewController *controller = [[StoreDetialMapPoiViewController alloc]init];
        controller.locations = model.locations;
        [self.navigationController pushViewController:controller animated:YES];
    } else if (model.itemDescriptions) {
        NSMutableString *showingString = [[NSMutableString alloc] init];
        for (NSString *string in model.itemDescriptions) {
            [showingString appendFormat:@"%@\n", string];
        }
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:model.name message:showingString preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
        [controller addAction:action];
        [self presentViewController:controller animated:YES completion:nil];
    }
}

#pragma mark loadData

- (void)loadData {
    NSDictionary *param = @{@"storeId":_storeId};
    [TCProgressHUD showSVP];
    [Request startWithName:@"GET_STORE_DETAIL_V2" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        TCStoreDetailData *data = [TCStoreDetailModel modelWithDictionary:dic].data;
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

- (void)loadDataSuccessWithData:(TCStoreDetailData *)data {
    self.data = data;
    self.detailView.data = data;
    self.navigationItem.title = data.storeBase.storeSimpleName;
    [self loadStoreNearby];
}

- (void)loadDataFailure:(NSError *)error {
    NSString *errMsg = @"门店信息获取失败！";
    NSString *text = [NSString stringWithFormat:@"%@",error.userInfo[@"data"]];
    if ([text isNotNull]) errMsg = text;
    [[iToast makeText:errMsg] show];
    [self back];
}

- (void)loadStoreNearby {
    NSDictionary *param = @{@"storeId":_storeId};
    [TCProgressHUD showSVP];
    [Request startWithName:@"GET_STORE_NEAR_BY" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        TCStoreDetailNearbyData *data = [TCStoreDetailNearbyModel modelWithDictionary:dic].data;
        if (data) [self loadStoreNearbyDataSuccess:data];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
    }];
}

- (void)loadStoreNearbyDataSuccess:(TCStoreDetailNearbyData *)data {
    self.data.nearbyData = data;
    self.detailView.data = self.data;
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
            if (index>=array.count) {return;}
            BrowseHistoryServiceListItemModel *model = array[index];
            [SegueMaster makeSegueWithModel:model.segueModel fromController:self];
        }
            break;
        case KTCBrowseHistoryTypeStore:
        {
            if (index>=array.count) {return;}
            BrowseHistoryStoreListItemModel *model = [array objectAtIndex:index];
            TCStoreDetailViewController *controller = [[TCStoreDetailViewController alloc] init];
            controller.storeId = model.identifier;
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
