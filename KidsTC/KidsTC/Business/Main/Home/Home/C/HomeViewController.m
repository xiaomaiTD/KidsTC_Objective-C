//
//  HomeViewController.m
//  KidsTC
//
//  Created by 詹平 on 16/7/17.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "HomeViewController.h"
#import "UIBarButtonItem+Category.h"
#import "UILabel+Additions.h"
#import "SearchTableViewController.h"
#import "CategoryViewController.h"
#import "SearchHotKeywordsManager.h"
#import "GHeader.h"
#import "HomeRefreshHeader.h"
#import "HomeDataManager.h"
#import "SegueMaster.h"
#import "HomeCountDownMoreTitleCell.h"
#import "HomeNewsCell.h"
#import "HomeBannerCell.h"
#import "HomeNoticeCell.h"
#import "HomeWholeImageNewsCell.h"
#import "HomeTwinklingCell.h"
#import "HomeThemeCell.h"
#import "HomeHorizontalListCell.h"
#import "HomeBigImageTwoDescCell.h"
#import "HomeTwoThreeFourCell.h"
#import "HomeThreeCell.h"
#import "HomeRecommendCell.h"
#import "AUIFloorNavigationView.h"
#import "HomeDataManager.h"
#import "Macro.h"
#import "Masonry.h"
#import "WelcomeManager.h"
#import "WebViewController.h"
#import "HomeRoleButton.h"
#import "KTCEmptyDataView.h"
#import "PosterManager.h"
#import "GuideManager.h"
#import "HomeActivityManager.h"
#import "HomeRefreshManager.h"


#define pageCount 10
#define ActivityViewAnimationDuration 0.5 //activityTView的动画时长
extern NSString * const GuideDidFinishNotificaton;
@interface HomeViewController ()<UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, AUIFloorNavigationViewDelegate, AUIFloorNavigationViewDataSource>

@property (nonatomic, weak) UITextField *tf;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HomeRoleButton *roleBtn;
@property (nonatomic, strong) UIButton *backToTop;//回到顶部按钮
@property (nonatomic, strong) AUIFloorNavigationView *floorView;//导航图
@property (nonatomic, strong) UIImageView *iv_activity;//活动图片
@property (nonatomic, strong) MASConstraint *iv_right;//活动图片右侧约束

@property (nonatomic, assign) BOOL canShowRefreshPage;
@end

static NSString *const kCountDownMoreTitleCellIdentifier = @"kCountDownMoreTitleCellIdentifier";
static NSString *const kBannerCellIdentifier = @"1";
static NSString *const kTwinklingElfCellIdentifier = @"2";
static NSString *const kHorizontalListCellIdentifier = @"3";
static NSString *const kThreeCellIdentifier = @"4";
static NSString *const kThemeCellIdentifier = @"5";
static NSString *const kNewsCellIdentifier = @"6";
static NSString *const kImageNewsCellIdentifier = @"7";
static NSString *const kThreeImageNewsCellIdentifier = @"8";
static NSString *const kWholeImageNewsCellIdentifier = @"11";
static NSString *const kNoticeCellIdentifier = @"12";
static NSString *const kBigImageTwoDescCellIdentifier = @"13";
static NSString *const kTwoThreeFourCellIdentifier = @"14";
static NSString *const kRecomendCellIdentifier = @"15";
@implementation HomeViewController

#pragma mark-
#pragma mark 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageId = @"pv_home";
    
    [self initui];
    [HomeDataManager shareHomeDataManager].targetVc = self;
    [NotificationCenter addObserver:self selector:@selector(posterViewControllerFinishShow) name:kPosterViewControllerFinishShow object:nil];
    [NotificationCenter addObserver:self selector:@selector(updateIv_activity) name:kHomeActivityUpdateNoti object:nil];
    [NotificationCenter addObserver:self selector:@selector(roleHasChanged) name:kRoleHasChangedNotification object:nil];
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
    self.floorView.hidden = !self.iv_activity.hidden;
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

- (void)initui{
    
    UITextField *tf = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 400, 30)];
    tf.backgroundColor = [UIColor colorWithWhite:1 alpha:0.9];
    tf.font = [UIFont systemFontOfSize:15];
    tf.borderStyle = UITextBorderStyleNone;
    tf.layer.cornerRadius = 4;
    tf.layer.masksToBounds = YES;
    tf.delegate = self;
    self.navigationItem.titleView = tf;
    self.tf = tf;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImageName:@"home_category" highImageName:@"home_category" postion:UIBarButtonPositionLeft target:self action:@selector(showCategory)];
    self.roleBtn = [HomeRoleButton btnWithImageName:@"arrow_d_mini" highImageName:@"arrow_d_mini" target:self action:@selector(changeRole)];
    [self.roleBtn setTitle:[User shareUser].role.statusName forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.roleBtn];
    
    [self prepareTableView];
    [self setBackToTopBtn];
    [self setFloorView];
    [self setActivityView];
}

