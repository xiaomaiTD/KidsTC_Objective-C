//
//  StrategyViewController.m
//  KidsTC
//
//  Created by zhanping on 6/6/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "StrategyViewController.h"
#import "StrategyCollectionViewCell.h"
#import "StrategyModel.h"
#import "KTCFavouriteManager.h"
#import "StrategyCollectionViewFlowLayout.h"
#import "ParentingStrategyDetailViewController.h"
#import "SegueMaster.h"
#import "KTCEmptyDataView.h"
#import "StrategyTagColumnTableViewController.h"
#import "MultiItemsToolBar.h"
#import "GHeader.h"
#import "UIBarButtonItem+Category.h"
#import "BuryPointManager.h"

#define defaultTagId 0
#define pageCount 10

@interface StrategyViewController ()<StrategyCollectionViewCellDelegate,MultiItemsToolBarDelegate,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) NSMutableArray<StrategyShowModel *> *models;
@property (nonatomic, strong) MultiItemsToolBar *toolBar;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) UIEdgeInsets tablViewInset;
@end

@implementation StrategyViewController

static NSString * const reuseIdentifier = @"Cell";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageId = 10801;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.title = @"亲子攻略";
    
    
    StrategyCollectionViewFlowLayout *layout = [[StrategyCollectionViewFlowLayout alloc]init];
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
    collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:collectionView];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [collectionView registerNib:[UINib nibWithNibName:@"StrategyCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    collectionView.pagingEnabled = YES;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView = collectionView;
    
    MultiItemsToolBar *toolBar = [[MultiItemsToolBar alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, MultiItemsToolBarScrollViewHeight)];
    toolBar.delegate = self;
    [self.view addSubview:toolBar];
    toolBar.hidden = YES;
    self.toolBar = toolBar;
    
    self.models = [NSMutableArray array];
    
    WeakSelf(self)
    self.failurePageActionBlock = ^(){
        StrongSelf(self)
        [self loadDataWithStrategyCell:nil loadDataRefresh:YES];
    };
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.models.count<=0) [self loadDataWithStrategyCell:nil loadDataRefresh:YES];
}

- (void)loadDataWithStrategyCell:(StrategyCollectionViewCell *)strategyCell loadDataRefresh:(BOOL)refresh{
    
    NSUInteger page = 1;
    NSInteger tagId = defaultTagId;
    
    if (strategyCell) {
        StrategyShowModel *showModel = strategyCell.model;
        if (refresh) {
            showModel.currentPage = 1;
        }else{
            showModel.currentPage ++;
        }
        page = showModel.currentPage;
        tagId = showModel.currentTagId;
    }
    
    NSDictionary *parameters = @{@"tagId":@(tagId),
                                 @"orderByType":@"1",
                                 @"page":@(page),
                                 @"pageCount":@(pageCount)};
    [Request startWithName:@"STRATEGY_SEARCH_V2" param:parameters progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        
        StrategyModel *model = [StrategyModel modelWithDictionary:dic];
        NSArray<StrategyListItem *> *list = model.data.list;
        
        if (refresh && tagId == defaultTagId) {
            [self reloadCollectionViewWith:model];
        }else if (strategyCell) {
            if (refresh) {
                strategyCell.model.list = list;
            }else{
                NSMutableArray *mutableList = [NSMutableArray arrayWithArray:strategyCell.model.list];
                [mutableList addObjectsFromArray:list];
                strategyCell.model.list = mutableList;
            }
        }
        if (strategyCell) {
            [strategyCell headerEndRefreshing];
            [strategyCell footerEndRefreshing];
            if (list.count<1) {
                [strategyCell footerEndRefreshingWithNoMoreData];
            }
            [strategyCell reloadData];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (refresh && tagId == defaultTagId) {
            if (self.models.count<=0) {
                self.collectionView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.collectionView.frame.size.height) image:nil description:@"啥都木有啊···" needGoHome:YES];
            }else{
                self.collectionView.backgroundView = nil;
            }
            [self.collectionView reloadData];
        }else if (strategyCell) {
            [strategyCell headerEndRefreshing];
            [strategyCell footerEndRefreshing];
        }
        if (self.models.count<1) {
            [self loadDataFailureAction:NO];
        }
    }];
}

- (void)reloadCollectionViewWith:(StrategyModel *)model{
    
    StrategyTypeList *typeList = model.data.typeList;
    NSArray<StrategyTypeListTagItem *> *tags = typeList.tag;
    if (tags.count<=0) {
        StrategyShowModel *modelsItem = [StrategyShowModel modelWithCurrentTagId:defaultTagId currentIndex:0];
        modelsItem.header = [StrategyShowHeader headerWithBanner:typeList.banner tagPic:typeList.tagPic];
        modelsItem.list = model.data.list;
        NSMutableArray<StrategyShowModel *> *models = [NSMutableArray<StrategyShowModel *> arrayWithObjects:modelsItem, nil];
        self.models = models;
        self.toolBar.hidden = YES;
        self.tablViewInset = UIEdgeInsetsMake(64, 0, 49, 0);
    }else{
        __block NSMutableArray<StrategyShowModel *> *models = [NSMutableArray<StrategyShowModel *> array];
        [tags enumerateObjectsUsingBlock:^(StrategyTypeListTagItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            StrategyShowModel *modelsItem = [StrategyShowModel modelWithCurrentTagId:obj.ID currentIndex:idx];
            if (obj.ID == defaultTagId) {
                self.toolBar.tags = [model.data.typeList.tag valueForKeyPath:@"_name"];
                [self.toolBar changeTipPlaceWithSmallIndex:0 bigIndex:0 progress:0 animate:NO];
                modelsItem.header = [StrategyShowHeader headerWithBanner:typeList.banner tagPic:typeList.tagPic];
                modelsItem.list = model.data.list;
            }
            [models addObject:modelsItem];
        }];
        self.models = models;
        if (models.count<=0) {
            self.collectionView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.collectionView.frame.size.height) image:nil description:@"啥都木有啊···" needGoHome:YES];
        }else{
            self.collectionView.backgroundView = nil;
        }
        self.toolBar.hidden = NO;
        self.tablViewInset = UIEdgeInsetsMake(64+MultiItemsToolBarScrollViewHeight, 0, 49, 0);
    }
    [self.collectionView reloadData];
    
}


