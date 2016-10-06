//
//  ArticleColumnViewController.m
//  KidsTC
//
//  Created by zhanping on 9/2/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ArticleColumnViewController.h"

#import "ArticleColumnModel.h"
#import "GHeader.h"
#import "SegueMaster.h"
#import "NSString+Category.h"

#import "ArticleColumnHeader.h"

#import "ArticleHomeTableView.h"

#define PAGE_COUNT 10


@interface ArticleColumnViewController ()<ArticleHomeTableViewDelegate,ArticleColumnHeaderDelegate>
@property (nonatomic, weak  ) ArticleHomeTableView *tableView;
@property (nonatomic, assign) NSUInteger     page;
@property (nonatomic, strong) ArticleColumnInfo *info;
@property (nonatomic, strong) NSArray<NSArray<ArticleHomeItem *> *> *sections;

@property (nonatomic, strong) ArticleColumnHeader *header;
@end

@implementation ArticleColumnViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.header = [[[NSBundle mainBundle] loadNibNamed:@"ArticleColumnHeader" owner:self options:nil] firstObject];
    self.header.delegate = self;
    
    [self setupTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self articleHomeTableView:_tableView actionType:ArticleHomeTableViewActionTypeDidScroll value:@(_tableView.contentOffset.y)];
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
        case ArticleHomeTableViewActionTypeDidScroll:
        {
            self.naviColor = [COLOR_PINK colorWithAlphaComponent:[value floatValue]/64];
        }
            break;
    }
}

#pragma mark ArticleHomeTableViewDelegate helper

- (void)loadDataRefresh:(BOOL)refresh {
    
    self.page = refresh?1:++self.page;
    NSDictionary *param = @{@"page":@(self.page),@"pageCount":@(PAGE_COUNT),@"columnSysNo":self.columnSysNo};
    [Request startWithName:@"GET_ARTICLE_COLUMN_INFO" param:param progress:nil success:^(NSURLSessionDataTask *task, NSDictionary *dic) {
        [self loadDataSuccessRefresh:refresh model:[ArticleColumnModel modelWithDictionary:dic]];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self loadDataFailure];
    }];
}

- (void)loadDataSuccessRefresh:(BOOL)refresh model:(ArticleColumnModel *)model{
    
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
            if (refresh) {
                ArticleColumnInfo *info = model.data.info;
                if (info) self.info = info;
            }
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

- (void)setInfo:(ArticleColumnInfo *)info {
    _info = info;
    self.navigationItem.title = info.columnName;
    self.header.info = info;
    self.tableView.tableHeaderView = self.header;
}

#pragma mark - ArticleColumnHeaderDelegate

- (void)articleColumnHeaderAction:(ArticleColumnHeader *)view {
    NSString *isLike = self.info.isLiked?@"0":@"1";
    NSString *columnSysNo = [_columnSysNo isNotNull]?_columnSysNo:@"";
    NSDictionary *parameters = @{@"relationSysNo":columnSysNo,
                                 @"likeType":@"1",
                                 @"isLike":isLike};
    [Request startWithName:@"USER_LIKE_COLUMN" param:parameters progress:nil success:nil failure:nil];
}


@end
