//
//  UserCenterViewController.m
//  KidsTC
//
//  Created by zhanping on 7/26/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "UserCenterViewController.h"
#import "RefreshHeader.h"
#import "RefreshFooter.h"
#import "GHeader.h"
#import "UserCenterModel.h"
#import "UIBarButtonItem+Category.h"
#import "InterfaceManager.h"
#import "OnlineCustomerService.h"
#import "SegueMaster.h"
#import "MTA.h"
#import "UMMobClick/MobClick.h"
#import "UserCenterMessageButton.h"

#import "UserCenterBaseCell.h"
#import "UserCenterHeaderCell.h"
#import "UserCenterOrderCell.h"
#import "UserCenterItemsCell.h"
#import "UserCenterFlashCell.h"
#import "UserCenterContactCell.h"
#import "UserCenterBannerCell.h"
#import "UserCenterProductCell.h"

#import "SoftwareSettingViewController.h"
#import "NotificationCenterViewController.h"
#import "AccountSettingViewController.h"
#import "ArticleWeChatTableViewController.h"
#import "FavourateViewController.h"
#import "BrowseHistoryViewController.h"
#import "OrderListViewController.h"
#import "CommentTableViewController.h"
#import "CouponListViewController.h"
#import "AppointmentOrderListViewController.h"
#import "FlashServiceOrderListViewController.h"
#import "FlashDetailViewController.h"
#import "ServiceDetailViewController.h"
#import "WebViewController.h"

#import "TabBarController.h"

@interface UserCenterViewController ()<UITableViewDelegate,UITableViewDataSource,UserCenterBaseCellDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<NSMutableArray<UserCenterBaseCell *> *> *staticCells;
@property (nonatomic, strong) NSMutableArray<NSMutableArray<UserCenterBaseCell *> *> *cells;
@property (nonatomic, strong) UserCenterHeaderCell *headerCell;
@property (nonatomic, strong) UserCenterOrderCell *orderCell;
@property (nonatomic, strong) UserCenterItemsCell *itemsCell;
@property (nonatomic, strong) UserCenterFlashCell *flashCell;
@property (nonatomic, strong) UserCenterContactCell *contactCell;
@property (nonatomic, strong) UserCenterBannerCell *bannerCell;
@property (nonatomic, strong) UserCenterProductCell *productCell;
@property (nonatomic, strong) UserCenterModel *model;
@property (nonatomic, strong) UserCenterMessageButton *messageBtn;
@end

@implementation UserCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initui];
    
    [self prepareData];
    
    [NotificationCenter addObserver:self selector:@selector(userLogout) name:kUserLogoutNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
    [self scrollViewDidScroll:self.tableView];
}

- (void)dealloc{
    [NotificationCenter removeObserver:self name:kUserLogoutNotification object:nil];
}

- (void)initui{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initNaviBarItems];
    
    [self initTableView];
}

#pragma mark - NaviBarItems

- (void)initNaviBarItems{
    self.navigationItem.leftBarButtonItem =
    [UIBarButtonItem itemWithImageName:@"nav_setting_icon"
                         highImageName:@"nav_setting_icon"
                               postion:UIBarButtonPositionLeft
                                target:self
                                action:@selector(leftBarButtonItemAction)];
    
    self.messageBtn =
    [UserCenterMessageButton btnWithImageName:@"nav_message_icon"
                                highImageName:@"nav_message_icon"
                                       target:self
                                       action:@selector(rightBarButtonItemAction)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.messageBtn];
}

- (void)leftBarButtonItemAction{
    SoftwareSettingViewController *controller = [[SoftwareSettingViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)rightBarButtonItemAction{
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        NotificationCenterViewController *controller = [[NotificationCenterViewController alloc]init];
        [self.navigationController pushViewController:controller animated:YES];
    }];
}

#pragma mark - TableView

- (void)initTableView{
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    WeakSelf(self)
    RefreshHeader *mj_header = [RefreshHeader headerWithRefreshingBlock:^{
        StrongSelf(self)
        [self getData];
    }];
    mj_header.automaticallyChangeAlpha = YES;
    tableView.mj_header = mj_header;
}

