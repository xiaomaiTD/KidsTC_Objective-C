//
//  ServiceDetailViewController.m
//  KidsTC
//
//  Created by 钱烨 on 7/15/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//

#import "ServiceDetailViewController.h"
#import "ServiceDetailViewModel.h"
#import "ServiceDetailBottomView.h"
#import "AppDelegate.h"
#import "Insurance.h"
#import "AUIPickerView.h"
#import "CommentListViewController.h"
#import "CommentDetailViewController.h"
#import "WebViewController.h"
#import "KTCActionView.h"
#import "CommonShareViewController.h"
#import "StoreDetailViewController.h"
#import "KTCBrowseHistoryView.h"
#import "KTCBrowseHistoryManager.h"
#import "SegueMaster.h"
#import "ATCountDown.h"
#import "StoreDetialMapViewController.h"
#import "ServiceDetailRelatedServiceListViewController.h"
#import "ServiceDetailConfigView.h"
#import "ServiceDetailConfigModel.h"
#import "SearchTableViewController.h"
#import "SVProgressHUD.h"
#import "GHeader.h"
#import "InterfaceManager.h"
#import "TabBarController.h"
#import "ToolBox.h"
#import "OnlineCustomerService.h"
#import "ServiceSettlementViewController.h"

@interface ServiceDetailViewController () <ServiceDetailViewDelegate, ServiceDetailBottomViewDelegate, KTCActionViewDelegate, KTCBrowseHistoryViewDataSource, KTCBrowseHistoryViewDelegate,ServiceDetailConfigViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *detailBGView;
@property (weak, nonatomic) IBOutlet ServiceDetailView *detailView;
@property (weak, nonatomic) IBOutlet ServiceDetailBottomView *bottomView;
@property (nonatomic, strong) AUIPickerView *pickerView;
@property (nonatomic, strong) ServiceDetailConfigView *configView;

@property (nonatomic, copy) NSString *serviceId;
@property (nonatomic, copy) NSString *channelId;
@property (nonatomic, assign) BOOL isNeedToBuy;
@property (nonatomic, assign) NSUInteger buyNum;
@property (nonatomic, strong) NSString *storeId;

@property (nonatomic, strong) ServiceDetailViewModel *viewModel;

@property (nonatomic, strong) ATCountDown *countdownTimer;

@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;
@property (weak, nonatomic) IBOutlet UIView *countdownBGView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *countdownBGHeight;
@property (weak, nonatomic) IBOutlet UIView *gapView;

@end

@implementation ServiceDetailViewController

