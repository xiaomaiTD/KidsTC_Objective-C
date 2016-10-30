//
//  NotificationCenterViewController.m
//  KidsTC
//
//  Created by zhanping on 7/26/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "NotificationCenterViewController.h"
#import "RefreshHeader.h"
#import "RefreshFooter.h"
#import "GHeader.h"
#import "NotificationCenterModel.h"
#import "NotificationCenterViewCell.h"
#import "UIBarButtonItem+Category.h"
#import "SegueMaster.h"
#import "KTCEmptyDataView.h"
#import "TabBarController.h"

#define pageCount 10
@interface NotificationCenterViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<NotificationCenterItem *> *ary;
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, weak) UIButton *rightBarButton;
@end
static NSString *const NotificationCenterViewCellID = @"NotificationCenterViewCellID";
@implementation NotificationCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageId = 10902;
    
    self.navigationItem.title = @"消息中心";
    self.navigationItem.rightBarButtonItem =
    [UIBarButtonItem itemWithTitle:@"一键已读"
                           postion:UIBarButtonPositionRight
                            target:self
                            action:@selector(rightBarButtonItemClick)
                      andGetButton:^(UIButton *btn) {
                          btn.hidden = YES;
                          self.rightBarButton = btn;
                      }];
    [self initTableView];
}

- (void)rightBarButtonItemClick{
    [TCProgressHUD showSVP];
    [Request startWithName:@"PUSH_USER_READ_MESSAGE_ALL" param:nil progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [TCProgressHUD dismissSVP];
        [iToast makeText:@"已全部置为已读"];
        [self.tableView.mj_header beginRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [TCProgressHUD dismissSVP];
        [iToast makeText:@"一键已读失败"];
    }];
}

- (void)initTableView{
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerNib:[UINib nibWithNibName:@"NotificationCenterViewCell" bundle:nil] forCellReuseIdentifier:NotificationCenterViewCellID];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    WeakSelf(self)
    RefreshHeader *mj_header = [RefreshHeader headerWithRefreshingBlock:^{
        StrongSelf(self)
        [self getDataRefresh:YES];
    }];
    mj_header.automaticallyChangeAlpha = YES;
    tableView.mj_header = mj_header;
    
    RefreshFooter *mj_footer = [RefreshFooter footerWithRefreshingBlock:^{
        StrongSelf(self)
        [self getDataRefresh:NO];
    }];
    mj_footer.automaticallyChangeAlpha = YES;
    tableView.mj_footer = mj_footer;
    
    [mj_header beginRefreshing];
}

- (void)getDataRefresh:(BOOL)refresh{
    
    if (refresh) {
        self.page = 1;
    }else{
        self.page ++;
    }
    NSDictionary *param = @{@"page":@(self.page),
                            @"pageCount":@(pageCount)};
    [Request startWithName:@"PUSH_SEARCH_USER_MESSAGE" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        NotificationCenterModel *model = [NotificationCenterModel modelWithDictionary:dic];
        [self loadDataSuccessRefresh:refresh model:model];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self loadDataFailure];
    }];
}

- (void)loadDataSuccessRefresh:(BOOL)refresh model:(NotificationCenterModel *)model{
    
    
    if (refresh) {
        self.ary = [NSMutableArray arrayWithArray:model.data];
    }else{
        [self.ary addObjectsFromArray:model.data];
    }
    [self dealWithLoadResult];
    if (model.data.count<pageCount) [self.tableView.mj_footer endRefreshingWithNoMoreData];
    
}

- (void)loadDataFailure{
    [self dealWithLoadResult];
    [self.tableView.mj_footer endRefreshingWithNoMoreData];
}

- (void)dealWithLoadResult{
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    if (self.ary.count==0) {
        _tableView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.tableView.frame.size.height) image:nil description:@"啥都木有啊···" needGoHome:YES];
    }else _tableView.backgroundView = nil;
    [_tableView reloadData];
    self.rightBarButton.hidden = !(self.ary.count>0);
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ary.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.ary[indexPath.row].cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NotificationCenterViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NotificationCenterViewCellID];
    cell.item = self.ary[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NotificationCenterItem *item = self.ary[indexPath.row];
    if (item.isCanOpenHome) {
        [[TabBarController shareTabBarController] selectIndex:0];
    }else if (item.segueModel){
        [SegueMaster makeSegueWithModel:item.segueModel fromController:self];
    }
}


@end
