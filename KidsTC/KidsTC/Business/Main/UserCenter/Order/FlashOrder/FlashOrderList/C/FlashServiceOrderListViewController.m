//
//  FlashServiceOrderListViewController.m
//  KidsTC
//
//  Created by zhanping on 8/18/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "FlashServiceOrderListViewController.h"
#import "GHeader.h"
#import "FlashServiceOrderListModel.h"
#import "FlashServiceOrderListCell.h"
#import "KTCEmptyDataView.h"
#import "YYTimer.h"

#import "FlashServiceOrderDetailViewController.h"
#import "FlashDetailViewController.h"
#import "CashierDeskViewController.h"
#import "FlashBalanceSettlementViewController.h"
#import "CommentFoundingViewController.h"

#define PAGECOUNT 10

NSString *const FlashServiceOrderListCellCountDownNoti = @"FlashServiceOrderListCellCountDownNoti";

@interface FlashServiceOrderListViewController ()<UITableViewDelegate,UITableViewDataSource,FlashServiceOrderListCellDelegate,CommentFoundingViewControllerDelegate>
@property (nonatomic, weak  ) UITableView    *tableView;
@property (nonatomic, strong) NSMutableArray<FlashServiceOrderListItem *> *ary;
@property (nonatomic, assign) NSUInteger     page;
@property (nonatomic, strong) YYTimer *timer;
@end

static NSString *const ID = @"FlashServiceOrderListCellID";

@implementation FlashServiceOrderListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"闪购订单";
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tableView.estimatedRowHeight = 44.0f;
    tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:tableView];
    _tableView = tableView;
    [tableView registerNib:[UINib nibWithNibName:@"FlashServiceOrderListCell" bundle:nil] forCellReuseIdentifier:ID];
    
    WeakSelf(self)
    RefreshHeader *mj_header = [RefreshHeader headerWithRefreshingBlock:^{
        StrongSelf(self)
        [self loadOrderListRefresh:YES];
    }];
    mj_header.automaticallyChangeAlpha = YES;
    tableView.mj_header = mj_header;
    RefreshFooter *mj_footer = [RefreshFooter footerWithRefreshingBlock:^{
        StrongSelf(self)
        [self loadOrderListRefresh:NO];
    }];
    mj_footer.automaticallyChangeAlpha = YES;
    tableView.mj_footer = mj_footer;
    [tableView.mj_header beginRefreshing];
    
    self.timer = [YYTimer timerWithTimeInterval:1 target:self selector:@selector(countDown) repeats:YES];
}

- (void)loadOrderListRefresh:(BOOL)refresh{
    self.page = refresh?1:self.page+1;
    NSDictionary *parameter = @{@"page":@(self.page),
                                @"pagecount":@(PAGECOUNT)};
    [Request startWithName:@"QUERY_FS_ORDER_LIST" param:parameter progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [self loadOrderListSuccess:[FlashServiceOrderListModel modelWithDictionary:dic] refresh:refresh];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self loadOrderListFailure:error];
    }];
}

- (void)loadOrderListSuccess:(FlashServiceOrderListModel *)model refresh:(BOOL)refresh{
    if (refresh) {
        self.ary = [NSMutableArray arrayWithArray:model.data];
    }else{
        [self.ary addObjectsFromArray:model.data];
    }
    [self deailWithInterface];
    if (model.data.count<PAGECOUNT) [_tableView.mj_footer endRefreshingWithNoMoreData];
}

- (void)loadOrderListFailure:(NSError *)error {
    [self deailWithInterface];
}

- (void)deailWithInterface {
    [_tableView.mj_header endRefreshing];
    [_tableView.mj_footer endRefreshing];
    if (self.ary.count==0) {
        _tableView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.tableView.frame.size.height) image:nil description:@"啥都木有啊···" needGoHome:YES];
    }else _tableView.backgroundView = nil;
    [_tableView reloadData];
}

- (void)countDown{
    [NotificationCenter postNotificationName:FlashServiceOrderListCellCountDownNoti object:nil];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.ary.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section==0?8:0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 8;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FlashServiceOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.item = self.ary[indexPath.section];
    cell.delegate = self;
    return cell;
}

-  (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    FlashServiceOrderListItem *item = self.ary[indexPath.section];
    FlashServiceOrderDetailViewController *controller = [[FlashServiceOrderDetailViewController alloc] init];
    controller.orderId = item.orderId;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - FlashServiceOrderListCellDelegate

- (void)flashServiceOrderListCell:(FlashServiceOrderListCell *)cell actionType:(FlashServiceOrderListCellActionType)type {
    switch (type) {
        case FlashServiceOrderListCellActionTypeProductDetail:
        {
            FlashDetailViewController *controller = [[FlashDetailViewController alloc]init];
            controller.pid = cell.item.fsSysNo;
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case FlashServiceOrderListCellActionTypeLinkAction:
        {
            FDDataStatus status = cell.item.status;
            switch (status) {
                    /**
                     *  等待预付 | 开团成功（已预付，待付尾款）跳转支付页
                     */
                case FDDataStatus_WaitPrePaid:
                case FDDataStatus_FlashSuccessWaitPay:
                {
                    [self gotoCashierDesk:cell.item];//预付，待付尾款
                }
                    break;
                    /**
                     *  立付尾款，开团成功（已预付，没有进入确认页确认）,跳转结算页
                     */
                case FDDataStatus_FlashSuccessUnPay:
                {
                    [self getOrderConfirm:cell.item];//获取订单信息
                }
                    break;
                    
                    /**
                     *  已购买，去评价
                     */
                case FDDataStatus_WaitEvalute:
                {
                    [self gotoComment:cell.item];
                }
                    break;
                default:break;
            }
        }
            break;
        case FlashServiceOrderListCellActionTypeReload:
        {
            [self loadOrderListRefresh:YES];
        }
            break;
    }
}

#pragma mark ================跳转收银台================

- (void)gotoCashierDesk:(FlashServiceOrderListItem *)item{
    CashierDeskViewController *controller = [[CashierDeskViewController alloc] initWithNibName:@"CashierDeskViewController" bundle:nil];
    controller.orderId = item.orderId;
    controller.orderKind = CashierDeskOrderKindFlash;
    controller.resultBlock = ^void (BOOL needRefresh){
        [self loadOrderListRefresh:YES];
    };
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark 获取订单信息

- (void)getOrderConfirm:(FlashServiceOrderListItem *)item{
    FlashBalanceSettlementViewController *controller = [[FlashBalanceSettlementViewController alloc]init];
    controller.orderId = item.orderId;
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark =================去评价==================

- (void)gotoComment:(FlashServiceOrderListItem *)item{
    CommentFoundingModel *model = [CommentFoundingModel modelFromFlashServiceOrderListItem:item];
    CommentFoundingViewController *controller = [[CommentFoundingViewController alloc] initWithCommentFoundingModel:model];
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark CommentFoundingViewControllerDelegate

- (void)commentFoundingViewControllerDidFinishSubmitComment:(CommentFoundingViewController *)vc {
    [self loadOrderListRefresh:YES];
}

@end
