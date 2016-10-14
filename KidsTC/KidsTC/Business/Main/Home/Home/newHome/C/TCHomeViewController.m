//
//  TCHomeViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeViewController.h"
#import "GHeader.h"
#import "SegueMaster.h"
#import "UIBarButtonItem+Category.h"
#import "HomeRoleButton.h"
#import "HomeRefreshHeader.h"



#import "GuideManager.h"
#import "PosterManager.h"
#import "HomeActivityManager.h"
#import "SearchHotKeywordsManager.h"

#import "TCHomeModel.h"
#import "TCHomeRecommendModel.h"
#import "TCHomeBaseTableViewCell.h"

#import "SpeekViewController.h"
#import "SearchTableViewController.h"
#import "CategoryViewController.h"

static NSUInteger const pageCount = 10;

static NSString *const kTCHomeBaseTableViewCellID = @"TCHomeBaseTableViewCell";

@interface TCHomeViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,TCHomeBaseTableViewCellDelegate>
@property (nonatomic, strong) HomeRoleButton *roleBtn;
@property (nonatomic, weak) UITextField *tf;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<TCHomeFloor *> *floors;
@property (nonatomic, strong) UIImageView *iv_activity;//活动图片
@property (nonatomic, assign) NSUInteger page;

@end

@implementation TCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [NotificationCenter addObserver:self selector:@selector(posterViewControllerFinishShow) name:kPosterViewControllerFinishShow object:nil];
    [NotificationCenter addObserver:self selector:@selector(updateIv_activity) name:kHomeActivityUpdateNoti object:nil];
    [NotificationCenter addObserver:self selector:@selector(roleHasChanged) name:kRoleHasChangedNotification object:nil];
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.tf.placeholder = self.placeholder;
    [self updateIv_activity];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self checkGuide];
}

- (void)setupUI {
    
    UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 400, 30)];
    tf.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
    tf.font = [UIFont systemFontOfSize:15];
    tf.borderStyle = UITextBorderStyleNone;
    tf.layer.cornerRadius = 4;
    tf.layer.masksToBounds = YES;
    tf.delegate = self;
    UIButton *leftBtn = [UIButton new];
    leftBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [leftBtn setImage:[UIImage imageNamed:@"home_search"] forState:UIControlStateNormal];
    leftBtn.bounds = CGRectMake(0, 0, 30, 30);
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    tf.leftView = leftBtn;
    tf.leftViewMode = UITextFieldViewModeAlways;
    UIButton *rightBtn = [UIButton new];
    rightBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [rightBtn setImage:[UIImage imageNamed:@"home_siri"] forState:UIControlStateNormal];
    rightBtn.bounds = CGRectMake(0, 0, 30, 30);
    [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [rightBtn addTarget:self action:@selector(speek) forControlEvents:UIControlEventTouchUpInside];
    tf.rightView = rightBtn;
    tf.rightViewMode = UITextFieldViewModeAlways;
    self.navigationItem.titleView = tf;
    self.tf = tf;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImagePostion:UIBarButtonPositionLeft target:self action:@selector(showScan) andGetButton:^(UIButton *btn) {
        btn.bounds = CGRectMake(0, 0, 29, 32);
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [btn setImage:[UIImage imageNamed:@"home_scan"] forState:UIControlStateNormal];
    }];
    self.roleBtn = [HomeRoleButton btnWithImageName:@"arrow_d_mini" highImageName:@"arrow_d_mini" target:self action:@selector(changeRole)];
    [self.roleBtn setTitle:[User shareUser].role.statusName forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.roleBtn];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    [tableView registerClass:[TCHomeBaseTableViewCell class] forCellReuseIdentifier:kTCHomeBaseTableViewCellID];
    self.tableView = tableView;
    
    [self setRefreshUnit];
}

- (void)setRefreshUnit{
    WeakSelf(self)
    HomeRefreshHeader *mj_header = [HomeRefreshHeader headerWithRefreshingBlock:^{
        StrongSelf(self)
        [self getDataRefresh:YES roleHasChange:NO];
    }];
    mj_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_header = mj_header;
    
    RefreshFooter *mj_footer = [RefreshFooter footerWithRefreshingBlock:^{
        StrongSelf(self)
        [self getDataRefresh:NO roleHasChange:NO];
    }];
    mj_footer.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer = mj_footer;
    
    mj_footer.automaticallyRefresh = YES;
    mj_footer.triggerAutomaticallyRefreshPercent = -4.0;
    
    [mj_header beginRefreshing];
}

- (void)posterViewControllerFinishShow{
    [self checkGuide];
}

- (void)updateIv_activity{
    HomeActivityDataItem *data = [HomeActivityManager shareHomeActivityManager].data;
    self.iv_activity.hidden = !data.imageCanShow;
    if (!self.iv_activity.hidden) {
        TCLog(@"iv_activity-[NSThread currentThread]--:%@--data.thumbImg:--:%@",[NSThread currentThread],data.thumbImg);
        [self.iv_activity sd_setImageWithURL:[NSURL URLWithString:data.thumbImg] placeholderImage:PLACEHOLDERIMAGE_SMALL_LOG];
    }
    //self.floorView.hidden = !self.iv_activity.hidden;
}

- (void)checkGuide{
    if (self.navigationController.viewControllers.count==1 &&
        [PosterManager sharePosterManager].hasShow &&
        !self.presentingViewController)
    {
        [[GuideManager shareGuideManager] checkGuideWithTarget:self type:GuideTypeHome resultBlock:^{
            TCLog(@"checkGuideWithTarget---finish!!!");
            [[HomeActivityManager shareHomeActivityManager] checkAcitvityWithTarget:self resultBlock:^{
                TCLog(@"checkAcitvityWithTarget---finish!!!");
            }];
        }];
    }
}