- (void)showCategory{
    CategoryViewController *controller = [[CategoryViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}


- (void)changeRole{
    RoleSelectViewController *controller = [[RoleSelectViewController alloc]initWithNibName:@"RoleSelectViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)roleHasChanged{
    [self.roleBtn setTitle:[User shareUser].role.statusName forState:UIControlStateNormal];
    [self getDataRefresh:YES roleHasChange:YES];
}

//加载数据
- (void)getDataRefresh:(BOOL)refresh roleHasChange:(BOOL)roleHasChange {
    if (refresh) {//刷新
        [[HomeDataManager shareHomeDataManager] refreshHomeDataWithSucceed:^(NSDictionary *data) {
            [self loadDataSucceed];
            
        } failure:^(NSError *error) {
            [self dealHeaderFooter];
        }];
        if (self.canShowRefreshPage && !roleHasChange)[[HomeRefreshManager shareHomeActivityManager] checkHomeRefreshPageWithTarget:self resultBlock:nil];
        self.canShowRefreshPage = YES;
    }else{//加载更多
        
        [[HomeDataManager shareHomeDataManager] getCustomerRecommendWithSucceed:^(NSDictionary *data) {
            [self loadDataSucceed];
        } failure:^(NSError *error) {
            [self dealHeaderFooter];
        }];
    }
}

- (void)loadDataSucceed{
    [self.tableView reloadData];
    [self.floorView reloadData];
    [self.floorView setSelectedIndex:0];
    [self dealHeaderFooter];
    
}
- (void)dealHeaderFooter{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
    if ([HomeDataManager shareHomeDataManager].noMoreData) {
        //主页判断不再刷新用
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    
    if (![HomeDataManager shareHomeDataManager].dataArr.count) {
        KTCEmptyDataView *empty = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.tableView.frame.size.height) image:nil description:@"啥都木有啊···"];
        self.tableView.backgroundView = empty;
    }else self.tableView.backgroundView = nil;
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return [HomeDataManager shareHomeDataManager].dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *dataArr = [HomeDataManager shareHomeDataManager].dataArr;
    HomeFloorsItem *floor = dataArr[section];
    NSUInteger number = 1;
    if (!floor.contents.count) { //无内容 判断有无标题 有则显示
        number = floor.hasTitle ? 1 : 0;
    }else{//有内容
        if (floor.hasTitle) {//有标题 且内容不为空 再展示内容
            number = 2;
        }
        if (floor.contentType == HomeContentCellTypeNews || floor.contentType == HomeContentCellTypeImageNews) {
            number += floor.contents.count - 1;
        }
    }
    return number;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *dataArr = [HomeDataManager shareHomeDataManager].dataArr;
    HomeFloorsItem *floor;
    if (dataArr.count>indexPath.section) {
        floor = dataArr[indexPath.section];
    }
    NSInteger itemIndex = indexPath.row;
    
    if (floor.hasTitle) { //含标题
        if (itemIndex == 0) {
            //出列标题cell
            HomeBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:kCountDownMoreTitleCellIdentifier forIndexPath:indexPath];
            cell.floorsItem = floor;
            return cell;
        }else {//
            itemIndex = indexPath.row - 1;
        }
    }
    HomeContentCellType contentType = floor.contentType;//出列内容cell
    HomeBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%d",contentType]  forIndexPath:[NSIndexPath indexPathForItem:itemIndex inSection:indexPath.section]];
    
    if (!cell) return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    if(contentType == HomeContentCellTypeNews || contentType == HomeContentCellTypeImageNews || contentType == HomeContentCellTypeThreeImageNews) cell.index = itemIndex;
    cell.floorsItem = floor;
    cell.delegate = self;
    cell.sectionNo = indexPath.section;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height = 0;
    
    NSArray *dataArr = [HomeDataManager shareHomeDataManager].dataArr;
    
    HomeFloorsItem *floor = dataArr[indexPath.section];
    if (floor.hasTitle && indexPath.row == 0) {
        height = floor.titleHeight;
    } else if(floor.rowHeight){
        height = floor.rowHeight;
    }
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat height = 0.01;
    
    NSArray *dataArr = [HomeDataManager shareHomeDataManager].dataArr;
    HomeFloorsItem *floor = dataArr[section];
    if (floor.marginTop >= 1) {
        height = floor.marginTop;
    }
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    NSArray *dataArr = [HomeDataManager shareHomeDataManager].dataArr;
    HomeFloorsItem *floor = dataArr[section];
    HomeItemContentItem *contentItem = floor.contents.firstObject;
    CGFloat height = (contentItem.type==HomeItemContentItemTypeRecommend)?LINE_H:0.0001;
    return height;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSArray *dataArr = [HomeDataManager shareHomeDataManager].dataArr;
    HomeFloorsItem *floor = dataArr[indexPath.section];
    
    BOOL isTitle = NO;
    NSUInteger index = indexPath.row;
    if (indexPath.row > 0) {//处理index 及 按类型 选择对应segue模型(title\content)
        if (floor.hasTitle) {
            index --;
        }
    } else {
        isTitle = floor.hasTitle;
    }
    if (isTitle) {//标题模型
        [SegueMaster makeSegueWithModel:floor.titleContent.titleSegue fromController:self];
    }else{//内容模型 可多行
        [SegueMaster makeSegueWithModel:floor.contents[index].contentSegue fromController:self];
    }
}

#pragma mark-
#pragma mark 点击事件
- (void)didClickBackToTopBtn{
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    if (_iv_activity.tag == 0) {
        _iv_activity.tag = 1;
        [UIView animateWithDuration:ActivityViewAnimationDuration animations:^{
            [_iv_right activate];//激活约束 向右位移 旋转
            _iv_activity.transform = CGAffineTransformMakeRotation(-M_PI_4);
            [self.view layoutIfNeeded];
        }];
    }
}

#pragma mark-
#pragma mark scrollDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {//处理置顶按钮 导航视图 及活动视图
    if (self.tableView.contentOffset.y > SCREEN_HEIGHT) {//置顶
        [self.backToTop setHidden:NO];
    } else {
        [self.backToTop setHidden:YES];
    }
    [self.floorView collapse:YES];//导航
    for (NSUInteger naviIndex = 0; naviIndex < [[HomeDataManager shareHomeDataManager].homeModel.naviDatas count]; naviIndex ++) {
        HomeDataItem *dataItem = [HomeDataManager shareHomeDataManager].homeModel.naviDatas[naviIndex];
        if (dataItem.dataIndex == [self floorIndexAtCurrentScrollingPoint]) {
            [self.floorView setSelectedIndex:naviIndex];
            break;
        }
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (_iv_activity.tag == 0) {
        _iv_activity.tag = 1;
        [UIView animateWithDuration:ActivityViewAnimationDuration animations:^{
            [_iv_right activate];//激活约束 向右位移 旋转
            _iv_activity.transform = CGAffineTransformMakeRotation(-M_PI_4);
            [self.view layoutIfNeeded];
        }];
    }
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (self.tableView.contentOffset.y < 100) {
        [self.floorView setSelectedIndex:0];
    } else {
        [self.floorView setSelectedIndex:[HomeDataManager shareHomeDataManager].homeModel.naviDatas.count - 1];
    }
}

#pragma mark-
#pragma mark ActivityViewDelegate

- (void)iv_activityTapAction:(UITapGestureRecognizer *)tagGR {
    
    if (self.iv_activity.tag == 1) {
        self.iv_activity.tag = 0;
        [UIView animateWithDuration:ActivityViewAnimationDuration animations:^{
            [self.iv_right deactivate];
            self.iv_activity.transform = CGAffineTransformMakeRotation(0);
            [self.view layoutIfNeeded];
        }];
    }else{
        NSString *linkUrl = [HomeActivityManager shareHomeActivityManager].data.linkUrl;
        if (linkUrl.length>0) {
            WebViewController *webVc = [[WebViewController alloc] init];
            webVc.urlString = linkUrl;
            [self.navigationController pushViewController:webVc animated:YES];
        }
    }
}

#pragma mark AUIFloorNavigationViewDataSource & AUIFloorNavigationViewDelegate
- (NSUInteger)numberOfItemsOnFloorNavigationView:(AUIFloorNavigationView *)navigationView {
    return [HomeDataManager shareHomeDataManager].homeModel.naviDatas.count;
}

- (UIView *)floorNavigationView:(AUIFloorNavigationView *)navigationView viewForItemAtIndex:(NSUInteger)index {
    HomeDataItem *dataItem = [HomeDataManager shareHomeDataManager].homeModel.naviDatas[index];
    
    UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [itemView setBackgroundColor:COLOR_BG];
    UILabel *label = [[UILabel alloc] initWithFrame:itemView.frame];
    [label setText:dataItem.floorName];
    [label setFont:[UIFont systemFontOfSize:13]];
    [label setTextColor:COLOR_PINK];
    [label setTextAlignment:NSTextAlignmentCenter];
    [itemView addSubview:label];
    
    itemView.layer.cornerRadius = 20;
    itemView.layer.borderWidth = 2;
    itemView.layer.borderColor = COLOR_PINK.CGColor;
    itemView.layer.masksToBounds = YES;
    
    return itemView;
}

- (UIView *)floorNavigationView:(AUIFloorNavigationView *)navigationView highlightViewForItemAtIndex:(NSUInteger)index {
    HomeDataItem *dataItem = [HomeDataManager shareHomeDataManager].homeModel.naviDatas[index];
    
    UIView *highlightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [highlightView setBackgroundColor:COLOR_PINK];
    UILabel *label = [[UILabel alloc] initWithFrame:highlightView.frame];
    [label setText:dataItem.floorName];
    [label setFont:[UIFont systemFontOfSize:13]];
    [label setTextColor:COLOR_BG_CEll];
    [label setTextAlignment:NSTextAlignmentCenter];
    [highlightView addSubview:label];
    
    highlightView.layer.cornerRadius = 20;
    highlightView.layer.borderWidth = 2;
    highlightView.layer.borderColor = COLOR_BG.CGColor;
    highlightView.layer.masksToBounds = YES;
    
    return highlightView;
}

- (UIView *)floorNavigationView:(AUIFloorNavigationView *)navigationView viewForItemGapAtIndex:(NSUInteger)index {
    UIView *gapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 20)];
    [gapView setBackgroundColor:COLOR_BG];
    return gapView;
}

