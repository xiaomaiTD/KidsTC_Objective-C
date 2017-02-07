//
//  ArticleMoreCommentsViewController.m
//  KidsTC
//
//  Created by zhanping on 4/29/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "ArticleMoreCommentsViewController.h"
#import "ArticleCommentModel.h"
#import "ArticleCommentLayout.h"
#import "ArticleCommentCell.h"
#import "UserArticleCommentsViewController.h"
#import "GHeader.h"
#import "KTCEmptyDataView.h"
#import "NSString+Category.h"

#define pageCount 10
@interface ArticleMoreCommentsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *ary;
@end

@implementation ArticleMoreCommentsViewController

- (NSMutableArray *)ary{
    if (!_ary) {
        _ary = [NSMutableArray new];
    }
    return _ary;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的评论";
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
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
- (void)getAryRefresh:(BOOL)refersh{
    
    if (refersh) {
        self.page = 1;
    }else{
        self.page ++;
    }
    NSString *relationId = [self.relationId isNotNull]?self.relationId:@"";
    NSString *userId = [self.userId isNotNull]?self.userId:@"";
    NSDictionary *parameters = @{@"page":[NSString stringWithFormat:@"%zd",self.page],
                                 @"pageCount":[NSString stringWithFormat:@"%zd",pageCount],
                                 @"relationId":relationId,
                                 @"userId":userId};
    [Request startWithName:@"GET_USER_ARTICLE_COMMENT" param:parameters progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        UserArticleCommentsResponseModel *model = [UserArticleCommentsResponseModel modelWithDictionary:dic];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self caculateLayout:model refresh:refersh];
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([self.ary count] == 0) {
                    self.tableView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.tableView.frame.size.height) image:nil description:@"啥都木有啊···" needGoHome:YES];
                } else {
                    self.tableView.backgroundView = nil;
                }
                [self.tableView reloadData];
            });
        });
        [self.tableView.mj_header endRefreshing];
        if (1>model.data.comments.count) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if ([self.ary count] == 0) {
            self.tableView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.tableView.frame.size.height) image:nil description:@"啥都木有啊···" needGoHome:YES];
        } else {
            self.tableView.backgroundView = nil;
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }];
}
- (void)caculateLayout:(UserArticleCommentsResponseModel *)model refresh:(BOOL)refresh{
    NSArray *comments = model.data.comments;
    NSMutableArray *myAry = [NSMutableArray new];
    for (EvaListItem *item in comments) {
        ArticleCommentLayout *layout = [[ArticleCommentLayout alloc]init];
        layout.isAboutMe = YES;
        layout.item = item;
        [myAry addObject:layout];
    }
    if (refresh) {
        self.ary = myAry;
    }else{
        [self.ary addObjectsFromArray:myAry];
    }
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.self.ary.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ArticleCommentLayout *layout = self.ary[indexPath.row];
    CGFloat hight = layout.isStyleOpen?layout.openHight:layout.normalHight;
    return hight;
}

static NSString *const reuseIdentifier = @"reuseIdentifier";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ArticleCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[ArticleCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    ArticleCommentLayout *layout = self.ary[indexPath.row];
    cell.layout = layout;
    __weak typeof(self) weakSelf = self;
    cell.nameActionBlock = ^(NSString *userId){
        ArticleMoreCommentsViewController *self = weakSelf;
        
        UserArticleCommentsViewController *userArticleCommentsVC = [[UserArticleCommentsViewController alloc]init];
        userArticleCommentsVC.userId = userId;
        [self.navigationController pushViewController:userArticleCommentsVC animated:YES];
    };
    cell.changeStyleActionBlock = ^{
        ArticleMoreCommentsViewController *self = weakSelf;
        layout.isStyleOpen = !layout.isStyleOpen;
        
        [self.tableView reloadData];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


@end
