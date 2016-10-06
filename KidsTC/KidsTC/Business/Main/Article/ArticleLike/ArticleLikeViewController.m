//
//  ArticleLikeViewController.m
//  KidsTC
//
//  Created by zhanping on 9/2/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ArticleLikeViewController.h"

#import "GHeader.h"
#import "SegueMaster.h"

#import "ArticleHomeTableView.h"

#define PAGE_COUNT 10

@interface ArticleLikeViewController ()<ArticleHomeTableViewDelegate>
@property (nonatomic, weak  ) ArticleHomeTableView *tableView;
@property (nonatomic, assign) NSUInteger page;
@property (nonatomic, strong) NSArray<NSArray<ArticleHomeItem *> *> *sections;
@end

@implementation ArticleLikeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的关注";
    [self setupTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [NotificationCenter postNotificationName:kZPTagViewWillAppearNotification object:nil];
}

- (void)setupTableView {
    ArticleHomeTableView *tableView = [[ArticleHomeTableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    tableView.cDelegate = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
    
    [_tableView beginRefreshing];
}

#pragma mark - ArticleHomeTableViewDelegate

- (void)articleHomeTableView:(ArticleHomeTableView *)tableView actionType:(ArticleHomeTableViewActionType)type value:(id)value {
    switch (type) {
        case ArticleHomeTableViewActionTypeLoadData:
        {
            [self loadDataRefresh:[value boolValue]];
        }
            break;
        case ArticleHomeTableViewActionTypeMakeSegue:
        {
            [SegueMaster makeSegueWithModel:value fromController:self];
        }
            break;
        default:break;
    }
}

- (void)loadDataRefresh:(BOOL)refresh {
    
    self.page = refresh?1:++self.page;
    NSDictionary *param = @{@"page":@(self.page),@"pageCount":@(PAGE_COUNT)};
    [Request startWithName:@"GET_USER_LIKE_ARTICLE" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [self loadDataSuccessRefresh:refresh model:[ArticleHomeModel modelWithDictionary:dic]];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self loadDataFailure];
    }];
}

- (void)loadDataSuccessRefresh:(BOOL)refresh model:(ArticleHomeModel *)model{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray<NSArray<ArticleHomeItem *> *> *sections = model.data.sections;
        if (refresh) {
            self.sections = [NSArray arrayWithArray:sections];
        }else{
            NSMutableArray *mutableSections = [NSMutableArray arrayWithArray:self.sections];
            [mutableSections addObjectsFromArray:sections];
            self.sections = [NSArray arrayWithArray:mutableSections];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dealWithLoadResult];
            if (sections.count<PAGE_COUNT) [self.tableView noMoreData];
        });
    });
}

- (void)loadDataFailure{
    [self dealWithLoadResult];
    [self.tableView noMoreData];
}

- (void)dealWithLoadResult{
    _tableView.sections = self.sections;
    [_tableView endRefresh];
    [_tableView reloadData];
}

@end
