//
//  FlashBuyProductDetailViewController.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/22.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "FlashBuyProductDetailViewController.h"
#import "NSString+Category.h"
#import "GHeader.h"
#import "KTCMapService.h"
#import "SegueMaster.h"
#import "BuryPointManager.h"
#import "OnlineCustomerService.h"
#import "ZPPopover.h"
#import "TabBarController.h"
#import "NavigationController.h"

#import "FlashBuyProductDetailModel.h"
#import "FlashBuyProductDetailView.h"
#import "FlashBuyProductDetailNaviRightView.h"

#import "StoreDetialMapViewController.h"
#import "WebViewController.h"
#import "CommentDetailViewController.h"
#import "CommentListViewController.h"
#import "CommonShareViewController.h"
#import "FlashServiceOrderDetailViewController.h"
#import "CashierDeskViewController.h"
#import "FlashAdvanceSettlementViewController.h"
#import "FlashBalanceSettlementViewController.h"
#import "FlashBuyProductDetailSelectStoreViewController.h"
#import "SearchViewController.h"

@interface FlashBuyProductDetailViewController ()
<
FlashBuyProductDetailViewDelegate,
FlashBuyProductDetailNaviRightViewDelegate,
FlashBuyProductDetailSelectStoreViewControllerDelegate,
ZPPopoverDelegate
>
@property (nonatomic, strong) FlashBuyProductDetailView *detailView;
@property (nonatomic, strong) FlashBuyProductDetailData *data;
@end

@implementation FlashBuyProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![self checkValidate]) return;
    [self setupNavi];
    [self setupView];
    [self loadData];
}

- (BOOL)checkValidate {
    if (![_pid isNotNull]) {
        [[iToast makeText:@"商品编号为空！"] show];
        [self back];
        return NO;
    }
    return YES;
}

#pragma mark - setupNavi

- (void)setupNavi {
    self.navigationItem.title = @"闪购详情";
    //self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    FlashBuyProductDetailNaviRightView *naviRightView = [[NSBundle mainBundle] loadNibNamed:@"FlashBuyProductDetailNaviRightView" owner:self options:nil].firstObject;
    naviRightView.delegate = self;
    naviRightView.bounds = CGRectMake(0, 0, 64, 26);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:naviRightView];
}

#pragma mark FlashBuyProductDetailNaviRightViewDelegate

- (void)flashBuyProductDetailNaviRightView:(FlashBuyProductDetailNaviRightView *)view actionType:(FlashBuyProductDetailNaviRightViewActionTyep)type value:(id)value {
    switch (type) {
        case FlashBuyProductDetailNaviRightViewActionTyepContact:
        {
            [self contact];
        }
            break;
        case FlashBuyProductDetailNaviRightViewActionTyepMore:
        {
            [self more];
        }
            break;
        default:
            break;
    }
}

#pragma mark contact

