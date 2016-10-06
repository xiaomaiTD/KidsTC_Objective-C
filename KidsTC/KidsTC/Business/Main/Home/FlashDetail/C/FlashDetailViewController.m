//
//  FlashDetailViewController.m
//  KidsTC
//
//  Created by zhanping on 5/16/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "FlashDetailViewController.h"
#import "FlashDetailModel.h"
#import "FDHeaderView.h"
// 只要添加了这个宏，就不用带mas_前缀
#define MAS_SHORTHAND
// 只要添加了这个宏，equalTo就等价于mas_equalTo
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#import "SegueModel.h"
#import "SegueMaster.h"
#import "StoreDetialMapViewController.h"
#import "KTCActionView.h"
#import "KTCBrowseHistoryView.h"
#import "SearchTableViewController.h"
#import "CommonShareViewController.h"
#import "WebViewController.h"
#import "FDSegmentView.h"
#import "FDToolBarView.h"
#import "FDCommentLayout.h"
#import "FDCommentCell.h"
#import "FDStoreCell.h"
#import "FDServeDetailCell.h"
#import "FDMoreCell.h"
#import "CommentListViewController.h"
#import "StoreDetailViewController.h"
#import "CommentDetailViewController.h"
#import "ServiceDetailViewController.h"
#import "FDChooseStoreView.h"
#import "FlashAdvanceSettlementViewController.h"
#import "FlashBalanceSettlementViewController.h"
#import "CashierDeskViewController.h"
#import "FlashServiceOrderDetailViewController.h"

#import "FlashSettlementModel.h"

#import "GHeader.h"
#import "TabBarController.h"
#import "InterfaceManager.h"
#import "KTCMapService.h"
#import "OnlineCustomerService.h"
#import "MTA.h"
#import "CashierDeskModel.h"

#define FDSegmentViewHight 40
#define FDToolBarViewHight 60
#define FDStoreCellHight 100

static NSString *serveDetailCellReuseIdentifier = @"serveDetailCellReuseIdentifier";
static NSString *storeCellReuseIdentifier = @"storeCellReuseIdentifier";
static NSString *commentCellReuseIdentifier = @"commentCellReuseIdentifier";
static NSString *moreCellReuseIdentifier = @"moreCellReuseIdentifier";

@interface FlashDetailViewController ()<UITableViewDelegate,
                                        UITableViewDataSource,
                                        FDHeaderViewDelegate,
                                        FDSegmentViewDelegate,
                                        UIWebViewDelegate,
                                        FDToolBarViewDelegate,
                                        KTCActionViewDelegate>
@property (nonatomic, strong) NSString *userLocation;
@property (nonatomic, strong) FDData *data;
@property (nonatomic, strong) FDHeaderView *headerView;
@property (nonatomic, strong) FDSegmentView *segmentView;
@property (nonatomic, strong) FDToolBarView *toolBarView;
@property (nonatomic, strong) FDChooseStoreView *chooseStoreView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *currentAry;

@property (nonatomic, assign) CGFloat serveDetailHight;
@property (nonatomic, assign) CGFloat moreCellHight;
@end

@implementation FlashDetailViewController

- (FDHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[FDHeaderView alloc] init];
        _headerView.delegate = self;
        self.tableView.tableHeaderView = _headerView;
    }
    return _headerView;
}

- (FDSegmentView *)segmentView{
    if (!_segmentView) {
        _segmentView = [[FDSegmentView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, FDSegmentViewHight)];
        _segmentView.delegate = self;
    }
    return _segmentView;
}

- (FDToolBarView *)toolBarView{
    if (!_toolBarView) {
        FDToolBarView *toolBarView = [[FDToolBarView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-FDToolBarViewHight, SCREEN_WIDTH, FDToolBarViewHight)];
        toolBarView.delegate = self;
        _toolBarView = toolBarView;
        [self.view addSubview:_toolBarView];
    }
    return _toolBarView;
}

