//
//  StoreDetailViewController.m
//  KidsTC
//
//  Created by 钱烨 on 7/18/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//

#import "StoreDetailViewController.h"
#import "StoreDetailViewModel.h"
#import "StoreDetailBottomView.h"
#import "Insurance.h"
#import "ActivityLogoItem.h"
#import "ServiceListItemModel.h"
#import "StoreListItemModel.h"
#import "StoreAppointmentViewController.h"
#import "ProductDetailViewController.h"
#import "SearchViewController.h"
#import "CommentListViewController.h"
#import "CommentFoundingViewController.h"
#import "KTCActionView.h"
#import "CommonShareViewController.h"
#import "WebViewController.h"
#import "KTCBrowseHistoryView.h"
#import "KTCBrowseHistoryManager.h"
#import "StoreDetialMapViewController.h"
#import "SegueMaster.h"
#import "BuryPointManager.h"
#import "CommentDetailViewController.h"
#import "StoreDetialMapPoiViewController.h"
#import "StoreDetailServiceListViewController.h"
#import "StoreDetailHotRecommendListViewController.h"
#import "StoreDetailRelatedStrategyListViewController.h"
#import "ParentingStrategyDetailViewController.h"
#import "SVProgressHUD.h"
#import "User.h"
#import "iToast.h"
#import "TabBarController.h"
#import "UIBarButtonItem+Category.h"
#import "StoreDetailAppointmentViewController.h"
#import "NSString+Category.h"


@interface StoreDetailViewController () <StoreDetailViewDelegate, StoreDetailBottomViewDelegate, KTCBrowseHistoryViewDataSource, KTCBrowseHistoryViewDelegate, CommentFoundingViewControllerDelegate,KTCActionViewDelegate>

@property (weak, nonatomic) IBOutlet StoreDetailView *detailView;
@property (weak, nonatomic) IBOutlet StoreDetailBottomView *bottomView;

@property (nonatomic, copy) NSString *storeId;
@property (nonatomic, strong) StoreDetailViewModel *viewModel;

@end

@implementation StoreDetailViewController

