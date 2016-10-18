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
#import "Masonry.h"

#import "TCHomeCollectionViewLayout.h"
#import "TCHomeMainCollectionCell.h"

#import "GuideManager.h"
#import "PosterManager.h"
#import "HomeActivityManager.h"
#import "SearchHotKeywordsManager.h"
#import "HomeRefreshManager.h"

#import "TCHomeModel.h"
#import "TCHomeRecommendModel.h"
#import "TCHomeBaseTableViewCell.h"

#import "QRCodeScanViewController.h"
#import "SpeekViewController.h"
#import "SearchTableViewController.h"
#import "CategoryViewController.h"
#import "StrategyToolBar.h"
#import "AUIFloorNavigationView.h"
#import "WebViewController.h"


static CGFloat const kActivityImageViewAnimateDuration = 0.5;


static NSString *const kTCHomeMainCollectionCellID = @"TCHomeMainCollectionCell";

@interface TCHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate,StrategyToolBarDelegate,TCHomeMainCollectionCellDelegate,AUIFloorNavigationViewDelegate,AUIFloorNavigationViewDataSource>
@property (nonatomic, strong) HomeRoleButton *roleBtn;
@property (nonatomic, weak) UITextField *tf;

@property (nonatomic, strong) StrategyToolBar *toolBar;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<TCHomeCategory *> *categorys;
@property (nonatomic, assign) NSUInteger currentIndex;

@property (nonatomic, strong) UIButton *backToTop;
@property (nonatomic, strong) AUIFloorNavigationView *floorView;
@property (nonatomic, strong) TCHomeCategory *currentCategory;

@property (nonatomic, strong) UIImageView *activityImageView;//活动图片
@property (nonatomic, strong) MASConstraint *iv_right;//活动图片右侧约束
@end

@implementation TCHomeViewController

- (NSArray<TCHomeCategory *> *)categorys{
    if (!_categorys) {
        TCHomeCategory *category = [TCHomeCategory new];
        _categorys = @[category];
    }
    return _categorys;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self addObserver];
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

#pragma mark - setupUI

- (void)setupUI {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self setupTf];
    
    [self setupNaviItems];
    
    [self setupCollectionView];
    
    [self setupToolBar];
    
    [self setupBackToTop];
    
    [self setupFloorNavigationView];
    
    [self setupActivityImageView];
}

#pragma mark setupTf

- (void)setupTf {
    
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
}

#pragma mark Tf UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    SearchTableViewController *controller = [[SearchTableViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
    return NO;
}

#pragma mark Tf placeHolder

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

#pragma mark setupNaviItems

- (void)setupNaviItems {
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImagePostion:UIBarButtonPositionLeft
                                                                           target:self
                                                                           action:@selector(showScan)
                                                                     andGetButton:^(UIButton *btn)
    {
        btn.bounds = CGRectMake(0, 0, 29, 32);
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [btn setImage:[UIImage imageNamed:@"home_scan"] forState:UIControlStateNormal];
    }];
    
    self.roleBtn = [HomeRoleButton btnWithImageName:@"arrow_d_mini" highImageName:@"arrow_d_mini" target:self action:@selector(changeRole)];
    [self.roleBtn setTitle:[User shareUser].role.statusName forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.roleBtn];
}

