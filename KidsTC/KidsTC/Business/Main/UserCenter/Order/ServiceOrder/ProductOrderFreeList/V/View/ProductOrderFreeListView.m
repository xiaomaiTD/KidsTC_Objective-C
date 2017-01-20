//
//  ProductOrderFreeListView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/5.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderFreeListView.h"

#import "Colours.h"
#import "NSString+Category.h"
#import "RecommendProductOrderListView.h"
#import "RecommendDataManager.h"

#import "RefreshHeader.h"
#import "RefreshFooter.h"
#import "KTCEmptyDataView.h"
#import "ProductOrderFreeListHeader.h"

#import "ProductOrderFreeListBaseCell.h"
#import "ProductOrderFreeListCell.h"
#import "ProductOrderFreeListTimeCell.h"
#import "ProductOrderFreeListAddressCell.h"
#import "ProductOrderFreeListBtnsCell.h"

static NSString *const BaseCellID = @"ProductOrderFreeListBaseCell";
static NSString *const ListCellID = @"ProductOrderFreeListCell";
static NSString *const TimeCellID = @"ProductOrderFreeListTimeCell";
static NSString *const AddressCellID = @"ProductOrderFreeListAddressCell";
static NSString *const BtnsCellID = @"ProductOrderFreeListBtnsCell";

@interface ProductOrderFreeListView ()<ProductOrderFreeListBaseCellDelegate,UITableViewDelegate,UITableViewDataSource,RecommendProductViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) RecommendProductOrderListView *footerView;
@property (nonatomic, strong) NSArray<NSArray<ProductOrderFreeListBaseCell *> *> *sections;
@end

@implementation ProductOrderFreeListView

- (RecommendProductOrderListView *)footerView {
    if (!_footerView) {
        _footerView = [[NSBundle mainBundle] loadNibNamed:@"RecommendProductOrderListView" owner:self options:nil].firstObject;
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

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)setupTableView {
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 60;
    tableView.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
    [self addSubview:tableView];
    self.tableView = tableView;
    
    [tableView registerNib:[UINib nibWithNibName:@"ProductOrderFreeListBaseCell" bundle:nil] forCellReuseIdentifier:BaseCellID];
    [tableView registerNib:[UINib nibWithNibName:@"ProductOrderFreeListCell" bundle:nil] forCellReuseIdentifier:ListCellID];
    [tableView registerNib:[UINib nibWithNibName:@"ProductOrderFreeListTimeCell" bundle:nil] forCellReuseIdentifier:TimeCellID];
    [tableView registerNib:[UINib nibWithNibName:@"ProductOrderFreeListAddressCell" bundle:nil] forCellReuseIdentifier:AddressCellID];
    [tableView registerNib:[UINib nibWithNibName:@"ProductOrderFreeListBtnsCell" bundle:nil] forCellReuseIdentifier:BtnsCellID];
    
    ProductOrderFreeListHeader *header = [[NSBundle mainBundle] loadNibNamed:@"ProductOrderListHeader" owner:self options:nil].firstObject;
    header.frame = CGRectMake(0, 0, SCREEN_WIDTH, 28);
    header.hidden = YES;
    header.actionBlock = ^(){
        tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.001)];
    };
    tableView.tableHeaderView = header;
    
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
    if ([self.delegate respondsToSelector:@selector(productOrderFreeListView:actionType:value:)]) {
        [self.delegate productOrderFreeListView:self actionType:ProductOrderFreeListViewActionTypeLoadData value:@(refresh)];
    }
}

- (void)reloadData {
    [self.tableView reloadData];
}

- (void)beginRefreshing {
    [self.tableView.mj_header beginRefreshing];
}

