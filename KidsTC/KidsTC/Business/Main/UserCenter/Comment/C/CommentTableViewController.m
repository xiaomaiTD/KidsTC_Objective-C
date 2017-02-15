//
//  CommentTableViewController.m
//  KidsTC
//
//  Created by zhanping on 3/14/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "CommentTableViewController.h"
#import "MyCommentListItemModel.h"
#import "MyCommentListViewCell.h"
#import "MWPhotoBrowser.h"
#import "CommentEditViewController.h"
#import "TCStoreDetailViewController.h"
#import "ParentingStrategyDetailViewController.h"
#import "ProductDetailViewController.h"
#import "CashierDeskViewController.h"
#import "CommentFoundingViewController.h"
#import "OrderRefundViewController.h"
#import "SegueMaster.h"
#import "OrderListViewCell.h"
#import "OrderListModel.h"
#import "ProductOrderNormalDetailViewController.h"
#import "ProductOrderTicketDetailViewController.h"
#import "ProductOrderFreeDetailViewController.h"

#import "GHeader.h"
#import "KTCEmptyDataView.h"

static NSString *const waitToCommentCellIdentifier = @"OrderListViewCellCellIdentifier";
static NSString *const myCommentListCellIdentifier = @"myCommentListCellIdentifier";

@interface CommentTableViewController ()<UITableViewDelegate,UITableViewDataSource,MyCommentListViewCellDelegate,CommentEditViewControllerDelegate,OrderListCellDelegate,CommentFoundingViewControllerDelegate,OrderRefundViewControllerDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISegmentedControl *segmentControl;

@property (nonatomic, assign) NSUInteger myCommentListCurrentPageIndex;
@property (nonatomic, strong) NSMutableArray *myCommentListAry;
@property (nonatomic, strong) MWPhotoBrowser *photoBrowser;
@property (nonatomic, strong) KTCCommentManager *commentManager;

@property (nonatomic, assign) NSUInteger waitToCommentCurrentPageIndex;
@property (nonatomic, strong) NSMutableArray *waitToCommentListAry;

@end

@implementation CommentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageId = 10914;
    
    self.myCommentListAry = [NSMutableArray new];
    self.waitToCommentListAry = [NSMutableArray new];
    
    //初始化界面
    [self initUI];
    
    //[self loadNewData];
    //点按segmentControl
    [self segmentControlDidChangedSelectedIndex:self.segmentControl];
}

- (void)initUI{
    
    self.segmentControl = [[UISegmentedControl alloc]initWithItems:@[@" 待评价 ",@"我的评价"]];
    [self.segmentControl addTarget:self action:@selector(segmentControlDidChangedSelectedIndex:) forControlEvents:UIControlEventValueChanged];
    
    [self.segmentControl setTintColor:[UIColor whiteColor]];
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:15],NSFontAttributeName,[UIColor whiteColor], NSForegroundColorAttributeName, nil];
    [self.segmentControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:COLOR_PINK forKey:NSForegroundColorAttributeName];
    [self.segmentControl setTitleTextAttributes:highlightedAttributes forState:UIControlStateSelected];
    self.navigationItem.titleView = self.segmentControl;
    
    if (self.isHaveWaitToComment) {//有待评价的
        [self.segmentControl setSelectedSegmentIndex:0];
    }else{
        [self.segmentControl setSelectedSegmentIndex:1];
    }
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    WeakSelf(self)
    RefreshHeader *mj_header = [RefreshHeader headerWithRefreshingBlock:^{
        StrongSelf(self)
        [self loadDataForNew:YES];
    }];
    mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_header = mj_header;
    
    RefreshFooter *mj_footer = [RefreshFooter footerWithRefreshingBlock:^{
        StrongSelf(self)
        [self loadDataForNew:NO];
    }];
    mj_footer.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer = mj_footer;
    
    [mj_header beginRefreshing];
    
}

static NSUInteger pageSize = 10;