- (instancetype)initWithServiceId:(NSString *)serviceId channelId:(NSString *)channelId {
    self = [super initWithNibName:@"ServiceDetailViewController" bundle:nil];
    if (self) {
        self.serviceId = serviceId;
        self.channelId = channelId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"服务详情";
    self.pageId = @"pv_server_dtl";
    
    self.detailView.delegate = self;
    
    self.bottomView.delegate = self;
    
    self.configView = [[[NSBundle mainBundle] loadNibNamed:@"ServiceDetailConfigView" owner:self options:nil] lastObject];
    self.configView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.configView.delegate = self;
    
    self.viewModel = [[ServiceDetailViewModel alloc] initWithView:self.detailView];
    
    [self buildRightBarButtons];
    [self buildCountDownView];
    
    [self.bottomView setHidden:YES];
    
    [self reloadNetworkData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [TCProgressHUD dismissSVP];
    [[KTCActionView actionView] hide];
    [[KTCBrowseHistoryView historyView] hide];
}

- (void)dealloc {
    [self stopCountDown];
    self.configView = nil;
}


#pragma mark <ServiceDetailConfigViewDelegate>

- (void)serviceDetailConfigView:(ServiceDetailConfigView *)serviceDetailConfigView didClickBtnWithPid:(long)pid{
    [self productStandardWithPid:pid];
}


- (void)serviceDetailConfigView:(ServiceDetailConfigView *)serviceDetailConfigView closeWithServiceId:(NSString *)serviceId channelId:(NSString *)channelId isNeedToBuy:(BOOL)isNeedToBuy submitWithBuyNum:(NSUInteger)buyNum storeId:(NSString *)storeId{
    
    self.channelId = channelId;
    self.isNeedToBuy = isNeedToBuy;
    self.buyNum = buyNum;
    self.storeId = storeId;
    
    if (![self.serviceId isEqualToString:serviceId]) {
        self.serviceId = serviceId;
        [self reloadNetworkData];
    }else if(self.isNeedToBuy){
        [self submitWithBuyNum:self.buyNum storeId:self.storeId];
    }
}

#pragma mark <ServiceDetailConfigViewDelegate> - add

- (void)productStandardWithPid:(long)pid{
    NSDictionary *parameter = @{@"pid":@(pid)};
    [TCProgressHUD showSVP];
    [Request startWithName:@"GET_PRODUCT_STANDARD" param:parameter progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        ServiceDetailConfigModel *model = [ServiceDetailConfigModel modelWithDictionary:dic];
        self.configView.data = model.data;
        [TCProgressHUD dismissSVP];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
    }];

}

#pragma mark ServiceDetailViewDelegate

- (void)didClickedCouponOnServiceDetailView:(ServiceDetailView *)detailView {
    WebViewController * controller = [[WebViewController alloc] init];
    controller.urlString = self.viewModel.detailModel.couponUrlString;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)serviceDetailView:(ServiceDetailView *)detailView didChangedMoreInfoViewTag:(ServiceDetailMoreInfoViewTag)viewTag {
    [self.viewModel resetMoreInfoViewWithViewTag:viewTag];
}

- (void)serviceDetailView:(ServiceDetailView *)detailView didClickedStoreCellAtIndex:(NSUInteger)index {
    StoreListItemModel *model = [self.viewModel.detailModel.storeItemsArray objectAtIndex:index];
    StoreDetailViewController *controller = [[StoreDetailViewController alloc] initWithStoreId:model.identifier];
    [controller setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)serviceDetailView:(ServiceDetailView *)detailView didClickedCommentCellAtIndex:(NSUInteger)index {
    CommentListItemModel *model = [self.viewModel.detailModel.commentItemsArray objectAtIndex:index];
    model.relationIdentifier = self.serviceId;
    CommentDetailViewController *controller = [[CommentDetailViewController alloc] initWithSource:CommentDetailViewSourceServiceOrStore relationType:self.viewModel.detailModel.relationType headerModel:model];
    [controller setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
}


- (void)didClickedMoreCommentOnServiceDetailView:(ServiceDetailView *)detailView {
    NSDictionary *commentNumberDic = [NSDictionary dictionaryWithObjectsAndKeys:
                                      [NSNumber numberWithInteger:self.viewModel.detailModel.commentAllNumber], CommentListTabNumberKeyAll,
                                      [NSNumber numberWithInteger:self.viewModel.detailModel.commentGoodNumber], CommentListTabNumberKeyGood,
                                      [NSNumber numberWithInteger:self.viewModel.detailModel.commentNormalNumber], CommentListTabNumberKeyNormal,
                                      [NSNumber numberWithInteger:self.viewModel.detailModel.commentBadNumber], CommentListTabNumberKeyBad,
                                      [NSNumber numberWithInteger:self.viewModel.detailModel.commentPictureNumber], CommentListTabNumberKeyPicture, nil];
    
    CommentListViewController *controller = [[CommentListViewController alloc] initWithIdentifier:self.serviceId relationType:self.viewModel.detailModel.relationType commentNumberDic:commentNumberDic];
    [controller setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
}


- (void)serviceDetailView:(ServiceDetailView *)detailView didScrolledAtOffset:(CGPoint)offset {
}


- (void)serviceDetailView:(ServiceDetailView *)detailView didSelectedLinkWithSegueModel:(SegueModel *)model {
    [SegueMaster makeSegueWithModel:model fromController:self];
}

- (void)didClickedStoreBriefOnServiceDetailView:(ServiceDetailView *)detailView {

    StoreDetialMapViewController *controller = [[StoreDetialMapViewController alloc] init];
    controller.models = self.viewModel.detailModel.storeItemsArray;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didClickedAllRelatedServiceOnServiceDetailView:(ServiceDetailView *)detailView {
    ServiceDetailRelatedServiceListViewController *controller = [[ServiceDetailRelatedServiceListViewController alloc] initWithListItemModels:self.viewModel.detailModel.moreServiceItems];
    [controller setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)serviceDetailView:(ServiceDetailView *)detailView didSelectedRelatedServiceAtIndex:(NSUInteger)index {
    ServiceMoreDetailHotSalesItemModel *model = [self.viewModel.detailModel.moreServiceItems objectAtIndex:index];
    ServiceDetailViewController *controller = [[ServiceDetailViewController alloc] initWithServiceId:model.serviceId channelId:model.channelId];
    [controller setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)serviceDetailViewDidClickSeleteMeal:(ServiceDetailView *)detailView{
    if (self.viewModel.detailModel.product_standards.count) {
        
    }
    [self.configView show];
}

#pragma mark ServiceDetailBottomViewDelegate

- (void)didClickedCustomerServiceButtonOnServiceDetailBottomView:(ServiceDetailBottomView *)bottomView {
    NSString *str = [OnlineCustomerService onlineCustomerServiceLinkUrlString];
    if (str.length>0) {
        WebViewController *controller = [[WebViewController alloc]init];
        controller.urlString = str;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)didClickedPhoneButtonOnServiceDetailBottomView:(ServiceDetailBottomView *)bottomView {
    if ([[self.viewModel.detailModel phoneItems] count] > 0) {
        //telprompt
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"请选择门店" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        for (ServiceDetailPhoneItem *item in self.viewModel.detailModel.phoneItems) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:item.title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self makePhoneCallWithNumbers:item.phoneNumbers];
            }];
            [controller addAction:action];
        }
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [controller addAction:cancelAction];
        [self presentViewController:controller animated:YES completion:nil];
    }
}

- (void)didClickedFavourateButtonOnServiceDetailBottomView:(ServiceDetailBottomView *)bottomView {
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        __weak ServiceDetailViewController *weakSelf = self;
        [self.viewModel addOrRemoveFavouriteWithSucceed:^(NSDictionary *data) {
            [bottomView setFavourite:weakSelf.viewModel.detailModel.isFavourate];
        } failure:^(NSError *error) {
            if ([[error userInfo] count] > 0) {
                [[iToast makeText:[[error userInfo] objectForKey:@"data"]] show];
            }
        }];
    }];
}

- (void)didClickedBuyButtonOnServiceDetailBottomView:(ServiceDetailBottomView *)bottomView {
    [self.configView show];
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
            ServiceDetailViewController *controller = [[ServiceDetailViewController alloc] initWithServiceId:model.identifier channelId:model.channelId];
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
            SearchTableViewController *controller = [[SearchTableViewController alloc]init];
            controller.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case KTCActionViewTagShare:
        {
            CommonShareViewController *controller = [CommonShareViewController instanceWithShareObject:self.viewModel.detailModel.shareObject sourceType:KTCShareServiceTypeService];
            
            [self presentViewController:controller animated:YES completion:nil] ;
        }
            break;
        default:
            break;
    }
}

#pragma mark Private methods

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

- (void)resetTitle {
    self.navigationItem.title = self.viewModel.detailModel.serviceBriefName;
    self.navigationItem.title = self.navigationItem.title;
}

- (void)loadConfigView {

    [self.configView setProduct_standards:self.viewModel.detailModel.product_standards currentIndex:self.viewModel.detailModel.currentProductStandardsItemIndex];
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
    [self.bottomView.buyButton setEnabled:self.viewModel.detailModel.canBuy];
    NSString *title = self.viewModel.detailModel.buyButtonTitle;
    if ([title length] == 0) {
        if (self.viewModel.detailModel.canBuy) {
            title = @"立即购买";
        } else {
            title = @"暂不销售";
        }
    }
    [self.bottomView.buyButton setTitle:title forState:UIControlStateNormal];
    [self.bottomView.buyButton setTitle:title forState:UIControlStateSelected];
    [self.bottomView.buyButton setTitle:title forState:UIControlStateDisabled];
    if ([self.viewModel.detailModel showCountdown]) {
        [self hideCountdown:NO];
        [self startCountDown];
    } else {
        [self stopCountDown];
        [self hideCountdown:YES];
    }
    
    [self.bottomView setCustomerServiceButtonHidden:![OnlineCustomerService serviceIsOnline]];
    [self.bottomView setPhoneButtonHidden:!([self.viewModel.detailModel.phoneItems count] > 0)];
}


- (void)goSettlement {
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        ServiceSettlementViewController *controller = [[ServiceSettlementViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }];
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

- (void)buildCountDownView {
    [self.label1 setTextColor:COLOR_PINK];
    [self.gapView setBackgroundColor:COLOR_PINK];
    [ToolBox resetLineView:self.gapView withLayoutAttribute:NSLayoutAttributeWidth];
    [self.countdownLabel setTextColor:COLOR_PINK];
    [self hideCountdown:YES];
}

- (void)startCountDown {
    if (!self.countdownTimer) {
        self.countdownTimer = [[ATCountDown alloc] initWithLeftTimeInterval:self.viewModel.detailModel.countdownTime];
    }
    __weak ServiceDetailViewController *weakSelf = self;
    [weakSelf.countdownTimer startCountDownWithCurrentTimeLeft:^(NSTimeInterval currentTimeLeft) {
        NSString *string = [ToolBox countDownTimeStringWithLeftTime:currentTimeLeft];
        [weakSelf.countdownLabel setText:string];
    } completion:^{
        [weakSelf stopCountDown];
        [weakSelf reloadNetworkData];
    }];
}

- (void)stopCountDown {
    if (!self.countdownTimer) {
        return;
    }
    [self.countdownTimer stopCountDown];
    self.countdownTimer = nil;
}

- (void)hideCountdown:(BOOL)hide {
    if (hide) {
        [self.countdownBGView setHidden:YES];
        self.countdownBGHeight.constant = 0;
    } else {
        [self.countdownBGView setHidden:NO];
        self.countdownBGHeight.constant = 30;
    }
}

- (void)makePhoneCallWithNumbers:(NSArray *)numbers {
    if (!numbers || ![numbers isKindOfClass:[NSArray class]]) {
        return;
    }
    if ([numbers count] == 0) {
        return;
    } else if ([numbers count] == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", [numbers firstObject]]]];
    } else {
        UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"请选择联系电话" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
        for (NSString *phoneNumber in numbers) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:phoneNumber style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@", phoneNumber]]];
            }];
            [controller addAction:action];
        }
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        [controller addAction:cancelAction];
        [self presentViewController:controller animated:YES completion:nil];
    }
}