- (void)showScan{
//    CategoryViewController *controller = [[CategoryViewController alloc]init];
//    [self.navigationController pushViewController:controller animated:YES];
    UIStoryboard *qrCodeStoryboard = [UIStoryboard storyboardWithName:@"QRCode" bundle:nil];
    [self.navigationController pushViewController:qrCodeStoryboard.instantiateInitialViewController animated:YES];
}

- (void)changeRole{
    RoleSelectViewController *controller = [[RoleSelectViewController alloc]initWithNibName:@"RoleSelectViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)roleHasChanged{
    [self.roleBtn setTitle:[User shareUser].role.statusName forState:UIControlStateNormal];
    [self getDataRefresh:YES roleHasChange:YES];
}

- (void)speek {
    SpeekViewController *controller = [[SpeekViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)getDataRefresh:(BOOL)refresh roleHasChange:(BOOL)roleHasChange {
    NSString *type = [User shareUser].role.roleIdentifierString;
    dispatch_group_t group =  dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    __block NSMutableArray<TCHomeFloor *> *mainFloors = [NSMutableArray array];
    dispatch_group_async(group, queue, ^{
        TCLog(@"AddTab两张图片--11--%@",[NSThread currentThread]);
        NSDictionary *param = @{@"type":@"13",
                                @"category":@""};
        [Request startSyncName:@"GET_PAGE_HOME_NEW_V2" param:param success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
            TCHomeModel *model = [TCHomeModel modelWithDictionary:dic];
            [mainFloors addObjectsFromArray:model.data.sections];
        } failure:nil];
    });
    __block NSMutableArray<TCHomeFloor *> *recommendFloors = [NSMutableArray array];
    dispatch_group_async(group, queue, ^{
        TCLog(@"AddTab两张图片--22--%@",[NSThread currentThread]);
        NSDictionary *param = @{@"populationType":@"13",
                                @"page":@(self.page),
                                @"pageCount":@(pageCount)};
        [Request startSyncName:@"GET_PAGE_RECOMMEND_NEW_PRODUCE" param:param success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
            TCHomeRecommendModel *model = [TCHomeRecommendModel modelWithDictionary:dic];
            [recommendFloors addObjectsFromArray:model.floors];
        } failure:nil];
    });
    dispatch_group_notify(group, queue, ^{
        TCLog(@"AddTab两张图片--33--%@",[NSThread currentThread]);
        NSMutableArray<TCHomeFloor *> *allFloors = [NSMutableArray array];
        [allFloors addObjectsFromArray:mainFloors];
        [allFloors addObjectsFromArray:recommendFloors];
        self.floors = [NSArray arrayWithArray:allFloors];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
            [self dealWitMJ];
        });
    });
}

- (void)dealWitMJ {
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.floors.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section<self.floors.count) {
        return self.floors[indexPath.section].floorHeight;
    }else{
        return 100;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section<self.floors.count) {
        return self.floors[section].marginTop;
    }else{
        return 12;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TCHomeBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTCHomeBaseTableViewCellID];
    cell.delegate = self;
    if (indexPath.section<self.floors.count) {
        cell.floor = self.floors[indexPath.section];
    }
    return cell;
}

#pragma mark - TCHomeBaseTableViewCellDelegate

- (void)tcHomeBaseTableViewCell:(TCHomeBaseTableViewCell *)cell actionType:(TCHomeBaseTableViewCellActionType)type value:(id)value {
    switch (type) {
        case TCHomeBaseTableViewCellActionTypeSegue:
        {
            [SegueMaster makeSegueWithModel:value fromController:self];
        }
            break;
    }
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    SearchTableViewController *controller = [[SearchTableViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
    return NO;
}

#pragma mark - placeHolder

- (NSString *)placeholder {
    __block NSString *placeholder = nil;
    SearchHotKeywordsData *data = [SearchHotKeywordsManager shareSearchHotKeywordsManager].model.data;
    if (placeholder.length==0) {
        [data.product enumerateObjectsUsingBlock:^(SearchHotKeywordsListItem *obj,
                                                   NSUInteger idx,
                                                   BOOL *stop) {
            if (obj.name.length>0) {
                placeholder = obj.name;
                *stop = YES;
            }
        }];
    }
    if (placeholder.length == 0) {
        [data.store enumerateObjectsUsingBlock:^(SearchHotKeywordsListItem *obj,
                                                 NSUInteger idx,
                                                 BOOL *stop) {
            if (obj.name.length>0) {
                placeholder = obj.name;
                *stop = YES;
            }
        }];
    }
    if (placeholder.length == 0) {
        [data.article enumerateObjectsUsingBlock:^(SearchHotKeywordsListItem *obj,
                                                   NSUInteger idx,
                                                   BOOL *stop) {
            if (obj.name.length>0) {
                placeholder = obj.name;
                *stop = YES;
            }
        }];
    }
    if (placeholder.length == 0) {
        placeholder = @"宝爸宝妈都在搜";
    }
    placeholder = [NSString stringWithFormat:@"  %@",placeholder];
    return placeholder;
}

#pragma mark - dealloc

- (void)dealloc {
    [NotificationCenter removeObserver:self name:kPosterViewControllerFinishShow object:nil];
    [NotificationCenter removeObserver:self name:kHomeActivityUpdateNoti object:nil];
    [NotificationCenter removeObserver:self name:kRoleHasChangedNotification object:nil];
}

@end
