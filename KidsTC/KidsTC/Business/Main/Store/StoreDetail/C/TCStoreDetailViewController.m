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


#import "TCStoreDetailModel.h"
#import "TCStoreDetailView.h"
#import "TCStoreDetailNaviRightView.h"

#import "TabBarController.h"
#import "NavigationController.h"
#import "SearchViewController.h"
#import "CommonShareViewController.h"


@interface TCStoreDetailViewController ()
<
TCStoreDetailNaviRightViewDelegate,
TCStoreDetailViewDelegate,
ZPPopoverDelegate,
KTCBrowseHistoryViewDelegate,
KTCBrowseHistoryViewDataSource
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
}

- (void)loadDataFailure:(NSError *)error {
    NSString *errMsg = @"门店信息获取失败！";
    NSString *text = [NSString stringWithFormat:@"%@",error.userInfo[@"data"]];
    if ([text isNotNull]) errMsg = text;
    [[iToast makeText:errMsg] show];
    [self back];
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