- (void)prepareData{
    
    self.headerCell  = [self cellWithNib:@"UserCenterHeaderCell"];
    self.orderCell   = [self cellWithNib:@"UserCenterOrderCell"];
    self.itemsCell   = [self cellWithNib:@"UserCenterItemsCell"];
    self.flashCell   = [self cellWithNib:@"UserCenterFlashCell"];
    self.contactCell = [self cellWithNib:@"UserCenterContactCell"];
    self.bannerCell  = [self cellWithNib:@"UserCenterBannerCell"];
    self.productCell = [self cellWithNib:@"UserCenterProductCell"];
    
    self.staticCells = [NSMutableArray array];
    
    NSMutableArray *section0 = [NSMutableArray array];
    [section0 addObject:self.headerCell];
    [section0 addObject:self.orderCell];
    [self.staticCells addObject:section0];
    
    NSMutableArray *section1 = [NSMutableArray array];
    [section1 addObject:self.itemsCell];
    [self.staticCells addObject:section1];
    
    NSMutableArray *section2 = [NSMutableArray array];
    [section2 addObject:self.flashCell];
    [self.staticCells addObject:section2];
    
    NSMutableArray *section3 = [NSMutableArray array];
    [section3 addObject:self.contactCell];
    [self.staticCells addObject:section3];
    
    self.cells = self.staticCells;
}

- (id)cellWithNib:(NSString *)nib{
    return [[NSBundle mainBundle] loadNibNamed:nib owner:self options:nil].firstObject;
}

- (void)userLogout{
    [self getData];
}

#pragma mark loadData

- (void)getData{
    [Request startWithName:@"GET_USER_CENTER" param:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [self loadDataSuccessModel:[UserCenterModel modelWithDictionary:dic]];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self loadDataFailure];
    }];
}

- (void)loadDataSuccessModel:(UserCenterModel *)model{
    [self.tableView.mj_header endRefreshing];
    
    self.navigationItem.title = model.data.userInfo.usrName;
    self.messageBtn.badgeValue = model.data.userCount.unReadMsgCount;
    
    self.model = model;
    
    [self setupSections];
    
    [self.tableView reloadData];
    
    [User shareUser].phone = self.model.data.userInfo.mobile;
}

- (void)loadDataFailure{
    self.cells = self.staticCells;
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
}

- (void)setupSections {
    
    NSMutableArray *sections = [NSMutableArray array];
    [sections addObjectsFromArray:self.staticCells];
    if (_model.data.config.banners.count>0) {
        NSMutableArray *section4 = [NSMutableArray array];
        [section4 addObject:self.bannerCell];
        [sections addObject:section4];
    }
    if (_model.data.config.hotProduct.productLs.count>0) {
        NSMutableArray *section5 = [NSMutableArray array];
        [section5 addObject:self.productCell];
        [sections addObject:section5];
    }
    self.cells = sections;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    self.naviColor = [COLOR_PINK colorWithAlphaComponent:offsetY/64];
    [self.navigationController setNavigationBarHidden:offsetY<0 animated:NO];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.cells.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.cells[section].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return (([TabBarController shareTabBarController].viewControllers.count==5)&&(section==self.cells.count-1))?(SCREEN_WIDTH/5-49+8):8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserCenterBaseCell *cell = self.cells[indexPath.section][indexPath.row];
    if (cell == self.bannerCell) {
        return self.model.data.config.bannersHeight;
    }else if (cell == self.productCell){
        return self.model.data.config.hotProductHeight;
    }
    return CGRectGetHeight(self.cells[indexPath.section][indexPath.row].frame);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserCenterBaseCell *cell = self.cells[indexPath.section][indexPath.row];
    cell.model = self.model;
    cell.delegate = self;
    return cell;
}

#pragma mark - UserCenterBaseCellDelegate

