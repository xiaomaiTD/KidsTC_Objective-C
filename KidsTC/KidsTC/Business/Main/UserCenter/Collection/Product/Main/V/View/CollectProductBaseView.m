//
//  CollectProductBaseView.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/9.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectProductBaseView.h"
#import "Colours.h"
#import "RefreshHeader.h"
#import "RefreshFooter.h"
#import "KTCEmptyDataView.h"
#import "RecommendProductCollectProductView.h"
#import "RecommendDataManager.h"

static NSString *const ID = @"UITableViewCell";

@interface CollectProductBaseView ()<RecommendProductViewDelegate>
@property (nonatomic, strong) RecommendProductCollectProductView *footerView;
@end

@implementation CollectProductBaseView

- (RecommendProductCollectProductView *)footerView {
    if (!_footerView) {
        _footerView = [[NSBundle mainBundle] loadNibNamed:@"RecommendProductCollectProductView" owner:self options:nil].firstObject;
        _footerView.delegate = self;
    }
    return _footerView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupTableView];
        
    }
    return self;
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-104) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor colorFromHexString:@"EEEEEE"];
    tableView.estimatedRowHeight = 300;
    [self addSubview:tableView];
    self.tableView = tableView;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    [self resetFooterView];
    
    [self setupMJ];
}

- (void)resetFooterView {
    [self.footerView reloadData];
    self.footerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, [self.footerView contentHeight]);
    self.tableView.tableFooterView = self.footerView;
}

- (void)setupMJ {
    
    WeakSelf(self);
    RefreshHeader *header = [RefreshHeader headerWithRefreshingBlock:^{
        StrongSelf(self);
        self.noMoreCollectData = NO;
        self.noMoreRecommendData = NO;
        [self.footerView nilData];
        [self resetFooterView];
        [self loadData:YES];
    }];
    self.tableView.mj_header = header;
    RefreshFooter *footer = [RefreshFooter footerWithRefreshingBlock:^{
        StrongSelf(self);
        [self loadData:NO];
    }];
    self.tableView.mj_footer = footer;
    
    [self.tableView.mj_header beginRefreshing];
}

- (void)loadData:(BOOL)refresh {
    if ([self.delegate respondsToSelector:@selector(collectProductBaseView:actionType:value:completion:)]) {
        [self.delegate collectProductBaseView:self actionType:CollectProductBaseViewActionTypeLoadData value:@(refresh) completion:nil];
    }
}

- (void)setItems:(NSArray *)items {
    _items = items;
}

- (void)dealWithUI:(NSUInteger)loadCount isRecommend:(BOOL)isRecommend {
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    if (!isRecommend) {
        if (loadCount<CollectProductPageCount) {
            self.noMoreCollectData = YES;
        }
    }else{
        if (loadCount<CollectProductPageCount) {
            self.noMoreRecommendData = YES;
        }
    }
    
    [self resetFooterView];
    
    [self.tableView reloadData];
    
    if (self.noMoreRecommendData) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    if (self.items.count<1) {
        self.tableView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
                                                                          image:nil description:@"啥都没有啊…"
                                                                     needGoHome:NO];
    }else self.tableView.backgroundView = nil;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)setEditing:(BOOL)editing {
    _editing = editing;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section == 0 ? 10 : 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - RecommendProductViewDelegate

- (void)recommendProductView:(RecommendProductView *)view actionType:(RecommendProductViewActionType)type value:(id)value {
    switch (type) {
        case RecommendProductViewActionTypeSegue:
        {
            if ([self.delegate respondsToSelector:@selector(collectProductBaseView:actionType:value:completion:)]) {
                [self.delegate collectProductBaseView:self actionType:CollectProductBaseViewActionTypeSegue value:value completion:nil];
            }
        }
            break;
        default:
            break;
    }
}

@end