- (void)floorNavigationView:(AUIFloorNavigationView *)navigationView didSelectedAtIndex:(NSUInteger)index {
    HomeDataItem *dataItem = [HomeDataManager shareHomeDataManager].homeModel.naviDatas[index];
    [self scrollToFloorIndex:dataItem.dataIndex];
}

#pragma mark-
#pragma mark privite method
- (void)prepareTableView{
    
    UITableView *tablView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    tablView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tablView.delegate = self;
    tablView.dataSource = self;
    tablView.backgroundView = nil;
    tablView.backgroundColor = COLOR_BG;
    tablView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tablView];
    self.tableView = tablView;
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    [self registerCell];
    
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

- (void)registerCell{
    
    [self.tableView registerClass:[HomeCountDownMoreTitleCell class] forCellReuseIdentifier:kCountDownMoreTitleCellIdentifier];
    [self.tableView registerClass:[HomeNewsCell class] forCellReuseIdentifier:kNewsCellIdentifier];
    [self.tableView registerClass:[HomeBannerCell class] forCellReuseIdentifier:kBannerCellIdentifier];
    [self.tableView registerClass:[HomeNoticeCell class] forCellReuseIdentifier:kNoticeCellIdentifier];
    [self.tableView registerClass:[HomeWholeImageNewsCell class] forCellReuseIdentifier:kWholeImageNewsCellIdentifier];
    [self.tableView registerClass:[HomeTwinklingCell class] forCellReuseIdentifier:kTwinklingElfCellIdentifier];
    [self.tableView registerClass:[HomeThemeCell class] forCellReuseIdentifier:kThemeCellIdentifier];
    [self.tableView registerClass:[HomeHorizontalListCell class] forCellReuseIdentifier:kHorizontalListCellIdentifier];
    [self.tableView registerClass:[HomeBigImageTwoDescCell class] forCellReuseIdentifier:kBigImageTwoDescCellIdentifier];
    [self.tableView registerClass:[HomeTwoThreeFourCell class] forCellReuseIdentifier:kTwoThreeFourCellIdentifier];
    [self.tableView registerClass:[HomeThreeCell class] forCellReuseIdentifier:kThreeCellIdentifier];
    [self.tableView registerClass:[HomeNewsCell class] forCellReuseIdentifier:kImageNewsCellIdentifier];
    [self.tableView registerClass:[HomeNewsCell class] forCellReuseIdentifier:kThreeImageNewsCellIdentifier];
    [self.tableView registerClass:[HomeRecommendCell class] forCellReuseIdentifier:kRecomendCellIdentifier];
}