- (void)showScan{
    QRCodeScanViewController *controller = [[QRCodeScanViewController alloc]init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)speek {
    SpeekViewController *controller = [[SpeekViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)changeRole{
    RoleSelectViewController *controller = [[RoleSelectViewController alloc]initWithNibName:@"RoleSelectViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark setupCollectionView

- (void)setupCollectionView {

    TCHomeCollectionViewLayout *layout = [TCHomeCollectionViewLayout new];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.pagingEnabled = YES;
    collectionView.scrollsToTop = NO;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    [collectionView registerClass:[TCHomeMainCollectionCell class] forCellWithReuseIdentifier:kTCHomeMainCollectionCellID];
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
}


#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat w = self.collectionView.frame.size.width;
    NSUInteger smallIndex = offsetX/w;
    NSUInteger bigIndex = smallIndex+1;
    CGFloat progress = (offsetX-smallIndex*w)/w;
    
    [self.toolBar changeTipPlaceWithSmallIndex:smallIndex bigIndex:bigIndex progress:progress animate:YES];
    
    if (smallIndex * w == offsetX) {
        self.currentCategory = self.categorys[smallIndex];
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.categorys.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TCHomeMainCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTCHomeMainCollectionCellID forIndexPath:indexPath];
    if (indexPath.row<self.categorys.count) {
        cell.delegate = self;
        cell.category = self.categorys[indexPath.row];
    }
    cell.indexPath = indexPath;
    return cell;
}

#pragma mark - TCHomeMainCollectionCellDelegate

- (void)tcHomeMainCollectionCell:(TCHomeMainCollectionCell *)cell actionType:(TCHomeMainCollectionCellActionType)type value:(id)value {
    switch (type) {
        case TCHomeMainCollectionCellActionTypeLoadData:
        {
            NSDictionary *dic = value;
            self.categorys = dic[@"categorys"];
            BOOL showCategory = [dic[@"showCategory"] boolValue];
            self.toolBar.hidden = !showCategory;
            if (showCategory) {
                self.toolBar.tags = [self.categorys valueForKeyPath:@"_name"];
                [self.toolBar changeTipPlaceWithSmallIndex:0 bigIndex:0 progress:0 animate:NO];
            }
            [self.collectionView reloadData];
            [self scrollViewDidScroll:self.collectionView];
        }
            break;
        case TCHomeMainCollectionCellActionTypeSegue:
        {
            [SegueMaster makeSegueWithModel:value fromController:self];
        }
            break;
        case TCHomeMainCollectionCellActionTypeScroll:
        {
            NSDictionary *dic = value;
            
            CGFloat y = [dic[@"y"] floatValue];
            self.backToTop.hidden = y<SCREEN_HEIGHT;
            
            //处理导航
            NSUInteger index = [dic[@"index"] integerValue];
            [self.currentCategory.modules enumerateObjectsUsingBlock:^(TCHomeModule *obj, NSUInteger idx, BOOL *stop) {
                if (obj.index == index) {
                    self.floorView.selectedIndex = idx;
                }
            }];
            [self.floorView collapse:YES];
            
            //活动小icon
            if (self.activityImageView.tag == 0) {
                self.activityImageView.tag = 1;
                [UIView animateWithDuration:kActivityImageViewAnimateDuration animations:^{
                    [self.iv_right activate];//激活约束 向右位移 旋转
                    self.activityImageView.transform = CGAffineTransformMakeRotation(-M_PI_4);
                    [self.view layoutIfNeeded];
                }];
            }
        }
            break;
        case TCHomeMainCollectionCellActionTypeHomeRefresh:
        {
            [[HomeRefreshManager shareHomeActivityManager] checkHomeRefreshPageWithTarget:self resultBlock:nil];
        }
            break;
    }
}

#pragma mark setupToolBar

- (void)setupToolBar {
    StrategyToolBar *toolBar = [[StrategyToolBar alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, StrategyToolBarScrollViewHeight)];
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
    toolBar.hidden = YES;
    self.toolBar = toolBar;
}

#pragma mark - StrategyToolBarDelegate

- (void)strategyToolBar:(StrategyToolBar *)strategyToolBar didSelectedIndex:(NSUInteger)index{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

#pragma mark setupBackToTop

- (void)setupBackToTop {
    
    CGFloat btn_s = 40;
    CGFloat btn_x = SCREEN_WIDTH - btn_s - 10;
    CGFloat btn_y = SCREEN_HEIGHT - btn_s - 49 - 20;
    CGRect btn_f = CGRectMake(btn_x, btn_y, btn_s, btn_s);
    
    UIButton *backToTopBtn = [[UIButton alloc] initWithFrame:btn_f];
    [backToTopBtn addTarget:self action:@selector(backToTop:) forControlEvents:UIControlEventTouchUpInside];
    [backToTopBtn setImage:[UIImage imageNamed:@"goBackToTop"] forState:UIControlStateNormal];
    [backToTopBtn setBackgroundColor:[UIColor whiteColor]];
    backToTopBtn.alpha = .7;
    backToTopBtn.layer.cornerRadius = 20;
    backToTopBtn.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.7].CGColor;
    backToTopBtn.layer.borderWidth = 2;
    backToTopBtn.layer.masksToBounds = YES;
    backToTopBtn.hidden = YES;
    [self.view addSubview:backToTopBtn];
    self.backToTop = backToTopBtn;
}

- (void)backToTop:(UIButton *)btn {
    TCHomeMainCollectionCell *cell = [self.collectionView visibleCells].firstObject;
    [cell backToTop];
}

#pragma mark setupFloorNavigationView

- (void)setupFloorNavigationView {
    
    AUIFloorNavigationView *floorView = [[AUIFloorNavigationView alloc] initWithFrame:CGRectZero];
    floorView.userInteractionEnabled = YES;
    floorView.delegate = self;
    floorView.dataSource = self;
    floorView.enableCollapse = YES;
    floorView.animateDirection = AUIFloorNavigationViewAnimateDirectionDown;
    [self.view addSubview:floorView];
    self.floorView = floorView;
    
    [self.floorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-10);
        make.width.equalTo(@40);
        make.height.equalTo(@150);
        make.bottom.equalTo(self.backToTop.mas_top).offset(-20);
    }];
}

- (void)setCurrentCategory:(TCHomeCategory *)currentCategory {
    _currentCategory = currentCategory;
    [self.floorView reloadData];
    self.floorView.selectedIndex = 0;
}


#pragma mark - AUIFloorNavigationViewDelegate,AUIFloorNavigationViewDataSource

- (NSUInteger)numberOfItemsOnFloorNavigationView:(AUIFloorNavigationView *)navigationView {
    return self.currentCategory.modules.count;
}

- (UIView *)floorNavigationView:(AUIFloorNavigationView *)navigationView viewForItemAtIndex:(NSUInteger)index {
    TCHomeModule *module = self.currentCategory.modules[index];
    
    UIView *itemView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [itemView setBackgroundColor:COLOR_BG];
    UILabel *label = [[UILabel alloc] initWithFrame:itemView.frame];
    [label setText:module.name];
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
    TCHomeModule *module = self.currentCategory.modules[index];
    
    UIView *highlightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [highlightView setBackgroundColor:COLOR_PINK];
    UILabel *label = [[UILabel alloc] initWithFrame:highlightView.frame];
    [label setText:module.name];
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
    [gapView setBackgroundColor:[UIColor clearColor]];
    return gapView;
}

- (void)floorNavigationView:(AUIFloorNavigationView *)navigationView didSelectedAtIndex:(NSUInteger)index {
    TCHomeModule *module = self.currentCategory.modules[index];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:module.index];
    TCHomeMainCollectionCell *cell = [self.collectionView visibleCells].firstObject;
    [cell scrollTo:indexPath];
}

#pragma mark setupActivityImageView

- (void)setupActivityImageView {
    
    UIImageView *activityImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    activityImageView.userInteractionEnabled = YES;
    activityImageView.tag = 0;
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(activityImageViewTapAction:)];
    [activityImageView addGestureRecognizer:tapGR];
    [self.view addSubview:activityImageView];
    self.activityImageView = activityImageView;
    
    WeakSelf(self)
    //约束
    [self.activityImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        StrongSelf(self)
        make.height.width.equalTo(@80);
        make.right.bottom.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 200, 0)).priorityLow();
        self.iv_right = make.right.equalTo(self.view).offset(40).priority(UILayoutPriorityRequired);
    }];
    [self.iv_right deactivate];
    
}