- (void)loadDataForNew:(BOOL)new{
    
    if (self.segmentControl.selectedSegmentIndex == 0) {//待评价
        
        if (new) {
            self.waitToCommentCurrentPageIndex = 1;
        }else{
            self.waitToCommentCurrentPageIndex ++;
        }
        
        NSDictionary *waitToCommentParam = [NSDictionary dictionaryWithObjectsAndKeys:
                                            [NSNumber numberWithInteger:OrderListTypeWaitingComment], @"type",
                                            [NSNumber numberWithInteger:self.waitToCommentCurrentPageIndex], @"page",
                                            [NSNumber numberWithInteger:pageSize], @"pagecount", nil];
        [Request startWithName:@"ORDER_SEARCH_ORDER" param:waitToCommentParam progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
            if (new) {
                [self.waitToCommentListAry removeAllObjects];
            }
            
            
            
            if ([dic count] > 0) {
                NSArray *dataArray = [dic objectForKey:@"data"];
                if ([dataArray isKindOfClass:[NSArray class]] && [dataArray count] > 0) {
                    [self.tableView.mj_footer setHidden:NO];
                    
                    for (NSDictionary *singleOrder in dataArray) {
                        OrderListModel *model = [[OrderListModel alloc] initWithRawData:singleOrder];
                        if (model) {
                            [self.waitToCommentListAry addObject:model];
                        }
                    }
                    if ([dataArray count] < 1) {
                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    } else{
                        [self.tableView.mj_footer endRefreshing];
                    }
                } else {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    [self.tableView.mj_footer setHidden:YES];
                    
                }
            } else {
                [self.tableView.mj_footer setHidden:YES];
            }
            
            [self endRefreshing];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (new) {
                [self.waitToCommentListAry removeAllObjects];
            }
            
            [self endRefreshing];
        }];
        
    }else{//我的评价
        
        if (new) {
            self.myCommentListCurrentPageIndex = 1;
        }else{
            self.myCommentListCurrentPageIndex ++;
        }
        
        NSDictionary *myCommentListParam = [NSDictionary dictionaryWithObjectsAndKeys:
                                            [NSNumber numberWithInteger:self.myCommentListCurrentPageIndex], @"page",
                                            [NSNumber numberWithInteger:pageSize], @"pageCount", nil];
        [Request startWithName:@"COMMENT_GET_BY_USER" param:myCommentListParam progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
            if (new) {
                [self.myCommentListAry removeAllObjects];
            }
            
            
            if ([dic count] > 0) {
                NSArray *dataArray = [dic objectForKey:@"data"];
                if ([dataArray isKindOfClass:[NSArray class]] && [dataArray count] > 0) {
                    [self.tableView.mj_footer setHidden:NO];
                    for (NSDictionary *singleItem in dataArray) {
                        MyCommentListItemModel *model = [[MyCommentListItemModel alloc] initWithRawData:singleItem];
                        if (model) {
                            [self.myCommentListAry addObject:model];
                        }
                    }
                    if ([dataArray count] < 1) {
                        
                        [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    } else{
                        [self.tableView.mj_footer endRefreshing];
                    }
                } else {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    [self.tableView.mj_footer setHidden:YES];
                }
            }else{
                [self.tableView.mj_footer setHidden:YES];
            }
            
            
            [self endRefreshing];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            if (new) {
                [self.myCommentListAry removeAllObjects];
            }
            
            [self endRefreshing];
        }];
    }
}

- (void)endRefreshing{
    
    if (self.segmentControl.selectedSegmentIndex == 0) {//待评价
        if (self.waitToCommentListAry.count == 0) {
            
            self.tableView.backgroundView = [[KTCEmptyDataView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.tableView.frame.size.height) image:nil description:@"啥都木有啊···" needGoHome:YES];
        }else{
            self.tableView.backgroundView = nil;
        }
    }else{//我的评价
        if (self.myCommentListAry.count == 0) {
            self.tableView.backgroundView = [[KTCEmptyDataView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.tableView.frame.size.height) image:nil description:@"啥都木有啊···" needGoHome:YES];
        }else{
            self.tableView.backgroundView = nil;
        }
    }
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
}

- (void)segmentControlDidChangedSelectedIndex:(UISegmentedControl *)segmentControl{
    
    
    if (self.segmentControl.selectedSegmentIndex == 0) {//待评价
        
        if (self.waitToCommentListAry.count == 0) {
            [self loadDataForNew:YES];
        }else{
            self.tableView.backgroundView = nil;
            [self.tableView reloadData];
        }
        
    }else{//我的评价
        if (self.myCommentListAry.count == 0) {
            [self loadDataForNew:YES];
        }else{
            self.tableView.backgroundView = nil;
            [self.tableView reloadData];
        }
    }
    
   
}