- (void)userCenterCell:(UserCenterBaseCell *)cell actionType:(UserCenterCellActionType)type addIndex:(NSUInteger)index{
    [self checkLogin:type relultBlock:^{
        [self checkOverUserCenterCell:cell actionType:type addIndex:index];
    }];
}

- (void)checkLogin:(UserCenterCellActionType)type relultBlock:(void(^)())resultBlock{
    switch (type) {
        case UserCenterCellActionTypeUnLogin:
        case UserCenterCellActionTypeHasLogin:
        case UserCenterCellActionTypeMyCollection:
        case UserCenterCellActionTypeSignup:
        case UserCenterCellActionTypeBrowHistory:
        case UserCenterCellActionTypeAllOrder:
        case UserCenterCellActionTypeWaitPay:
        case UserCenterCellActionTypeWaitUse:
        case UserCenterCellActionTypeMyComment:
        case UserCenterCellActionTypeRefund:
        case UserCenterCellActionTypeCoupon:
        case UserCenterCellActionTypePointment:
        case UserCenterCellActionTypeCarrotHistory:
        case UserCenterCellActionTypeFlashBy:
        {
            [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
                if(resultBlock)resultBlock();
            }];
        }
            break;
        case UserCenterCellActionTypeInvite:
        case UserCenterCellActionTypeHeadLine:
        case UserCenterCellActionTypeConsult:
        case UserCenterCellActionTypeContact:
        case UserCenterCellActionTypeBanners:
        case UserCenterCellActionTypeProduct:
        {
            if(resultBlock)resultBlock();
        }
            break;
    }
}

