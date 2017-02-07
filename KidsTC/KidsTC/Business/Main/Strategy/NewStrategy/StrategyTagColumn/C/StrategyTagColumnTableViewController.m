//
//  StrategyTagColumnTableViewController.m
//  KidsTC
//
//  Created by zhanping on 6/12/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "StrategyTagColumnTableViewController.h"
#import "StrategyTableViewCell.h"
#import "StrategyTagColumnModel.h"
#import "KTCFavouriteManager.h"
#import "CommonShareObject.h"
#import "CommonShareViewController.h"
#import "ParentingStrategyDetailViewController.h"
#import "GHeader.h"
#import "UIBarButtonItem+Category.h"
#import "NSString+Category.h"

#define pageCount 10

@interface StrategyTagColumnTableViewController ()<StrategyTableViewCellDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, strong) NSMutableArray *ary;
@property (nonatomic, strong) StrategyTagColumnShare *share;
@end

static NSString *ID = @"StrategyTableViewCellID";

@implementation StrategyTagColumnTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageId = 10802;
    self.trackParams = @{@"tagId":@(self.tagId)};
    
    self.ary = [NSMutableArray array];
    
    self.navigationItem.rightBarButtonItem =
    [UIBarButtonItem itemWithImageName:@"menu_share"
                         highImageName:@"menu_share"
                               postion:UIBarButtonPositionRight
                                target:self
                                action:@selector(rightBarBtnAction:)];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    [tableView registerNib:[UINib nibWithNibName:@"StrategyTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ID];
    
    WeakSelf(self)
    self.tableView.mj_header = [RefreshHeader headerWithRefreshingBlock:^{
        StrongSelf(self)
        [self loadDataRefresh:YES];
    }];
    self.tableView.mj_footer = [RefreshFooter footerWithRefreshingBlock:^{
        StrongSelf(self)
        [self loadDataRefresh:NO];
    }];
    [self.tableView.mj_header beginRefreshing];
}

- (void)rightBarBtnAction:(UIBarButtonItem *)item{
    CommonShareObject *shareObject = [CommonShareObject shareObjectWithTitle:self.share.tit
                                                                 description:self.share.desc
                                                               thumbImageUrl:[NSURL URLWithString:self.share.pic]
                                                                   urlString:self.share.shareUrl];
    //shareObject.identifier = [NSString stringWithFormat:@"%zd",self.tagId];
    shareObject.followingContent = @"【童成网】";
    CommonShareViewController *controller = [CommonShareViewController instanceWithShareObject:shareObject sourceType:KTCShareServiceTypeStrategy];
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (void)loadDataRefresh:(BOOL)refresh{
    
    if (refresh) {
        self.page = 1;
    }else{
        self.page ++;
    }
    
    NSDictionary *parameters = @{@"tagId":@(self.tagId),
                                 @"page":@(self.page),
                                 @"pageCount":@(pageCount)};
    [Request startWithName:@"STRATEGY_LIST_BY_TAG" param:parameters progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        StrategyTagColumnModel *model = [StrategyTagColumnModel modelWithDictionary:dic];
        self.navigationItem.title = model.data.title;
        self.share = model.data.share;
        
        if (refresh) {
            self.ary = [NSMutableArray arrayWithArray:model.data.list];
        }else{
            [self.ary addObjectsFromArray:model.data.list];
        }
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        if (model.data.list.count<1) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }

    } failure:^(NSURLSessionDataTask *task, NSError *error) {

        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
        
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.ary.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    StrategyListItem *item = self.ary[indexPath.row];
    CGFloat ratio = item.ratio;
    if (ratio==0) {
        ratio = 0.6;
    }
    CGFloat hight = (SCREEN_WIDTH-8*2)*ratio+8*2;
    return hight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    StrategyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.delegate = self;
    cell.item = self.ary[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    StrategyListItem *item = self.ary[indexPath.row];
    ParentingStrategyDetailViewController *controller = [[ParentingStrategyDetailViewController alloc] initWithStrategyIdentifier:item.ID];
    [controller setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark <StrategyTableViewCellDelegate>

- (void)strategyTableViewCell:(StrategyTableViewCell *)strategyTableViewCell didClickOnStrategyLikeButton:(StrategyLikeButton *)strategyLikeButton{
    [[User shareUser] checkLoginWithTarget:self resultBlock:^(NSString *uid, NSError *error) {
        [self changeLikeStatusWithItem:strategyTableViewCell.item];
        
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
    }];
}

#pragma mark private

- (void)changeLikeStatusWithItem:(StrategyListItem *)item{
    
    NSString *identifier = item.ID;
    
    if (item.isInterest) {//已经感兴趣
        [[KTCFavouriteManager sharedManager] deleteFavouriteWithIdentifier:identifier type:KTCFavouriteTypeStrategy succeed:^(NSDictionary *data) {
            
        } failure:^(NSError *error) {
            
        }];
    }else{
        [[KTCFavouriteManager sharedManager] addFavouriteWithIdentifier:identifier type:KTCFavouriteTypeStrategy succeed:^(NSDictionary *data) {
            
        } failure:^(NSError *error) {
            
        }];
    }
}

@end