- (void)activityImageViewTapAction:(UITapGestureRecognizer *)tapGR {
    if (self.activityImageView.tag == 1) {
        self.activityImageView.tag = 0;
        [UIView animateWithDuration:kActivityImageViewAnimateDuration animations:^{
            [self.iv_right deactivate];
            self.activityImageView.transform = CGAffineTransformMakeRotation(0);
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

#pragma mark - Notification

#pragma mark addObserver

- (void)addObserver {
    [NotificationCenter addObserver:self selector:@selector(posterViewControllerFinishShow) name:kPosterViewControllerFinishShow object:nil];
    [NotificationCenter addObserver:self selector:@selector(updateIv_activity) name:kHomeActivityUpdateNoti object:nil];
    [NotificationCenter addObserver:self selector:@selector(roleHasChanged) name:kRoleHasChangedNotification object:nil];
}

- (void)posterViewControllerFinishShow{
    [self checkGuide];
}

- (void)checkGuide{
    if (self.navigationController.viewControllers.count==1 &&
        [PosterManager sharePosterManager].hasShow &&
        !self.presentingViewController)
    {
        [[GuideManager shareGuideManager] checkGuideWithTarget:self type:GuideTypeHome resultBlock:^{
            [[HomeActivityManager shareHomeActivityManager] checkAcitvityWithTarget:self resultBlock:^{
            }];
        }];
    }
}

- (void)updateIv_activity{
    HomeActivityDataItem *data = [HomeActivityManager shareHomeActivityManager].data;
    self.activityImageView.hidden = !data.imageCanShow;
    if (!self.activityImageView.hidden) {
        [self.activityImageView sd_setImageWithURL:[NSURL URLWithString:data.thumbImg] placeholderImage:PLACEHOLDERIMAGE_SMALL_LOG];
    }
    self.floorView.hidden = !self.activityImageView.hidden;
}

- (void)roleHasChanged{
    [self.roleBtn setTitle:[User shareUser].role.statusName forState:UIControlStateNormal];
    self.categorys = nil;
    [self.collectionView reloadData];
}

#pragma mark removeObserver

- (void)removeObserver {
    [NotificationCenter removeObserver:self name:kPosterViewControllerFinishShow object:nil];
    [NotificationCenter removeObserver:self name:kHomeActivityUpdateNoti object:nil];
    [NotificationCenter removeObserver:self name:kRoleHasChangedNotification object:nil];
}

#pragma mark - dealloc

- (void)dealloc {
    [self removeObserver];
}

@end