- (void)setBackToTopBtn{
    [self.view addSubview:self.backToTop];
    [self.backToTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@40);
        make.right.equalTo(self.view).offset(-10);
        make.bottom.equalTo(self.view).offset(-59);
    }];
}

- (void)setActivityView{
    
    [self.view addSubview:self.iv_activity];
    WeakSelf(self)
    //约束
    [self.iv_activity mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongSelf(self)
        make.height.width.equalTo(@80);
        make.right.bottom.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 200, 0)).priorityLow();
        self.iv_right = make.right.equalTo(self.view).offset(40).priority(UILayoutPriorityRequired);
    }];
    [self.iv_right deactivate];
    
}
#pragma mark-
#pragma mark 导航按钮
- (void)setFloorView{
    [self.view addSubview:self.floorView];
    
    [self.floorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-10);
        make.width.equalTo(@30);
        make.height.equalTo(@150);
        make.bottom.equalTo(self.backToTop.mas_top).offset(-10);
    }];
    self.floorView.dataSource = self;
    self.floorView.delegate = self;
    [self.floorView setEnableCollapse:YES];
    [self.floorView setAnimateDirection:AUIFloorNavigationViewAnimateDirectionDown];
}

- (NSUInteger)floorIndexAtCurrentScrollingPoint {
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:CGPointMake(0, self.tableView.contentOffset.y + (SCREEN_HEIGHT - 49 - 64) - 100)];
    if (!indexPath) {
        return 0;
    }
    NSUInteger index = 0;
    HomeDataItem *dataItem = [HomeDataManager shareHomeDataManager].homeModel.data.firstObject;
    
    if (indexPath.section < [dataItem.floors count]) {
        HomeFloorsItem *floorsItem = dataItem.floors[indexPath.section];
        index = floorsItem.floorIndex;
    } else {
        index = [dataItem.floors count] - 1;
    }
    return index;
}