- (void)contact {
    NSString *str = [OnlineCustomerService onlineCustomerServiceLinkUrlString];
    if ([str isNotNull]) {
        WebViewController *controller = [[WebViewController alloc]init];
        controller.urlString = str;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark more

- (void)more {
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
        [self invite:nil];
    }
}

#pragma mark - setupView

- (void)setupView {
    FlashBuyProductDetailView *detailView = [[FlashBuyProductDetailView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    detailView.delegate = self;
    [self.view addSubview:detailView];
    self.detailView = detailView;
}

#pragma mark FlashBuyProductDetailViewDelegate

- (void)flashBuyProductDetailView:(FlashBuyProductDetailView *)view actionType:(FlashBuyProductDetailViewActionType)type value:(id)value {

    switch (type) {
        case FlashBuyProductDetailViewActionTypeSegue:
        {
            [self segue:value];
        }
            break;
        case FlashBuyProductDetailViewActionTypeAddress:
        {
            [self address:value];
        }
            break;
        case FlashBuyProductDetailViewActionTypeRule:
        {
            [self rule:value];
        }
            break;
        case FlashBuyProductDetailViewActionTypeChangeShowType:
        {
            
        }
            break;
        case FlashBuyProductDetailViewActionTypeComment:
        {
            [self comment:value];
        }
            break;
        case FlashBuyProductDetailViewActionTypeMoreComment:
        {
            [self moreComment:value];
        }
            break;
        case FlashBuyProductDetailViewActionTypeWebLoadFinish:
        {
            
        }
            break;
        case FlashBuyProductDetailViewActionTypeInvite:
        {
            [self invite:value];
        }
            break;
        case FlashBuyProductDetailViewActionTypeOriginalPriceBuy:
        {
            [self segue:value];
        }
            break;
        case FlashBuyProductDetailViewActionTypeStatus:
        {
            [self status:value];
        }
            break;
        case FlashBuyProductDetailViewActionTypeCountDownOver:
        {
            [self loadData];
        }
            break;
    }
}

#pragma mark segue

- (void)segue:(id)value {
    [SegueMaster makeSegueWithModel:value fromController:self];
}

#pragma mark address

- (void)address:(id)value {
    if (self.data.storeModels.count<1) {
        return;
    }
    StoreDetialMapViewController *controller = [[StoreDetialMapViewController alloc] init];
    controller.models = self.data.storeModels;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark rule

- (void)rule:(id)value {
    NSString *url = self.data.flowLinkUrl;
    if (![url isNotNull]) {
        return;
    }
    WebViewController *controller = [[WebViewController alloc] init];
    controller.urlString = url;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark comment

- (void)comment:(id)value {
    if (![value respondsToSelector:@selector(integerValue)]) return;
    NSInteger index = [value integerValue];
    if (index<_data.commentItemsArray.count) {
        CommentListItemModel *model = self.data.commentItemsArray[index];
        model.relationIdentifier = self.data.serveId;
        CommentDetailViewController *controller = [[CommentDetailViewController alloc] initWithSource:CommentDetailViewSourceServiceOrStore relationType:(CommentRelationType)self.data.productType headerModel:model];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark moreComment

- (void)moreComment:(id)value {
    FlashBuyProductDetailComment *comment = self.data.comment;
    NSDictionary *commentNumberDic = @{CommentListTabNumberKeyAll:@(comment.all),
                                       CommentListTabNumberKeyGood:@(comment.good),
                                       CommentListTabNumberKeyNormal:@(comment.normal),
                                       CommentListTabNumberKeyBad:@(comment.bad),
                                       CommentListTabNumberKeyPicture:@(comment.pic)};
    CommentListViewController *controller = [[CommentListViewController alloc] initWithIdentifier:self.data.serveId relationType:(CommentRelationType)self.data.productType commentNumberDic:commentNumberDic];
    [self.navigationController pushViewController:controller animated:YES];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if ([_pid isNotNull]) {
        [params setValue:_pid forKey:@"pid"];
    }
    [BuryPointManager trackEvent:@"event_skip_serve_evalist" actionId:20603 params:params];
}

#pragma mark invite

- (void)invite:(id)value {
    CommonShareViewController *controller = [CommonShareViewController instanceWithShareObject:self.data.shareObject sourceType:KTCShareServiceTypeStore];
    [self presentViewController:controller animated:YES completion:nil] ;
}

#pragma mark status

- (void)status:(id)value {
    if (![User shareUser].hasLogin) {
        [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
            [self loadData];
        }];
        return;
    }
    switch (self.data.status) {
            
        case FlashBuyProductDetailStatusNotStart://= 1,//闪购尚未开始，未到预约时间
        {
            [self remind:value];//设置提醒
        }
            break;
        case FlashBuyProductDetailStatusUnPrePaid://= 2,//我要闪购，可以参团未支付
        {
            [self chooseStore:value];
        }
            break;
        case FlashBuyProductDetailStatusWaitPrePaid://= 3,//预付定金，可以参团待预付(已经下单)
        {
            [self cashierDesk:value];
        }
            break;
        case FlashBuyProductDetailStatusWaitBuy://= 4,//等待开团，等待开团（已预付）
        {
            [self orderDetail:value];
        }
            break;
        case FlashBuyProductDetailStatusFlashFailedUnPrePaid://= 5,//闪购结束，开团失败(未预付)
        {
            
        }
            break;
        case FlashBuyProductDetailStatusFlashFailedPrePaid://= 6,//闪购结束，开团失败（已预付）
        {
            
        }
            break;
        case FlashBuyProductDetailStatusRefunding://= 7,//退款中，开团失败（已预付）- 在订单中
        {
            
        }
            break;
        case FlashBuyProductDetailStatusRefunded://= 8,//退款成功，开团失败（已预付）-在订单中
        {
            
        }
            break;
        case FlashBuyProductDetailStatusFlashSuccessNoPrePaid://= 9,//闪购结束，开团成功（未预付）
        {
            
        }
            break;
        case FlashBuyProductDetailStatusFlashSuccessUnPay://= 10,//立付尾款，开团成功（已预付，没有进入确认页确认）
        {
            [self balanceSettlement:value];
        }
            break;
        case FlashBuyProductDetailStatusFlashSuccessWaitPay://= 11,//立付尾款，开团成功（已预付，已进入确认页确认）
        {
            [self cashierDesk:value];
        }
            break;
        case FlashBuyProductDetailStatusHadPaid://= 12,//闪购成功，已购买
        {
            [self orderDetail:value];
        }
            break;
        case FlashBuyProductDetailStatusProductRunOut://= 13,//已售罄
        {
            
        }
            break;
        case FlashBuyProductDetailStatusProductNotSale://= 14,//暂不销售
        {
            
        }
            break;
        case FlashBuyProductDetailStatusBuyTimeEnd://= 15,//闪购结束，购买时间已过
        {
            
        }
            break;
        case FlashBuyProductDetailStatusEvaluted://= 16,//已评价，已评价 -在订单中
        {
            
        }
            break;
        case FlashBuyProductDetailStatusWaitEvalute://= 17,//去评价，去评价 -在订单中
        {
            
        }
            break;
        case FlashBuyProductDetailStatusUnLogIn://= 100//我要闪购，未登录：立即参加
        {
            
        }
            break;
    }
}

#pragma mark remind

- (void)remind:(id)value {
    NSDictionary *parameter = @{@"flashSaleSysNo":self.data.fsSysNo,
                                @"isAddRemind":@(1)};
    [TCProgressHUD showSVP];
    [Request startWithName:@"FS_PRODUCT_OPEN_REMIND" param:parameter progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        [self remindSuccess:nil];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self remindFailure:error];
    }];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if ([_pid isNotNull]) {
        [params setValue:_pid forKey:@"pid"];
    }
    [BuryPointManager trackEvent:@"event_result_flash_remind" actionId:20604 params:params];
}

- (void)remindSuccess:(id)value {
    self.data.isOpenRemind = !self.data.isOpenRemind;
    self.detailView.data = self.data;
    [[iToast makeText:@"设置提醒成功"] show];
}

- (void)remindFailure:(NSError *)error {
    NSString *errMsg = @"设置提醒失败";
    NSString *text = [NSString stringWithFormat:@"%@",error.userInfo[@"data"]];
    if ([text isNotNull]) errMsg = text;
    [[iToast makeText:errMsg] show];
}

#pragma mark chooseStore

- (void)chooseStore:(id)value {
    FlashBuyProductDetailSelectStoreViewController *controller = [[FlashBuyProductDetailSelectStoreViewController alloc] initWithNibName:@"FlashBuyProductDetailSelectStoreViewController" bundle:nil];
    controller.stores = self.data.store;
    controller.prepaidPrice = self.data.prepaidPrice;
    controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    controller.modalPresentationStyle = UIModalPresentationCustom;
    controller.delegate = self;
    [self presentViewController:controller animated:NO completion:nil];
}

#pragma mark FlashBuyProductDetailSelectStoreViewControllerDelegate

- (void)flashBuyProductDetailSelectStoreViewController:(FlashBuyProductDetailSelectStoreViewController *)controller actionType:(FlashBuyProductDetailSelectStoreViewControllerActionType)type value:(id)value {
    switch (type) {
        case FlashBuyProductDetailSelectStoreViewControllerActionTypeCommit:
        {
            [self commit:value];
        }
            break;
        default:
            break;
    }
}

- (void)commit:(id)value {
    
    if (![value isKindOfClass:[FlashBuyProductDetailStore class]]) {
        return;
    }
    
    FlashBuyProductDetailStore *store = value;
    
    NSString *storeId = store.storeId;
    if (![storeId isNotNull]) {
        [[iToast makeText:@"所选门店编号为空！"] show];
        return;
    }
    
    NSString *productid = self.data.serveId;
    if (![productid isNotNull]) {
        [[iToast makeText:@"当前服务编号为空！"] show];
        return;
    }
    
    NSString *flashSaleSysNo = self.data.fsSysNo;
    if (![flashSaleSysNo isNotNull]) {
        [[iToast makeText:@"当前闪购编号为空！"] show];
        return;
    }
    
    NSDictionary *param = @{@"productid":productid,
                            @"storeno":storeId,
                            @"flashSaleSysNo":flashSaleSysNo};
    [TCProgressHUD showSVP];
    [Request startWithName:@"FS_SHOPPINGCART_SET" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        [self commitSuccess:nil];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [self commitFailure:error];
    }];
}

- (void)commitSuccess:(id)value {
    if (self.presentedViewController) {
        [self.presentedViewController dismissViewControllerAnimated:YES completion:^{
            [self advanceSettlement];
        }];
    }else{
        [self advanceSettlement];
    }
}

- (void)commitFailure:(NSError *)error {
    NSString *errMsg = @"加入购物车失败，请稍后再试！";
    NSString *text = [NSString stringWithFormat:@"%@",error.userInfo[@"data"]];
    if ([text isNotNull]) errMsg = text;
    [[iToast makeText:errMsg] show];
}

- (void)advanceSettlement {
    FlashAdvanceSettlementViewController *controller = [[FlashAdvanceSettlementViewController alloc]init];
    controller.orderId = self.data.orderNo;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark orderDetail

- (void)orderDetail:(id)value {
    FlashServiceOrderDetailViewController *controller = [[FlashServiceOrderDetailViewController alloc]init];
    controller.orderId = self.data.orderNo;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark cashierDesk

- (void)cashierDesk:(id)value {
    CashierDeskViewController *controller = [[CashierDeskViewController alloc] initWithNibName:@"CashierDeskViewController" bundle:nil];
    controller.orderId = self.data.orderNo;
    controller.productType = ProductDetailTypeFalsh;
    controller.resultBlock = ^void(BOOL needRefresh){
        [self loadData];
    };
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark balanceSettlement

- (void)balanceSettlement:(id)value {
    FlashBalanceSettlementViewController *controller = [[FlashBalanceSettlementViewController alloc]init];
    controller.orderId = self.data.orderNo;
    [self.navigationController pushViewController:controller animated:YES];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if ([_pid isNotNull]) {
        [params setValue:_pid forKey:@"pid"];
    }
    [BuryPointManager trackEvent:@"event_skip_flash_balance" actionId:20605 params:params];
}

#pragma mark loadData

- (void)loadData {
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:self.pid forKey:@"pid"];
    NSString *mapaddr = [KTCMapService shareKTCMapService].currentLocationString;
    if ([mapaddr isNotNull]) {
        [param setObject:mapaddr forKey:@"mapaddr"];
    }
    [TCProgressHUD showSVP];
    [Request startWithName:@"PRODUCE_GET_FS_DETAIL" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        FlashBuyProductDetailData *data = [FlashBuyProductDetailModel modelWithDictionary:dic].data;
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

- (void)loadDataSuccess:(FlashBuyProductDetailData *)data {
    self.data = data;
    self.detailView.data = data;
    self.navigationItem.title = data.simpleName;
}

- (void)loadDataFailure:(NSError *)error {
    NSString *errMsg = @"获取闪购商品信息失败";
    NSString *text = [NSString stringWithFormat:@"%@",error.userInfo[@"data"]];
    if ([text isNotNull]) errMsg = text;
    [[iToast makeText:errMsg] show];
    [self back];
}

@end
