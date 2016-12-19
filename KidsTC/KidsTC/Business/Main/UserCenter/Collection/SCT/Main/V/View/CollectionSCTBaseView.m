//
//  CollectionSCTBaseView.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectionSCTBaseView.h"
#import "Colours.h"
#import "RefreshHeader.h"
#import "RefreshFooter.h"
#import "KTCEmptyDataView.h"

static NSString *const ID = @"UITableViewCell";

@implementation CollectionSCTBaseView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupTableView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tableView.frame = self.bounds;
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 60;
    tableView.estimatedSectionHeaderHeight = 100;
    tableView.estimatedSectionFooterHeight = 40;
    tableView.backgroundColor = [UIColor colorFromHexString:@"EEEEEE"];
    [self addSubview:tableView];
    self.tableView = tableView;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    [self setupMJ];
}

- (void)setupMJ {
    
    WeakSelf(self);
    RefreshHeader *header = [RefreshHeader headerWithRefreshingBlock:^{
        StrongSelf(self);
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
    if ([self.delegate respondsToSelector:@selector(collectionSCTBaseView:actionType:value:completion:)]) {
        [self.delegate collectionSCTBaseView:self actionType:CollectionSCTBaseViewActionTypeLoadData value:@(refresh) completion:nil];
    }
}

- (void)dealWithUI:(NSUInteger)loadCount {
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    if (loadCount<CollectionSCTPageCount) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    if (self.items.count<1) {
        self.tableView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
                                                                          image:nil description:@"啥都没有啊…"
                                                                     needGoHome:NO];
    }else self.tableView.backgroundView = nil;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