- (FDChooseStoreView *)chooseStoreView{
    if (!_chooseStoreView) {
        _chooseStoreView = [[[NSBundle mainBundle] loadNibNamed:@"FDChooseStoreView" owner:self options:nil]lastObject];
        _chooseStoreView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self.navigationController.view addSubview:_chooseStoreView];
        _chooseStoreView.hidden = YES;
        __weak typeof(self) weakSelf = self;
        _chooseStoreView.commitBlock = ^void (NSString *selectedStoreId){
            FlashDetailViewController *self = weakSelf;
            [self addToShoppingCartWithSelectedStoreId:selectedStoreId];
        };
    }
    return _chooseStoreView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.serveDetailHight = SCREEN_HEIGHT;
    
    self.moreCellHight = (SCREEN_HEIGHT-FDSegmentViewHight)*0.5;
    
    [self creatTableView];
    
    [self buildRightBarButtons];
    
    [self getLocation];
    
    [self getFlashDetailData];
}

- (void)getFlashDetailData{
    NSDictionary *parameter = @{@"pid":self.pid,
                                @"mapaddr":self.userLocation};
    [TCProgressHUD showSVP];
    [Request startWithName:@"PRODUCE_GET_FS_DETAIL" param:parameter progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [self responseSuccessWithDic:dic];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [[iToast makeText:@"获取闪购商品信息失败"] show];
        [self back];
    }];
}

- (void)responseSuccessWithDic:(NSDictionary *)dic{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        self.data = [FlashDetailModel modelWithDictionary:dic].data;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.navigationItem.title = _data.simpleName;
            self.toolBarView.data = self.data;
            [self setHeaderWithData:_data];
            [self.tableView reloadData];
            [TCProgressHUD dismissSVP];
        });
    });
}

#pragma 加入购物车
- (void)addToShoppingCartWithSelectedStoreId:(NSString *)storeId{
    NSDictionary *parameter = @{@"productid":self.data.serveId,
                                @"storeno":storeId,
                                @"flashSaleSysNo":self.data.fsSysNo};
    [TCProgressHUD showSVP];
    [Request startWithName:@"FS_SHOPPINGCART_SET" param:parameter progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        //加入购物车成功，获取闪购商品结算信息
        [self getOrderConfirmWithConfirmType:1];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
    }];
}

#pragma 获取订单信息
- (void)getOrderConfirmWithConfirmType:(NSUInteger)confirmType{
    FDDataStatus status = self.data.status;
    if (status == FDDataStatus_UnPrePaid) {
        FlashAdvanceSettlementViewController *controller = [[FlashAdvanceSettlementViewController alloc]init];
        controller.orderId = self.data.orderNo;
        [self.navigationController pushViewController:controller animated:YES];
        self.chooseStoreView.hidden = YES;
    }else if (status == FDDataStatus_FlashSuccessUnPay){
        FlashBalanceSettlementViewController *controller = [[FlashBalanceSettlementViewController alloc]init];
        controller.orderId = self.data.orderNo;
        [self.navigationController pushViewController:controller animated:YES];
    }
}


