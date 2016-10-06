//
//  MessageCenterViewController.m
//  KidsTC
//
//  Created by zhanping on 4/29/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "MessageCenterViewController.h"
#import "MessageCenterCell.h"
#import "ArticleCommentModel.h"
#import "MessageCenterLayout.h"
#import "SegueMaster.h"
#import "UserArticleCommentsViewController.h"
#import "GHeader.h"
#import "KTCEmptyDataView.h"
#define pageCount 10

@interface MessageCenterViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, strong) NSMutableArray *ary;
@end

@implementation MessageCenterViewController

-(NSMutableArray *)ary{
    if (!_ary) {
        _ary = [NSMutableArray new];
    }
    return _ary;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    self.tableView.backgroundColor = [UIColor colorWithRed:0.965 green:0.965 blue:0.965 alpha:1];
    
    self.navigationItem.title = @"消息中心";
    WeakSelf(self)
    MJRefreshHeader *tv1_header = [RefreshHeader headerWithRefreshingBlock:^{
        StrongSelf(self)
        [self getAryRefresh:YES];
    }];
    tv1_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_header = tv1_header;
    
    MJRefreshFooter *tv1_footer = [RefreshFooter footerWithRefreshingBlock:^{
        StrongSelf(self)
        [self getAryRefresh:NO];
    }];
    tv1_footer.automaticallyChangeAlpha = YES;
    self.tableView.mj_footer = tv1_footer;
    
    [self.tableView.mj_header beginRefreshing];
}

-(void)caculeate:(MessageCenterResponseModel *)model refresh:(BOOL)refresh{
    NSArray *ary = model.data;
    NSMutableArray *tempAry = [NSMutableArray new];
    for (EvaListItem *item in ary) {
        MessageCenterLayout *layout = [[MessageCenterLayout alloc]init];
        layout.item = item;
        [tempAry addObject:layout];
    }
    if (refresh) {
        self.ary = tempAry;
    }else{
        [self.ary addObjectsFromArray:tempAry];
    }
}

- (void)getAryRefresh:(BOOL)refresh{
    if (refresh) {
        self.page = 1;
    }else{
        self.page ++;
    }
    NSDictionary *parameters = @{@"page":[NSString stringWithFormat:@"%zd",self.page],
                                 @"pageCount":[NSString stringWithFormat:@"%d",pageCount]};
    [Request startWithName:@"GET_ARTICLE_MESSAGE" param:parameters progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        MessageCenterResponseModel *model = [MessageCenterResponseModel modelWithDictionary:dic];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self caculeate:model refresh:refresh];
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([self.ary count] == 0) {
                    self.tableView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.tableView.frame.size.height) image:nil description:@"啥都木有啊···" needGoHome:NO];
                } else {
                    self.tableView.backgroundView = nil;
                }
                [self.tableView reloadData];
            });
        });
        
        [self.tableView.mj_header endRefreshing];
        if (pageCount>model.data.count) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if ([self.ary count] == 0) {
            self.tableView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.tableView.frame.size.height) image:nil description:@"啥都木有啊···" needGoHome:NO];
        } else {
            self.tableView.backgroundView = nil;
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }];
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.ary.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageCenterLayout *layout = self.ary[indexPath.row];
    return layout.hight;
}

static NSString *const reuseIndentifier = @"cell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIndentifier];
    if (!cell) {
        cell = [[MessageCenterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIndentifier];
    }
    MessageCenterLayout *layout = self.ary[indexPath.row];
    cell.layout = layout;
    EvaListItem *item = layout.item;
    WeakSelf(self)
    cell.meTapAction = ^{
        StrongSelf(self)
        if (item.userId) {
            UserArticleCommentsViewController *userArticleCommentsVC = [[UserArticleCommentsViewController alloc]init];
            userArticleCommentsVC.userId = item.userId;
            [self.navigationController pushViewController:userArticleCommentsVC animated:YES];
        }
    };
    cell.otherUserTapAction = ^{
        StrongSelf(self)
        if (item.reply.userId) {
            UserArticleCommentsViewController *userArticleCommentsVC = [[UserArticleCommentsViewController alloc]init];
            userArticleCommentsVC.userId = item.reply.userId;
            [self.navigationController pushViewController:userArticleCommentsVC animated:YES];
        }
    };
    cell.articleView.articleTapAction = ^{
        StrongSelf(self)
        if (item.linkType && item.params) {
            SegueModel *segue = [SegueModel modelWithDestination:(SegueDestination)item.linkType paramRawData:item.params];
            [SegueMaster makeSegueWithModel:segue fromController:self];
        }
    };
    
    return cell;
}


@end