- (instancetype)initWithStoreId:(NSString *)storeId {
    self = [super initWithNibName:@"StoreDetailViewController" bundle:nil];
    if (self) {
        self.storeId = storeId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![self.storeId isNotNull]) {
        [[iToast makeText:@"门店编号为空"] show];
        [self back];
        return;
    }
    self.pageId = 10402;
    self.trackParams = @{@"sid":_storeId};
    
    self.navigationItem.title = @"门店详情";
    
    self.hidesBottomBarWhenPushed = YES;
    
    self.detailView.delegate = self;
    self.bottomView.delegate = self;
    
    self.viewModel = [[StoreDetailViewModel alloc] initWithView:self.detailView];
    [self buildRightBarButtons];
    
    [self.bottomView setHidden:YES];
    
    [self reloadNetworkData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [TCProgressHUD dismissSVP];
    [[KTCActionView actionView] hide];
    [[KTCBrowseHistoryView historyView] hide];
}

#pragma mark StoreDetailViewDelegate

- (void)didClickedCouponButtonOnStoreDetailView:(StoreDetailView *)detailView {
    WebViewController * controller = [[WebViewController alloc] init];
    controller.urlString = self.viewModel.detailModel.couponUrlString;
    [self.navigationController pushViewController:controller animated:YES];
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    if ([_storeId isNotNull]) {
        [params setValue:_storeId forKey:@"sid"];
    }
    [BuryPointManager trackEvent:@"event_skip_store_coupon" actionId:20504 params:params];
}

- (void)didClickedTelephoneOnStoreDetailView:(StoreDetailView *)detailView {
    NSArray *numbers = [self.viewModel.detailModel phoneNumbersArray];
    if ([numbers count] <= 1) {
        NSString *telString = [NSString stringWithFormat:@"telprompt://%@",[self.viewModel.detailModel phoneNumber]];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telString]];
    } else {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"请选择需要拨打的号码" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
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

- (void)didClickedAddressOnStoreDetailView:(StoreDetailView *)detailView {
    
    StoreDetailModel *detailModel = self.viewModel.detailModel;
    StoreDetialMapViewController *controller = [[StoreDetialMapViewController alloc] init];
    controller.models = detailModel.brotherStores;
    [detailModel.brotherStores enumerateObjectsUsingBlock:^(StoreListItemModel *model, NSUInteger idx, BOOL *stop) {
        if ([model.identifier isEqualToString:self.viewModel.detailModel.storeId]) {
            controller.selectedModel = model;
            *stop = YES;
        }
    }];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didClickedActiveOnStoreDetailView:(StoreDetailView *)detailView atIndex:(NSUInteger)index {
//    ActivityLogoItem *item = [self.viewModel.detailModel.activeModelsArray objectAtIndex:index];
//    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"" message:item.itemDescription preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
//    [controller addAction:action];
//    [self presentViewController:controller animated:YES completion:nil];
}

- (void)didClickedAllServiceOnStoreDetailView:(StoreDetailView *)detailView {
    StoreDetailServiceListViewController *controller = [[StoreDetailServiceListViewController alloc] initWithListItemModels:self.viewModel.detailModel.serviceModelsArray];
    [controller setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)storeDetailView:(StoreDetailView *)detailView didClickedServiceAtIndex:(NSUInteger)index {
    StoreOwnedServiceModel *serviceModel = [self.viewModel.detailModel.serviceModelsArray objectAtIndex:index];
    ProductDetailViewController *controller = [[ProductDetailViewController alloc] initWithServiceId:serviceModel.serviceId channelId:serviceModel.channelId];
    [self.navigationController pushViewController:controller animated:YES];
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    if ([_storeId isNotNull]) {
        [params setValue:_storeId forKey:@"sid"];
    }
    if ([serviceModel.serviceId isNotNull]) {
        [params setValue:serviceModel.serviceId forKey:@"pid"];
    }
    if ([serviceModel.channelId isNotNull]) {
        [params setValue:serviceModel.serviceId forKey:@"cid"];
    }
    [BuryPointManager trackEvent:@"event_result_store_hotserver" actionId:20505 params:params];
}

- (void)didClickedAllHotRecommendOnStoreDetailView:(StoreDetailView *)detailView {
    
    StoreDetailHotRecommendModel *service = self.viewModel.detailModel.hotRecommedService;
    StoreDetailHotRecommendListViewController *controller = [[StoreDetailHotRecommendListViewController alloc] initWithHotRecommendModel:service];
    [self.navigationController pushViewController:controller animated:YES];
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    if ([_storeId isNotNull]) {
        [params setValue:_storeId forKey:@"sid"];
    }
    if ([service isKindOfClass:[StoreDetailHotRecommendItem class]]) {
        StoreDetailHotRecommendItem *item = (StoreDetailHotRecommendItem *)service;
        if ([item.serviceId isNotNull]) {
            [params setValue:item.serviceId forKey:@"pid"];
        }
        if ([item.channelId isNotNull]) {
            [params setValue:item.serviceId forKey:@"cid"];
        }
    }
    [BuryPointManager trackEvent:@"event_skip_store_proserver" actionId:20506 params:params];
}

- (void)storeDetailView:(StoreDetailView *)detailView didSelectedHotRecommendAtIndex:(NSUInteger)index {
    StoreDetailHotRecommendItem *item = [[self.viewModel.detailModel.hotRecommedService recommendItems] objectAtIndex:index];
    ProductDetailViewController *controller = [[ProductDetailViewController alloc] initWithServiceId:item.serviceId channelId:item.channelId];
    [controller setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didClickedAllStrategyOnStoreDetailView:(StoreDetailView *)detailView {
    StoreDetailRelatedStrategyListViewController *controller = [[StoreDetailRelatedStrategyListViewController alloc] initWithListItemModels:self.viewModel.detailModel.strategyModelsArray];
    [controller setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)storeDetailView:(StoreDetailView *)detailView didSelectedSteategyAtIndex:(NSUInteger)index {
    StoreRelatedStrategyModel *model = [self.viewModel.detailModel.strategyModelsArray objectAtIndex:index];
    ParentingStrategyDetailViewController *controller = [[ParentingStrategyDetailViewController alloc] initWithStrategyIdentifier:model.strategyId];
    [controller setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didClickedMoreDetailOnStoreDetailView:(StoreDetailView *)detailView {
    
    WebViewController *controller = [[WebViewController alloc] init];
    controller.urlString = self.viewModel.detailModel.detailUrlString;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didClickedMoreReviewOnStoreDetailView:(StoreDetailView *)detailView {
    NSDictionary *commentNumberDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                      [NSNumber numberWithInteger:self.viewModel.detailModel.commentAllNumber], CommentListTabNumberKeyAll,
                                      [NSNumber numberWithInteger:self.viewModel.detailModel.commentGoodNumber], CommentListTabNumberKeyGood,
                                      [NSNumber numberWithInteger:self.viewModel.detailModel.commentNormalNumber], CommentListTabNumberKeyNormal,
                                      [NSNumber numberWithInteger:self.viewModel.detailModel.commentBadNumber], CommentListTabNumberKeyBad,
                                      [NSNumber numberWithInteger:self.viewModel.detailModel.commentPictureNumber], CommentListTabNumberKeyPicture, nil];
    
    CommentListViewController *controller = [[CommentListViewController alloc] initWithIdentifier:self.storeId relationType:CommentRelationTypeStore commentNumberDic:commentNumberDic];
    [self.navigationController pushViewController:controller animated:YES];
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    if ([_storeId isNotNull]) {
        [params setValue:_storeId forKey:@"sid"];
    }
    [BuryPointManager trackEvent:@"event_result_store_evaluations" actionId:20507 params:params];
}

- (void)storeDetailView:(StoreDetailView *)detailView didClickedReviewAtIndex:(NSUInteger)index {
    if ([self.viewModel.detailModel.commentItemsArray count] > 0) {
        CommentListItemModel *model = [self.viewModel.detailModel.commentItemsArray objectAtIndex:index];
        model.relationIdentifier = self.storeId;
        CommentDetailViewController *controller = [[CommentDetailViewController alloc] initWithSource:CommentDetailViewSourceServiceOrStore relationType:CommentRelationTypeStore headerModel:model];
        [controller setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:controller animated:YES];
    } else {
        [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
            CommentFoundingViewController *controller = [[CommentFoundingViewController alloc] initWithCommentFoundingModel:[CommentFoundingModel modelFromStore:self.viewModel.detailModel]];
            controller.delegate = self;
            [controller setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:controller animated:YES];
        }];
    }
    NSMutableDictionary *params = [NSMutableDictionary new];
    if ([_storeId isNotNull]) {
        [params setValue:_storeId forKey:@"sid"];
    }
    [BuryPointManager trackEvent:@"event_skip_store_evaluate" actionId:20502 params:params];
}

- (void)didClickedMoreBrothersStoreOnStoreDetailView:(StoreDetailView *)detailView {
    //跳兄弟门店列表  目前不作处理
//    StoreListViewController *controller = [[StoreListViewController alloc] initWithStoreListItemModels:self.viewModel.detailModel.brotherStores];
//    [controller setHidesBottomBarWhenPushed:YES];
//    [self.navigationController pushViewController:controller animated:YES];
}


- (void)storeDetailView:(StoreDetailView *)detailView didSelectedLinkWithSegueModel:(SegueModel *)model {
    [SegueMaster makeSegueWithModel:model fromController:self];
}

- (void)storeDetailView:(StoreDetailView *)detailView didClickedNearbyAtIndex:(NSUInteger)index {
    StoreDetailNearbyModel *model = [self.viewModel.detailModel.nearbyFacilities objectAtIndex:index];
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


#pragma mark StoreDetailBottomViewDelegate

- (void)storeDetailBottomView:(StoreDetailBottomView *)bottomView didClickedButtonWithTag:(StoreDetailBottomSubviewTag)tag {
    switch (tag) {
        case StoreDetailBottomSubviewTagPhone:
        {
            [self didClickedTelephoneOnStoreDetailView:self.detailView];
        }
            break;
        case StoreDetailBottomSubviewTagComment:
        {
            [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
                CommentFoundingViewController *controller = [[CommentFoundingViewController alloc] initWithCommentFoundingModel:[CommentFoundingModel modelFromStore:self.viewModel.detailModel]];
                controller.delegate = self;
                [controller setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:controller animated:YES];
            }];
            NSMutableDictionary *params = [NSMutableDictionary new];
            if ([_storeId isNotNull]) {
                [params setValue:_storeId forKey:@"sid"];
            }
            [BuryPointManager trackEvent:@"event_skip_store_evaluate" actionId:20502 params:params];
        }
            break;
        case StoreDetailBottomSubviewTagFavourate:
        {
            [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
                __weak StoreDetailViewController *weakSelf = self;
                [weakSelf.viewModel addOrRemoveFavouriteWithSucceed:^(NSDictionary *data) {
                    [bottomView setFavourite:weakSelf.viewModel.detailModel.isFavourate];
                } failure:^(NSError *error) {
                    if ([[error userInfo] count] > 0) {
                        [[iToast makeText:[[error userInfo] objectForKey:@"data"]] show];
                    }
                    if (error.code == -2001) {
                        [bottomView setFavourite:YES];
                    }
                }];
            }];
            NSMutableDictionary *params = [NSMutableDictionary new];
            if ([_storeId isNotNull]) {
                [params setValue:_storeId forKey:@"sid"];
            }
            [BuryPointManager trackEvent:@"event_result_store_favor" actionId:20501 params:params];
        }
            break;
        case StoreDetailBottomSubviewTagAppointment:
        {
            [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
                StoreDetailAppointmentViewController *controller = [[StoreDetailAppointmentViewController alloc] initWithNibName:@"StoreDetailAppointmentViewController" bundle:nil];
                controller.detailModel = self.viewModel.detailModel;
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
            [controller setHidesBottomBarWhenPushed:YES];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case KTCBrowseHistoryTypeStore:
        {
            BrowseHistoryStoreListItemModel *model = [array objectAtIndex:index];
            StoreDetailViewController *controller = [[StoreDetailViewController alloc] initWithStoreId:model.identifier];
            [controller setHidesBottomBarWhenPushed:YES];
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
            SearchViewController *controller = [[SearchViewController alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case KTCActionViewTagShare:
        {
            CommonShareViewController *controller = [CommonShareViewController instanceWithShareObject:self.viewModel.detailModel.shareObject sourceType:KTCShareServiceTypeStore];
            [self presentViewController:controller animated:YES completion:nil] ;
            
            NSMutableDictionary *params = [NSMutableDictionary new];
            if ([_storeId isNotNull]) {
                [params setValue:_storeId forKey:@"sid"];
            }
            [BuryPointManager trackEvent:@"event_result_store_share" actionId:20508 params:params];
        }
            break;
        default:
            break;
    }
}

#pragma mark CommentFoundingViewControllerDelegate

- (void)commentFoundingViewControllerDidFinishSubmitComment:(CommentFoundingViewController *)vc {
    [self reloadNetworkData];
}

#pragma mark Privated methods

- (void)resetTitle {
    self.navigationItem.title = self.viewModel.detailModel.storeShortName;
    self.navigationItem.title = self.navigationItem.title;
}


- (void)setupBottomView {
    if (self.viewModel.detailModel) {
        [self.bottomView setHidden:NO];
    } else {
        [self.bottomView setHidden:YES];
    }
    if ([[User shareUser] hasLogin]) {
        [self.bottomView setFavourite:self.viewModel.detailModel.isFavourate];
    }
    [self.bottomView.appointmentButton setEnabled:self.viewModel.detailModel.canAppoint];
    NSString *title = self.viewModel.detailModel.appointButtonTitle;
    if ([title length] == 0) {
        if (self.viewModel.detailModel.canAppoint) {
            title = @"预约门店";
        } else {
            title = @"暂停预约";
        }
    }
    [self.bottomView.appointmentButton setTitle:title forState:UIControlStateNormal];
    [self.bottomView.appointmentButton setTitle:title forState:UIControlStateSelected];
    [self.bottomView.appointmentButton setTitle:title forState:UIControlStateDisabled];
    
    [self.bottomView hidePhone:!([[self.viewModel.detailModel phoneNumbersArray] count] > 0)];
}

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


#pragma mark Super methods

- (void)reloadNetworkData {
    [TCProgressHUD showSVP];
    __weak StoreDetailViewController *weakSelf = self;
    [weakSelf.viewModel startUpdateDataWithStoreId:weakSelf.storeId succeed:^(NSDictionary *data) {
        [weakSelf.detailView reloadData];
        [TCProgressHUD dismissSVP];
        [weakSelf setupBottomView];
        [weakSelf resetTitle];
    } failure:^(NSError *error) {
        [[iToast makeText:@"门店信息查询失败"] show];
        [self.navigationController popViewControllerAnimated:YES];
        [weakSelf.detailView reloadData];
        [TCProgressHUD dismissSVP];
    }];
}



@end