#pragma mark - StrategyCollectionViewCellDelegate

- (void)strategyCell:(StrategyCollectionViewCell *)strategyCell loadDataRefresh:(BOOL)refresh{
    [self loadDataWithStrategyCell:strategyCell loadDataRefresh:refresh];
}

- (void)strategyCell:(StrategyCollectionViewCell *)strategyCell strategyTableHeaderView:(StrategyTableHeaderView *)strategyTableHeaderView didClickBannerAtIndex:(NSUInteger)index{
    StrategyTypeListBannerItem *item = strategyTableHeaderView.header.banner[index];
    SegueModel *segue = [SegueModel modelWithDestination:(SegueDestination)item.linkType paramRawData:item.params];
    [SegueMaster makeSegueWithModel:segue fromController:self];
}

- (void)strategyCell:(StrategyCollectionViewCell *)strategyCell strategyTableHeaderView:(StrategyTableHeaderView *)strategyTableHeaderView didClickTagPicAtIndex:(NSUInteger)index{
    StrategyTypeListTagPicItem *item = strategyTableHeaderView.header.tagPic[index];
    StrategyTagColumnTableViewController *controller = [[StrategyTagColumnTableViewController alloc]init];
    controller.tagId = item.tagId;
    controller.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)strategyCell:(StrategyCollectionViewCell *)strategyCell strategyTableViewCell:(StrategyTableViewCell *)strategyTableViewCell didClickOnStrategyLikeButton:(StrategyLikeButton *)strategyLikeButton{
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        [self changeLikeStatusWithItem:strategyTableViewCell.item];
        [self changeBtnStyleWithStrategyTableViewCell:strategyTableViewCell];
    }];
}

- (void)strategyCell:(StrategyCollectionViewCell *)strategyCell tableView:(UITableView *)tableView didSelectedIndexPath:(NSIndexPath *)indexPath{
    StrategyShowModel *model = strategyCell.model;
    StrategyListItem *item = model.list[indexPath.row];
    StrategyTableViewCell *strategyTableViewCell = [tableView cellForRowAtIndexPath:indexPath];
    ParentingStrategyDetailViewController *controller = [[ParentingStrategyDetailViewController alloc] initWithStrategyIdentifier:item.ID];
    controller.changeLikeBtnStatusBlock = ^{[self changeBtnStyleWithStrategyTableViewCell:strategyTableViewCell];};
    [controller setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - MultiItemsToolBarDelegate

- (void)multiItemsToolBar:(MultiItemsToolBar *)multiItemsToolBar didSelectedIndex:(NSUInteger)index{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    if (self.models.count>index) {
        [params setValue:@(self.models[index].currentTagId) forKey:@"tagId"];
    }
    [BuryPointManager trackEvent:@"event_click_stgy_tag" actionId:21401 params:params];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat w = self.collectionView.frame.size.width;
    NSUInteger smallIndex = offsetX/w;
    NSUInteger bigIndex = smallIndex+1;
    CGFloat progress = (offsetX-smallIndex*w)/w;
    
    [self.toolBar changeTipPlaceWithSmallIndex:smallIndex bigIndex:bigIndex progress:progress animate:YES];
}

#pragma mark - UICollectionViewDataSource,UICollectionViewDelegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.models.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    StrategyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    cell.tableViewInset = self.tablViewInset;
    cell.model = self.models[indexPath.item];
    
    return cell;
}

#pragma mark private

- (void)changeLikeStatusWithItem:(StrategyListItem *)item{
    NSString *identifier = [NSString stringWithFormat:@"%zd",item.ID];
    KTCFavouriteManager *manager = [KTCFavouriteManager sharedManager];
    if (item.isInterest) {//已经感兴趣
        [manager deleteFavouriteWithIdentifier:identifier
                                          type:KTCFavouriteTypeStrategy
                                       succeed:nil failure:nil];
    }else{
        [manager addFavouriteWithIdentifier:identifier
                                       type:KTCFavouriteTypeStrategy
                                    succeed:nil failure:nil];
    }
}

- (void)changeBtnStyleWithStrategyTableViewCell:(StrategyTableViewCell *)strategyTableViewCell{
    StrategyLikeButton *strategyLikeButton = strategyTableViewCell.likeBtn;
    
    [UIView animateWithDuration:0.2 animations:^{
        strategyLikeButton.imageView.transform = CGAffineTransformMakeScale(1.5, 1.5);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            strategyLikeButton.imageView.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            if (strategyTableViewCell.item.isInterest) {
                strategyTableViewCell.item.interestCount--;
            }else{
                strategyTableViewCell.item.interestCount++;
            }
            strategyTableViewCell.item.isInterest = !strategyTableViewCell.item.isInterest;
            [strategyLikeButton setTitle:[NSString stringWithFormat:@"%zd",strategyTableViewCell.item.interestCount] forState:UIControlStateNormal];
            NSString *likeBtnImageName = strategyTableViewCell.item.isInterest?@"strategory_love_true":@"strategory_love_false";
            [strategyLikeButton setImage:[UIImage imageNamed:likeBtnImageName] forState:UIControlStateNormal];
        }];
    }];
}

@end