- (void)dealWithUI:(NSUInteger)loadCount isRecommend:(BOOL)isRecommend {
    
    if (self.items.count>0) {
        self.tableView.tableHeaderView.hidden = NO;
    }
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    if (!isRecommend) {
        if (loadCount<ProductOrderFreeListPageCount) {
            self.noMoreOrderListData = YES;
        }
    }else{
        if (loadCount<ProductOrderFreeListPageCount) {
            self.noMoreRecommendData = YES;
        }
    }
    
    [self resetFooterView];
    
    [self.tableView reloadData];
    
    if (self.noMoreRecommendData) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    NSArray<RecommendProduct *> *recommends = [[RecommendDataManager shareRecommendDataManager] recommendProductsWithType:RecommendProductTypeOrderList];
    if (self.items.count<1 && recommends.count<1) {
        self.tableView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
                                                                          image:nil description:@"啥都没有啊…"
                                                                     needGoHome:NO];
    }else self.tableView.backgroundView = nil;
}

- (void)setItems:(NSArray<ProductOrderFreeListItem *> *)items {
    _items = items;
    [self setupSections];
}

- (__kindof UITableViewCell *)cellWithID:(NSString *)ID {
    return [self.tableView dequeueReusableCellWithIdentifier:ID];
}

- (void)setupSections {
    NSMutableArray *sections = [NSMutableArray array];
    [self.items enumerateObjectsUsingBlock:^(ProductOrderFreeListItem *obj, NSUInteger idx, BOOL *stop) {
        NSMutableArray *section = [NSMutableArray array];
        
        ProductOrderFreeListCell *listCell = [self cellWithID:ListCellID];
        if (listCell) [section addObject:listCell];
        
        if ([obj.useTimeStr isNotNull]) {
            ProductOrderFreeListTimeCell *timeCell = [self cellWithID:TimeCellID];
            if (timeCell) [section addObject:timeCell];
        }
        if (obj.storeInfo) {
            ProductOrderFreeListAddressCell *addressCell = [self cellWithID:AddressCellID];
            if (addressCell) [section addObject:addressCell];
        }
        if (obj.btns.count>0) {
            ProductOrderFreeListBtnsCell *btnsCell = [self cellWithID:BtnsCellID];
            if (btnsCell) [section addObject:btnsCell];
        }
        
        if (section.count>0) [sections addObject:section];
    }];
    self.sections = [NSArray arrayWithArray:sections];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section<self.sections.count) {
        return self.sections[section].count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section<self.sections.count) {
        NSArray<ProductOrderFreeListBaseCell *> *rows = self.sections[section];
        if (row<rows.count) {
            ProductOrderFreeListBaseCell *cell = rows[row];
            cell.delegate = self;
            if (section<self.items.count) {
                cell.item = self.items[section];
            }
            return cell;
        }
    }
    return [self cellWithID:BaseCellID];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSInteger section = indexPath.section;
    if (section < self.items.count) {
        ProductOrderFreeListItem *item = self.items[section];
        if ([self.delegate respondsToSelector:@selector(productOrderFreeListView:actionType:value:)]) {
            [self.delegate productOrderFreeListView:self actionType:ProductOrderFreeListViewActionTypeSegue value:item.segueModel];
        }
    }
}

#pragma mark - ProductOrderFreeListCellDelegate

- (void)productOrderFreeListBaseCell:(ProductOrderFreeListCell *)cell actionType:(ProductOrderFreeListBaseCellActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(productOrderFreeListView:actionType:value:)]) {
        [self.delegate productOrderFreeListView:self actionType:(ProductOrderFreeListViewActionType)type value:value];
    }
}

#pragma mark - RecommendProductViewDelegate

- (void)recommendProductView:(RecommendProductView *)view actionType:(RecommendProductViewActionType)type value:(id)value {
    switch (type) {
        case RecommendProductViewActionTypeSegue:
        {
            if ([self.delegate respondsToSelector:@selector(productOrderFreeListView:actionType:value:)]) {
                [self.delegate productOrderFreeListView:self actionType:ProductOrderFreeListViewActionTypeSegue value:value];
            }
        }
            break;
        default:
            break;
    }
}

- (void)dealloc {
    TCLog(@"ProductOrderListView挂掉了...");
}

@end
