//
//  MyTracksView.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "MyTracksView.h"
#import "RefreshHeader.h"
#import "RefreshFooter.h"
#import "KTCEmptyDataView.h"

#import "MyTracksDateItem.h"

#import "MyTracksHeader.h"
#import "MyTracksCell.h"
#import "MyTracksFooter.h"

static NSString *const HeadID = @"MyTracksHeader";
static NSString *const CellID = @"MyTracksCell";
static NSString *const FootID = @"MyTracksFooter";

@interface MyTracksView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) BOOL isEditing;
@end

@implementation MyTracksView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupTableView];
    }
    return self;
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 320;
    tableView.estimatedSectionHeaderHeight = 44;
    tableView.estimatedSectionFooterHeight = 44;
    [self addSubview:tableView];
    self.tableView = tableView;
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    tableView.tableFooterView = footer;
    
    [tableView registerNib:[UINib nibWithNibName:@"MyTracksHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:HeadID];
    [tableView registerNib:[UINib nibWithNibName:@"MyTracksCell" bundle:nil] forCellReuseIdentifier:CellID];
    [tableView registerNib:[UINib nibWithNibName:@"MyTracksFooter" bundle:nil] forHeaderFooterViewReuseIdentifier:FootID];
    
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
    if ([self.delegate respondsToSelector:@selector(myTracksView:actionType:value:completion:)]) {
        [self.delegate myTracksView:self actionType:MyTracksViewActionTypeLoadData value:@(refresh) completion:nil];
    }
}

- (void)dealWithUI:(NSUInteger)loadCount {
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    if (loadCount<MyTracksPageCount) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    if (self.items.count<1) {
        self.tableView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
                                                                          image:nil description:@"啥都没有啊…"
                                                                     needGoHome:NO];
    }else self.tableView.backgroundView = nil;
}

- (void)edit:(BOOL)edit {
    self.isEditing = edit;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section<self.items.count) {
        MyTracksDateItem *dateItem = self.items[section];
        return dateItem.BrowseHistoryLst.count;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MyTracksHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeadID];
    if (section<self.items.count) {
        MyTracksDateItem *dateItem = self.items[section];
        header.item = dateItem;
    }
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    MyTracksCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (section<self.items.count) {
        MyTracksDateItem *dateItem = self.items[section];
        NSArray<MyTracksItem *> *list = dateItem.BrowseHistoryLst;
        if (row<list.count) {
            cell.item = list[row];
            cell.deleteBtn.hidden = !self.isEditing;
            cell.deleteAction = ^void(){
                [self deleteAtIndexPath:indexPath];
            };
        }
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    MyTracksFooter *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:FootID];
    return footer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section >= self.items.count) return;
    MyTracksDateItem *dateItem = self.items[section];
    NSArray<MyTracksItem *> *list = dateItem.BrowseHistoryLst;
    if (row >= list.count) return;
    MyTracksItem *item = list[row];
    if ([self.delegate respondsToSelector:@selector(myTracksView:actionType:value:completion:)]) {
        [self.delegate myTracksView:self actionType:MyTracksViewActionTypeSegue value:item.segueModel completion:nil];
    }
}

- (void)deleteAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section >= self.items.count) return;
    MyTracksDateItem *dateItem = self.items[section];
    NSArray<MyTracksItem *> *list = dateItem.BrowseHistoryLst;
    if (row >= list.count) return;
    MyTracksItem *item = list[row];
    if ([self.delegate respondsToSelector:@selector(myTracksView:actionType:value:completion:)]) {
        [self.delegate myTracksView:self actionType:MyTracksViewActionTypeDelete value:item.recordSysNo completion:^(id value){
            BOOL success = [value boolValue];
            if (!success) return;
            NSMutableArray *listAry = [NSMutableArray arrayWithArray:list];
            if (row >= listAry.count) return;
            [listAry removeObjectAtIndex:row];
            if (listAry.count<1) {
                NSMutableArray *dateItems = [NSMutableArray arrayWithArray:self.items];
                if (section<dateItems.count) {
                    [dateItems removeObjectAtIndex:section];
                    self.items = [NSArray arrayWithArray:dateItems];
                }
            }else{
                dateItem.BrowseHistoryLst = [NSArray arrayWithArray:listAry];
            }
            [self.tableView reloadData];
        }];
    }
}

@end