- (void)checkOverUserCenterCell:(UserCenterBaseCell *)cell actionType:(UserCenterCellActionType)type addIndex:(NSUInteger)index{
    TCLog(@"checkOverUserCenterCell--actionType:%zd addIndex:%zd",type,index);
    UIViewController *toController = nil;
    switch (type) {
        case UserCenterCellActionTypeUnLogin:
        {}
            break;
        case UserCenterCellActionTypeHasLogin:
        {
            UserCenterUserInfo *userInfo = self.model.data.userInfo;
            AccountSettingModel *model = [AccountSettingModel modelWithHeaderUrl:userInfo.headUrl userName:userInfo.usrName mobile:userInfo.mobile];
            AccountSettingViewController *controller = [[AccountSettingViewController alloc]init];
            controller.model = model;
            toController = controller;
        }
            break;
        case UserCenterCellActionTypeMyCollection:
        {
            toController = [[FavourateViewController alloc] initWithNibName:@"FavourateViewController" bundle:nil];
        }
            break;
        case UserCenterCellActionTypeSignup:
        {
            WebViewController *controller = [[WebViewController alloc]init];
            controller.urlString = self.model.data.radish.linkUrl;
            toController = controller;
        }
            break;
        case UserCenterCellActionTypeBrowHistory:
        {
            toController = [[BrowseHistoryViewController alloc]init];
        }
            break;
        case UserCenterCellActionTypeAllOrder:
        {
            toController = [[OrderListViewController alloc] initWithOrderListType:OrderListTypeAll];
            //MTA
            [MTA trackCustomKeyValueEvent:@"event_skip_acct_orders" props:nil];
            [MobClick event:@"event_skip_acct_orders" attributes:nil];
        }
            break;
        case UserCenterCellActionTypeWaitPay:
        {
            toController = [[OrderListViewController alloc] initWithOrderListType:OrderListTypeWaitingPayment];
            //MTA
            [MTA trackCustomKeyValueEvent:@"event_skip_acct_orders" props:nil];
            [MobClick event:@"event_skip_acct_orders" attributes:nil];
        }
            break;
        case UserCenterCellActionTypeWaitUse:
        {
            toController = [[OrderListViewController alloc] initWithOrderListType:OrderListTypeWaitingUse];
            //MTA
            [MTA trackCustomKeyValueEvent:@"event_skip_acct_orders" props:nil];
            [MobClick event:@"event_skip_acct_orders" attributes:nil];
        }
            break;
        case UserCenterCellActionTypeMyComment:
        {
            CommentTableViewController *controller = [[CommentTableViewController alloc]init];
            controller.isHaveWaitToComment = self.model.data.userCount.order_wait_evaluate>0;
            toController = controller;
            //MTA
            [MTA trackCustomKeyValueEvent:@"event_skip_acct_comment" props:nil];
            [MobClick event:@"event_skip_acct_comment" attributes:nil];
        }
            break;
        case UserCenterCellActionTypeRefund:
        {
            toController = [[OrderListViewController alloc] initWithOrderListType:OrderListTypeRefund];
            [MTA trackCustomKeyValueEvent:@"event_skip_acct_orders" props:nil];
            [MobClick event:@"event_skip_acct_orders" attributes:nil];
        }
            break;
        case UserCenterCellActionTypeCoupon:
        {
            toController = [[CouponListViewController alloc] initWithNibName:@"CouponListViewController" bundle:nil];
        }
            break;
        case UserCenterCellActionTypePointment:
        {
            toController = [[AppointmentOrderListViewController alloc] initWithNibName:@"AppointmentOrderListViewController" bundle:nil];
            //MTA
            [MTA trackCustomKeyValueEvent:@"event_skip_acct_appoints" props:nil];
            [MobClick event:@"event_skip_acct_appoints" attributes:nil];
        }
            break;
        case UserCenterCellActionTypeCarrotHistory:
        {
            WebViewController *controller = [[WebViewController alloc]init];
            controller.urlString = self.model.data.exHistory.linkUrl;
            toController = controller;
        }
            break;
        case UserCenterCellActionTypeInvite:
        {
            WebViewController *controller = [[WebViewController alloc]init];
            controller.urlString = self.model.data.invite.linkUrl;
            toController = controller;
        }
            break;
        case UserCenterCellActionTypeFlashBy:
        {
            toController = [[FlashServiceOrderListViewController alloc]init];
        }
            break;
        case UserCenterCellActionTypeHeadLine:
        {
            toController = [[ArticleWeChatTableViewController alloc] init];
        }
            break;
        case UserCenterCellActionTypeConsult:
        {
            NSString *str = [OnlineCustomerService onlineCustomerServiceLinkUrlString];
            if (str.length>0) {
                WebViewController *controller = [[WebViewController alloc]init];
                controller.urlString = str;
                [self.navigationController pushViewController:controller animated:YES];
            }
        }
            break;
        case UserCenterCellActionTypeContact:
        {
            NSString *callNumStr = self.model.data.kfMobile.length>0?self.model.data.kfMobile:@"021-51135015";
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", callNumStr]]];
        }
            break;
        case UserCenterCellActionTypeBanners:
        {
            UserCenterBannersItem *item = self.model.data.config.banners[index];
            [SegueMaster makeSegueWithModel:item.segueModel fromController:self];
        }
            break;
        case UserCenterCellActionTypeProduct:
        {
            UserCenterHotProduct *hotProduct = self.model.data.config.hotProduct;
            UserCenterProductLsItem *item = hotProduct.productLs[index];
            switch (hotProduct.productType) {
                case UserCenterHotProductTypeUnknow:
                {}
                    break;
                case UserCenterHotProductTypeNormolProduct:
                {
                    toController = [[ServiceDetailViewController alloc] initWithServiceId:item.productId channelId:item.channelId];
                }
                    break;
                case UserCenterHotProductTypeCarrot:
                {
                    WebViewController *controller = [[WebViewController alloc] init];
                    controller.urlString = item.linkUrl;
                    toController = controller;
                }
                    break;
                case UserCenterHotProductTypeFlashBy:
                {
                    FlashDetailViewController *controller = [[FlashDetailViewController alloc] init];
                    controller.pid = item.fsSysNo;
                    toController = controller;
                }
                    break;
            }
        }
            break;
    }
    if (toController) [self.navigationController pushViewController:toController animated:YES];
}

@end