- (void)creatTableView{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.contentInset = UIEdgeInsetsMake(64, 0, FDToolBarViewHight, 0);
    tableView.sectionHeaderHeight = FDSegmentViewHight;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerNib:[UINib nibWithNibName:@"FDServeDetailCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:serveDetailCellReuseIdentifier];
    [tableView registerNib:[UINib nibWithNibName:@"FDStoreCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:storeCellReuseIdentifier];
    [tableView registerNib:[UINib nibWithNibName:@"FDCommentCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:commentCellReuseIdentifier];
    [tableView registerNib:[UINib nibWithNibName:@"FDMoreCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:moreCellReuseIdentifier];
    self.tableView = tableView;
    [self.view addSubview:tableView];
}


#pragma - FDToolBarViewDelegate
- (void)toolBarView:(FDToolBarView *)toolBarView didClickOnType:(FDToolBarViewBtnType)type{
    switch (type) {
        case FDToolBarViewBtnType_Invite:
        {
            FDShare *share = self.data.share;
            CommonShareObject *shareObject = [CommonShareObject shareObjectWithTitle:share.title description:share.desc thumbImageUrl:[NSURL URLWithString:share.imgUrl] urlString:share.linkUrl];
            shareObject.followingContent = @"【童成网】";
            CommonShareViewController *controller = [CommonShareViewController instanceWithShareObject:shareObject sourceType:KTCShareServiceTypeNews];
            [self presentViewController:controller animated:YES completion:nil] ;
        }
            break;
        case FDToolBarViewBtnType_BuyNow:
        {
            ServiceDetailViewController *controller = [[ServiceDetailViewController alloc] initWithServiceId:self.data.serveId channelId:@"0"];
            [self.navigationController pushViewController:controller animated:YES];
            //MTA
            [MTA trackCustomEvent:@"event_skip_search_result_dtl_service" args:nil];
        }
            break;
        case FDToolBarViewBtnType_FlashBuy:
        {
            /**
             
             需要进入【结算】页面的两种状态：
             FDDataStatus_UnPrePaid             = 2,//我要闪购，可以参团未支付
             FDDataStatus_FlashSuccessUnPay     = 10,//立付尾款，开团成功（已预付，没有进入确认页确认）
             
             需要进入【选择支付方式】的两种状态：
             FDDataStatus_WaitPrePaid           = 3,//预付定金，可以参团待预付(已经下单)
             FDDataStatus_FlashSuccessWaitPay   = 11,//立付尾款，开团成功（已预付，已进入确认页确认）
             */
            if ([[User shareUser] hasLogin]) {//如果已经登录
                
                FDDataStatus status = self.data.status;
                
                switch (status) {
                    case FDDataStatus_NotStart://设置提醒
                    {
                        [self openRemind];
                    }
                        break;
                    case FDDataStatus_UnPrePaid://选择门店
                    {
                        self.chooseStoreView.data = self.data;
                    }
                        break;
                    case FDDataStatus_FlashSuccessUnPay:
                    {
                        //获取闪购商品结算信息
                        [self getOrderConfirmWithConfirmType:2];
                        
                    }
                        break;
                    case FDDataStatus_WaitPrePaid:
                    case FDDataStatus_FlashSuccessWaitPay://进入选择支付方式页面
                    {
                        [self choosePayChannel];
                    }
                        break;
                        /**
                         FDDataStatus_WaitBuy               = 4,//等待开团，等待开团（已预付）
                         FDDataStatus_HadPaid               = 12,//闪购成功，已购买
                         */
                    case FDDataStatus_WaitBuy:
                    case FDDataStatus_HadPaid:
                    {
                        
                        FlashServiceOrderDetailViewController *controller = [[FlashServiceOrderDetailViewController alloc]init];
                        controller.orderId = self.data.orderNo;
                        [self.navigationController pushViewController:controller animated:YES];
                    }
                        break;
                        
                    default:
                        break;
                }
            }else{//如果没有登录
                [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
                    [self getFlashDetailData];
                }];
            }
        }
            break;
        default:
            break;
    }
}
- (void)toolBarViewdidEndTimeCountdown:(FDToolBarView *)toolBarView{
    [self getFlashDetailData];
}

- (void)openRemind{
    
    NSDictionary *parameter = @{@"flashSaleSysNo":self.data.fsSysNo,
                                @"isAddRemind":@(1)};
    [TCProgressHUD showSVP];
    [Request startWithName:@"FS_PRODUCT_OPEN_REMIND" param:parameter progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        self.data.isOpenRemind = !self.data.isOpenRemind;
        self.toolBarView.data = self.data;
        [TCProgressHUD dismissSVP];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
    }];
}

- (void)choosePayChannel{
    CashierDeskViewController *controller = [[CashierDeskViewController alloc] initWithNibName:@"CashierDeskViewController" bundle:nil];
    controller.orderId = self.data.orderNo;
    controller.orderKind = CashierDeskOrderKindFlash;
    controller.resultBlock = ^void(BOOL needRefresh){
        [self getFlashDetailData];
    };
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)buildRightBarButtons {
    CGFloat buttonWidth = 28;
    CGFloat buttonHeight = 28;
    CGFloat buttonGap = 15;
    
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, buttonWidth * 2 + buttonGap, buttonHeight)];
    [bgView setBackgroundColor:[UIColor clearColor]];
    
    CGFloat xPosition = 0;
    UIButton *historyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [historyButton setFrame:CGRectMake(xPosition, 0, buttonWidth, buttonHeight)];
    [historyButton setBackgroundColor:[UIColor clearColor]];
    [historyButton setImage:[UIImage imageNamed:@"icon_connect_serve"] forState:UIControlStateNormal];
    [historyButton addTarget:self action:@selector(onlineCustomerService) forControlEvents:UIControlEventTouchUpInside];
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
- (void)onlineCustomerService{
    NSString *str = [OnlineCustomerService onlineCustomerServiceLinkUrlString];
    if (str.length>0) {
        WebViewController *controller = [[WebViewController alloc]init];
        controller.urlString = str;
        [self.navigationController pushViewController:controller animated:YES];
    }
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
            [[TabBarController shareTabBarController] selectIndex:0];
        }
            break;
        case KTCActionViewTagSearch:
        {
            SearchTableViewController *controller = [[SearchTableViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case KTCActionViewTagShare:
        {
            if (self.data.share) {
                CommonShareObject *shareObj = [CommonShareObject shareObjectWithTitle:self.data.share.title
                                                                          description:self.data.share.desc
                                                                        thumbImageUrl:[NSURL URLWithString:self.data.share.imgUrl]
                                                                            urlString:self.data.share.linkUrl];
                CommonShareViewController *controller = [CommonShareViewController instanceWithShareObject:shareObj sourceType:KTCShareServiceTypeService];
                [self presentViewController:controller animated:YES completion:nil] ;
            }
        }
            break;
        default:
            break;
    }
}


- (void)setHeaderWithData:(FDData *)data{
    if (self.headerView) {
        [self.headerView removeFromSuperview];
        self.headerView = nil;
    }
    self.headerView.data = data;
    self.tableView.tableHeaderView = self.headerView;
}

- (void)getLocation {
    self.userLocation = [KTCMapService shareKTCMapService].currentLocationString;
}

#pragma mark - FDHeaderViewDelegate
- (void)fdHeaderView:(FDHeaderView *)fdHeaderView didClickOnMapLabelWithStore:(NSArray<StoreListItemModel *> *)store{
    
    StoreDetialMapViewController *controller = [[StoreDetialMapViewController alloc] init];
    controller.models = store;
    [self.navigationController pushViewController:controller animated:YES];
    //MTA
    [MTA trackCustomEvent:@"event_skip_service_promotion_dtl" args:nil];
}
- (void)fdHeaderView:(FDHeaderView *)fdHeaderView didClickWithSegue:(SegueModel *)segue{
    
    [SegueMaster makeSegueWithModel:segue fromController:self];
}

#pragma mark - FDsegmentViewDelegate
- (void)segmentView:(FDSegmentView *)segmentView didClickBtnType:(FDSegmentViewBtnType)type{
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    CGFloat leftContentHight = SCREEN_HEIGHT - FDToolBarViewHight-FDSegmentViewHight;
    CGFloat moreCellHight = 0;
    FDSegmentViewBtnType btnType = (FDSegmentViewBtnType)self.segmentView.selectedBtn.tag;
    switch (btnType) {
        case FDSegmentViewBtnType_ServeDetail:
        {
            NSString *detailUrl = self.data.detailUrl;
            if (detailUrl && ![detailUrl isEqualToString:@""]) {
                self.currentAry = @[detailUrl];
            }else{
                self.currentAry = nil;
            }
            moreCellHight = leftContentHight-self.serveDetailHight;
        }
            break;
            
        case FDSegmentViewBtnType_Store:
        {
            self.currentAry = self.data.storeModels;
            moreCellHight = leftContentHight-FDStoreCellHight*self.currentAry.count;
        }
            break;
        case FDSegmentViewBtnType_Comment:
        {
            self.currentAry = self.data.commentModelLayouts;
            __block CGFloat cellsHight = 0;
            [self.currentAry enumerateObjectsUsingBlock:^(FDCommentLayout * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                cellsHight += obj.hight;
            }];
            moreCellHight = leftContentHight-cellsHight;
        }
            break;
    }
    self.moreCellHight = moreCellHight<84?84:moreCellHight;
    return self.currentAry.count+1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.data) {
       return self.segmentView;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.data) {
        return FDSegmentViewHight;
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == self.currentAry.count) {
        return self.moreCellHight;
    }
    
    FDSegmentViewBtnType btnType = (FDSegmentViewBtnType)self.segmentView.selectedBtn.tag;
    switch (btnType) {
        case FDSegmentViewBtnType_ServeDetail:
        {
            return self.serveDetailHight;
        }
            break;
            
        case FDSegmentViewBtnType_Store:
        {
            return FDStoreCellHight;
        }
            break;
        case FDSegmentViewBtnType_Comment:
        {
            FDCommentLayout *layout = self.currentAry[indexPath.row];
            return layout.hight;
        }
            break;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FDSegmentViewBtnType btnType = (FDSegmentViewBtnType)self.segmentView.selectedBtn.tag;
    if (indexPath.row == self.currentAry.count) {
        FDMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:moreCellReuseIdentifier];
        [cell configWithCurrentType:btnType cellCount:self.currentAry.count];
        WeakSelf(self)
        cell.showMoreCommentBlock = ^void (){
            StrongSelf(self)
            [self showMoreComments];
        };
        return cell;
    }
    switch (btnType) {
        case FDSegmentViewBtnType_ServeDetail:
        {
                FDServeDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:serveDetailCellReuseIdentifier];
                cell.urlString = self.currentAry[indexPath.row];
                WeakSelf(self)
                cell.didFinishLoadingBlock = ^void (CGFloat hight){
                    StrongSelf(self)
                    self.serveDetailHight = hight;
                    [tableView reloadData];
                };
                return cell;
        }
            break;
            
        case FDSegmentViewBtnType_Store:
        {
            FDStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:storeCellReuseIdentifier];
            cell.storeItem = self.currentAry[indexPath.row];
            return cell;
        }
            break;
        case FDSegmentViewBtnType_Comment:
        {
            FDCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:commentCellReuseIdentifier];
            cell.layout = self.currentAry[indexPath.row];
            return cell;
        }
            break;
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == self.currentAry.count) return;
    
    FDSegmentViewBtnType btnType = (FDSegmentViewBtnType)self.segmentView.selectedBtn.tag;
    switch (btnType) {
        case FDSegmentViewBtnType_ServeDetail:
        {
            return;
        }
            break;
            
        case FDSegmentViewBtnType_Store:
        {
            FDStoreItem *storeItem = self.currentAry[indexPath.row];
            StoreDetailViewController *controller = [[StoreDetailViewController alloc] initWithStoreId:storeItem.storeId];
            [self.navigationController pushViewController:controller animated:YES];
            //MTA
            [MTA trackCustomEvent:@"event_skip_server_stores_dtl" args:nil];
        }
            break;
        case FDSegmentViewBtnType_Comment:
        {
            NSDictionary *commentDic = self.data.commentList[indexPath.row];
            CommentListItemModel *model = [[CommentListItemModel alloc]initWithRawData:commentDic];
            model.relationIdentifier = self.data.serveId;
            CommentDetailViewController *controller = [[CommentDetailViewController alloc] initWithSource:CommentDetailViewSourceServiceOrStore relationType:self.data.productType headerModel:model];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
    }
}


-(void)showMoreComments{
    FDComment *comment = self.data.comment;
    NSDictionary *commentNumberDic = @{CommentListTabNumberKeyAll:@(comment.all),
                                       CommentListTabNumberKeyGood:@(comment.good),
                                       CommentListTabNumberKeyNormal:@(comment.normal),
                                       CommentListTabNumberKeyBad:@(comment.bad),
                                       CommentListTabNumberKeyPicture:@(comment.pic)};
    CommentListViewController *controller = [[CommentListViewController alloc] initWithIdentifier:self.data.serveId relationType:CommentRelationTypeRealProduct commentNumberDic:commentNumberDic];
    [self.navigationController pushViewController:controller animated:YES];
}
@end
