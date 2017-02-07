//
//  UserArticleCommentsViewController.m
//  KidsTC
//
//  Created by zhanping on 4/27/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "UserArticleCommentsViewController.h"
#import "ArticleCommentModel.h"
#import "UserArticleCommentsHeader.h"
#import "UserArticleCommentsCell.h"
#import "UserArticleCommentsLayout.h"
#import "SegueMaster.h"
#import "GHeader.h"
#import "KTCEmptyDataView.h"
#import "UIImage+Category.h"
#import "UIImageView+WebCache.h"
#import "NSString+Category.h"
#import "BuryPointManager.h"

#define pageCount 10

@interface UserArticleCommentsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, weak) UserArticleCommentsHeader *header;
@property (nonatomic, strong) NSMutableArray *ary;

@end

@implementation UserArticleCommentsViewController


- (UserArticleCommentsHeader *)header{
    if (!_header) {
        UserArticleCommentsHeader *header = [[UserArticleCommentsHeader alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240)];
        self.tableView.tableHeaderView = header;
        _header = header;
    }
    return _header;
}

- (NSMutableArray *)ary{
    if (!_ary) {
        _ary = [NSMutableArray new];
    }
    return _ary;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self scrollViewDidScroll:self.tableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageId = 10704;
    if ([self.userId isNotNull]) {
        self.trackParams = @{@"uid":self.userId};
    }
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationItem.title = @"评论列表";
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    
    WeakSelf(self)
    RefreshHeader *tv1_header = [RefreshHeader headerWithRefreshingBlock:^{
        StrongSelf(self)
        [self getAryRefresh:YES];
    }];
    tv1_header.automaticallyChangeAlpha = YES;
    self.tableView.mj_header = tv1_header;
    
    RefreshFooter *tv1_footer = [RefreshFooter footerWithRefreshingBlock:^{
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
    NSString *userId = [self.userId isNotNull]?self.userId:@"";
    NSDictionary *parameters = @{@"page":[NSString stringWithFormat:@"%ld",self.page],
                                 @"pageCount":[NSString stringWithFormat:@"%d",pageCount],
                                 @"userId":userId};
    [Request startWithName:@"GET_USER_ARTICLE_COMMENT" param:parameters progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        UserArticleCommentsResponseModel *model = [UserArticleCommentsResponseModel modelWithDictionary:dic];
        if (refersh) {
            [self.header.headImageView sd_setImageWithURL:[NSURL URLWithString:model.data.header.headUrl] placeholderImage:PLACEHOLDERIMAGE_SMALL];
            self.header.userInfoLabel.text = model.data.header.userName;
        }
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self caculateLayout:model.data refresh:refersh];
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([self.ary count] == 0) {
                    self.tableView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.tableView.frame.size.height) image:nil description:@"啥都木有啊···" needGoHome:YES];
                } else {
                    self.tableView.backgroundView = nil;
                }
                [self.tableView reloadData];
                [self scrollViewDidScroll:self.tableView];
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

- (void)caculateLayout:(UAData *)data refresh:(BOOL)refresh{
    NSArray *list = data.comments;
    NSMutableArray *ary = [NSMutableArray new];
    for (EvaListItem *item in list) {
        UserArticleCommentsLayout *layout = [[UserArticleCommentsLayout alloc]init];
        layout.item = item;
        [ary addObject:layout];
    }
    if (refresh) {
        self.ary = ary;
    }else{
        [self.ary addObjectsFromArray:ary];
    }
}
- (void)changePriseStateAction:(NSIndexPath *)indexPath{
    
    UserArticleCommentsLayout *layout = self.ary[indexPath.row];
    EvaListItem *item = layout.item;
    
    NSString *isPrasize = item.isPraised? @"0":@"1";
    NSString *articleSysNo = [item.articleSysNo isNotNull]?item.articleSysNo:@"";
    NSString *commentSysNO = [item.commentSysNo isNotNull]?item.commentSysNo:@"";
    NSDictionary *parameters = @{@"relationSysNo":articleSysNo,
                                 @"commentSysNo":commentSysNO,
                                 @"isPraise":isPrasize};
    [Request startWithName:@"COMMENT_PRAISE" param:parameters progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        item.isPraised = !item.isPraised;
        if (item.isPraised) {
            item.praiseCount ++;
        }else{
            item.praiseCount --;
        }
        //[self.tableView reloadData];
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    NSDictionary *params = @{@"id":articleSysNo};
    [BuryPointManager trackEvent:@"event_click_news_evalike" actionId:21301 params:params];
}

#pragma mark - Table view data source

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.naviColor = [COLOR_PINK colorWithAlphaComponent:scrollView.contentOffset.y/64];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.ary.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserArticleCommentsLayout *layout = self.ary[indexPath.row];
    return layout.hight;
}

static NSString *const reuserIndetifier = @"cell";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserArticleCommentsCell *cell = [tableView dequeueReusableCellWithIdentifier:reuserIndetifier];
    if (!cell) {
        cell = [[UserArticleCommentsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuserIndetifier];
        //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UserArticleCommentsLayout *layout = self.ary[indexPath.row];
    cell.layout = layout;
    __weak typeof(self) weakSelf = self;
    cell.contentLabelView.priseBtnActionBlock = ^(NSString *commentSysNo){
    UserArticleCommentsViewController *self = weakSelf;
        [self changePriseStateAction:indexPath];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UserArticleCommentsLayout *layout = self.ary[indexPath.row];
    EvaListItem *item = layout.item;
    
    SegueModel *segue = [SegueModel modelWithDestination:(SegueDestination)item.linkType paramRawData:item.params];
    [SegueMaster makeSegueWithModel:segue fromController:self];
}



@end