- (void)scrollToFloorIndex:(NSUInteger)index {
    CGPoint offset = [self offsetFromFloorIndex:index];
    [self.tableView setContentOffset:offset animated:YES];
}

- (CGPoint)offsetFromFloorIndex:(NSUInteger)index {
    NSUInteger section = 0;
    for (NSUInteger floorIndex = 0; floorIndex < [HomeDataManager shareHomeDataManager].homeModel.data.count; floorIndex ++) {
        HomeDataItem *dataItem = [HomeDataManager shareHomeDataManager].homeModel.data[floorIndex];
        if (floorIndex < index) {
            section += [dataItem.floors count];
        } else {
            break;
        }
    }
    
    CGRect area = [self.tableView rectForSection:section];
    CGFloat yOffset = self.tableView.contentOffset.y + area.origin.y - self.tableView.contentOffset.y - (SCREEN_HEIGHT - 49 - 64) + area.size.height;
    if (yOffset < 0) {
        yOffset = 0;
    } else if (yOffset > self.tableView.contentSize.height) {
        yOffset = self.tableView.contentSize.height;
    }
    CGPoint offsetNew = CGPointMake(self.tableView.contentOffset.x, yOffset);
    return offsetNew;
}

#pragma mark-
#pragma mark lzy
- (UIButton *)backToTop{
    if (!_backToTop) {
        _backToTop = [[UIButton alloc] initWithFrame:CGRectZero];
        [_backToTop addTarget:self action:@selector(didClickBackToTopBtn) forControlEvents:UIControlEventTouchUpInside];
        //[_backToTop setTitleShadowColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        
        [_backToTop setImage:[UIImage imageNamed:@"goBackToTop"] forState:UIControlStateNormal];
        [_backToTop setBackgroundColor:[UIColor whiteColor]];
        _backToTop.alpha = .7;
        _backToTop.layer.cornerRadius = 20;
        _backToTop.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _backToTop.layer.borderWidth = 0.5;
        _backToTop.layer.masksToBounds = YES;
        [_backToTop setHidden:YES];
        
    }
    return _backToTop;
}

- (AUIFloorNavigationView *)floorView{
    if (!_floorView) {
        _floorView = [[AUIFloorNavigationView alloc] initWithFrame:CGRectZero];
        _floorView.userInteractionEnabled = YES;
    }
    return _floorView;
}

- (UIImageView *)iv_activity{
    if (!_iv_activity) {
        _iv_activity = [[UIImageView alloc] initWithFrame:CGRectZero];
        _iv_activity.userInteractionEnabled = YES;
        _iv_activity.tag = 0;
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(iv_activityTapAction:)];
        [_iv_activity addGestureRecognizer:tapGR];
    }
    return _iv_activity;
}

- (void)dealloc{
    [NotificationCenter removeObserver:self name:kPosterViewControllerFinishShow object:nil];
    [NotificationCenter removeObserver:self name:kHomeActivityUpdateNoti object:nil];
    [NotificationCenter removeObserver:self name:kRoleHasChangedNotification object:nil];
}
@end