#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.segmentControl.selectedSegmentIndex == 0) {//待评价
        TCLog(@"self.waitToCommentListAry.count:%zd",self.waitToCommentListAry.count);
        return self.waitToCommentListAry.count;
    }else{//我的评价
        return self.myCommentListAry.count;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (self.segmentControl.selectedSegmentIndex == 0) {//待评价
        return 2.5;
    }else{//我的评价
        return 2.5;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (self.segmentControl.selectedSegmentIndex == 0) {//待评价
        return 2.5;
    }else{//我的评价
        return 2.5;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.segmentControl.selectedSegmentIndex == 0) {//待评价
        
        OrderListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:waitToCommentCellIdentifier];
        if (!cell) {
            cell =  [[[NSBundle mainBundle] loadNibNamed:@"OrderListViewCell" owner:self options:nil] objectAtIndex:0];
        }
        [cell configWithOrderListModel:self.waitToCommentListAry[indexPath.section] atIndexPath:indexPath];
        cell.delegate = self;
        
        return cell;
        
    }else{//我的评价
        MyCommentListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCommentListCellIdentifier];
        if (!cell) {
            cell =  [[[NSBundle mainBundle] loadNibNamed:@"MyCommentListViewCell" owner:self options:nil] objectAtIndex:0];
        }
        cell.indexPath = indexPath;
        cell.delegate = self;
        [cell configWithItemModel:[self.myCommentListAry objectAtIndex:indexPath.section]];
        return cell;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.segmentControl.selectedSegmentIndex == 0) {//待评价
        OrderListModel *model = self.waitToCommentListAry[indexPath.section];
        return [model cellHeight];
    }else{//我的评价
        MyCommentListItemModel *model = [self.myCommentListAry objectAtIndex:indexPath.section];
        return [model cellHeight];
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.segmentControl.selectedSegmentIndex == 0) {//待评价
        OrderListModel *model = self.waitToCommentListAry[indexPath.section];
        switch (model.orderKind) {
            case OrderKindNormal:
            {
                ProductOrderNormalDetailViewController *controller = [[ProductOrderNormalDetailViewController alloc] init];
                controller.orderId = model.orderId;
                [self.navigationController pushViewController:controller animated:YES];
            }
                break;
            case OrderKindTicket:
            {
                ProductOrderTicketDetailViewController *controller = [[ProductOrderTicketDetailViewController alloc] init];
                controller.orderId = model.orderId;
                [self.navigationController pushViewController:controller animated:YES];
            }
                break;
            case OrderKindFree:
            {
                ProductOrderFreeDetailViewController *controller = [[ProductOrderFreeDetailViewController alloc] init];
                controller.orderId = model.orderId;
                [self.navigationController pushViewController:controller animated:YES];
            }
                break;
            default:
                break;
        }
    }else{//我的评价
        MyCommentListItemModel *model = [self.myCommentListAry objectAtIndex:indexPath.section];
        switch (model.relationType) {
            case CommentRelationTypeNews:
            {
                if ([model.linkUrl length] > 0) {
                    SegueModel *segue = [SegueModel modelWithDestination:(SegueDestination)model.linkType paramRawData:model.params];
                    [SegueMaster makeSegueWithModel:segue fromController:self];
                }
                return;
            }
                break;
            case CommentRelationTypeStore:
            {
                if ([model.relationIdentifier length] > 0) {
                    TCStoreDetailViewController *controller = [[TCStoreDetailViewController alloc] init];
                    controller.storeId = model.relationIdentifier;

                    [self.navigationController pushViewController:controller animated:YES];
                }
                return;
            }
                break;
            case CommentRelationTypeStrategy:
            {
                if ([model.relationIdentifier length] > 0) {
                    ParentingStrategyDetailViewController *controller = [[ParentingStrategyDetailViewController alloc] initWithStrategyIdentifier:model.relationIdentifier];
                    [self.navigationController pushViewController:controller animated:YES];
                }
                return;
            }
                break;
            case CommentRelationTypeStrategyDetail:
            {
                if ([model.strategyIdentifier length] > 0) {
                    ParentingStrategyDetailViewController *controller = [[ParentingStrategyDetailViewController alloc] initWithStrategyIdentifier:model.strategyIdentifier];
                    [self.navigationController pushViewController:controller animated:YES];
                }
                return;
            }
                break;
            default:
            {
                if ([model.relationIdentifier length] > 0) {
                    ProductDetailViewController *controller = [[ProductDetailViewController alloc] initWithServiceId:model.relationIdentifier channelId:@"0"];
                    controller.type = model.productRedirect;
                    [self.navigationController pushViewController:controller animated:YES];
                }
                return;
            }
                break;
        }
    }
    
    
}