#pragma mark Super method

- (void)reloadNetworkData {
    [TCProgressHUD showSVP];
    __weak ServiceDetailViewController *weakSelf = self;
    [self.viewModel startUpdateDataWithServiceId:self.serviceId channelId:self.channelId Succeed:^(NSDictionary *data) {
        ServiceDetailViewController *strongSelf = weakSelf;
        [strongSelf.detailView reloadData];
        [strongSelf loadConfigView];
        [strongSelf setupBottomView];
        [strongSelf resetTitle];
        if (strongSelf.isNeedToBuy) {
            [strongSelf submitWithBuyNum:strongSelf.buyNum storeId:strongSelf.storeId];
        }
        [TCProgressHUD dismissSVP];
    } failure:^(NSError *error) {
        [[iToast makeText:@"服务信息查询失败"] show];
        [self.navigationController popViewControllerAnimated:YES];
        //[weakSelf.detailView reloadData];
        //[weakSelf resetTitle];
        [TCProgressHUD dismissSVP];
    }];
}

- (void)submitWithBuyNum:(NSUInteger)buyNum storeId:(NSString *)storeId{
    self.isNeedToBuy = NO;
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        __weak ServiceDetailViewController *weakSelf = self;
        [TCProgressHUD showSVP];
        [weakSelf.viewModel addToSettlementWithBuyCount:buyNum storeId:storeId succeed:^(NSDictionary *data) {
            [TCProgressHUD dismissSVP];
            [weakSelf goSettlement];
        } failure:^(NSError *error) {
            [TCProgressHUD dismissSVP];
            if ([[error userInfo] count] > 0) {
                [[iToast makeText:[[error userInfo] objectForKey:@"data"]] show];
            }
        }];
    }];
}



@end