#pragma mark - 待评价

#pragma mark OrderListCellDelegate
- (void)didClickedPayButtonOnOrderListViewCell:(OrderListViewCell *)cell {
    OrderListModel *model = [self.waitToCommentListAry objectAtIndex:cell.indexPath.section];
    
    CashierDeskViewController *controller = [[CashierDeskViewController alloc]initWithNibName:@"CashierDeskViewController" bundle:nil];
    controller.orderId = model.orderId;
    switch (model.orderKind) {
        case OrderKindTicket:
        {
            controller.productType = ProductDetailTypeTicket;
        }
            break;
        case OrderKindFree:
        {
            controller.productType = ProductDetailTypeFree;
        }
            break;
        default:
        {
            controller.productType = ProductDetailTypeNormal;
        }
            break;
    }
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didClickedCommentButtonOnOrderListViewCell:(OrderListViewCell *)cell {
    OrderListModel *model = [self.waitToCommentListAry objectAtIndex:cell.indexPath.section];
    CommentFoundingViewController *controller = [[CommentFoundingViewController alloc] initWithCommentFoundingModel:[CommentFoundingModel modelFromServiceOrderModel:model]];
    controller.delegate = self;
    [controller setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)didClickedReturnButtonOnOrderListViewCell:(OrderListViewCell *)cell {
    OrderListModel *model = [self.waitToCommentListAry objectAtIndex:cell.indexPath.section];
    OrderRefundViewController *controller = [[OrderRefundViewController alloc] initWithOrderId:model.orderId];
    controller.delegate = self;
    [controller setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark OrderRefundViewControllerDelegate

- (void)orderRefundViewController:(OrderRefundViewController *)vc didSucceedWithRefundForOrderId:(NSString *)identifier {
    [self loadDataForNew:YES];
}

#pragma mark CommentFoundingViewControllerDelegate
- (void)commentFoundingViewControllerDidFinishSubmitComment:(CommentFoundingViewController *)vc{
    [self loadDataForNew:YES];
}
#pragma mark ServiceOrderDetailViewControllerDelegate

- (void)serviceOrderDetailStateChanged:(NSString *)orderId needRefresh:(BOOL)needRefresh{
    [self loadDataForNew:YES];
}
#pragma mark - 我的评价

#pragma mark MyCommentListViewCellDelegate

- (void)myCommentListViewCell:(MyCommentListViewCell *)cell didClickedImageAtIndex:(NSInteger)index {

    MyCommentListItemModel *model = [self.myCommentListAry objectAtIndex:cell.indexPath.section];
    self.photoBrowser = [[MWPhotoBrowser alloc] initWithPhotos:model.photosArray];
    [self.photoBrowser setCurrentPhotoIndex:index];
    [self presentViewController:self.photoBrowser animated:YES completion:nil];

}
- (void)didClickedEditButton:(MyCommentListViewCell *)cell {
    
    MyCommentListItemModel *model = [self.myCommentListAry objectAtIndex:cell.indexPath.section];
    CommentEditViewController *controller = [[CommentEditViewController alloc] initWithMyCommentItem:model];
    controller.delegate = self;
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)didClickedDeleteButton:(MyCommentListViewCell *)cell {
    
    
    MyCommentListItemModel *model = [self.myCommentListAry objectAtIndex:cell.indexPath.section];
    if (!self.commentManager) {
        self.commentManager = [[KTCCommentManager alloc] init];
    }
    
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定要删除这条评论么？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [TCProgressHUD showSVP];
        [self.commentManager deleteUserCommentWithRelationIdentifier:model.relationIdentifier commentIdentifier:model.commentIdentifier relationType:model.relationType succeed:^(NSDictionary *data) {
            [TCProgressHUD dismissSVP];
            [self loadDataForNew:YES];
        } failure:^(NSError *error) {
            [TCProgressHUD dismissSVP];
            NSString *errMsg = @"";
            if (error.userInfo) {
                errMsg = [error.userInfo objectForKey:@"data"];
            }
            if ([errMsg length] == 0) {
                errMsg = @"删除失败";
            }
            [[iToast makeText:errMsg] show];
        }];
    }];
    [controller addAction:cancelAction];
    [controller addAction:confirmAction];
    [self presentViewController:controller animated:YES completion:nil];

}

#pragma mark CommentEditViewControllerDelegate


- (void)commentEditViewControllerDidFinishSubmitComment:(CommentEditViewController *)vc {
    [self loadDataForNew:YES];
}

@end
