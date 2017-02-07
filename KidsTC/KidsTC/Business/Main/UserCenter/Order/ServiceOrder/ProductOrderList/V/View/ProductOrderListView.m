//
//  ProductOrderListView.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/16.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderListView.h"
#import "Colours.h"
#import "RecommendDataManager.h"
#import "NSString+Category.h"

#import "RefreshHeader.h"
#import "RefreshFooter.h"
#import "KTCEmptyDataView.h"

#import "ProductOrderListBaseCell.h"
#import "ProductOrderListCell.h"
#import "ProductOrderListTimeCell.h"
#import "ProductOrderListAddressCell.h"
#import "ProductOrderListBtnsCell.h"

#import "ProductOrderListHeader.h"
#import "RecommendProductOrderListView.h"

static NSString *const BaseCellID = @"ProductOrderListBaseCell";
static NSString *const ListCellID = @"ProductOrderListCell";
static NSString *const TimeCellID = @"ProductOrderListTimeCell";
static NSString *const AddressCellID = @"ProductOrderListAddressCell";
static NSString *const BtnsCellID = @"ProductOrderListBtnsCell";

@interface ProductOrderListView ()<ProductOrderListBaseCellDelegate,RecommendProductViewDelegate>
@property (nonatomic, strong) RecommendProductOrderListView *footerView;
@property (nonatomic, strong) NSArray<NSArray<ProductOrderListBaseCell *> *> *sections;
@end

@implementation ProductOrderListView

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

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 60;
    tableView.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
    [self addSubview:tableView];
    self.tableView = tableView;
    [tableView registerNib:[UINib nibWithNibName:@"ProductOrderListBaseCell" bundle:nil] forCellReuseIdentifier:BaseCellID];
    [tableView registerNib:[UINib nibWithNibName:@"ProductOrderListCell" bundle:nil] forCellReuseIdentifier:ListCellID];
    [tableView registerNib:[UINib nibWithNibName:@"ProductOrderListTimeCell" bundle:nil] forCellReuseIdentifier:TimeCellID];
    [tableView registerNib:[UINib nibWithNibName:@"ProductOrderListAddressCell" bundle:nil] forCellReuseIdentifier:AddressCellID];
    [tableView registerNib:[UINib nibWithNibName:@"ProductOrderListBtnsCell" bundle:nil] forCellReuseIdentifier:BtnsCellID];
    ProductOrderListHeader *header = [[NSBundle mainBundle] loadNibNamed:@"ProductOrderListHeader" owner:self options:nil].firstObject;
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
        self.noMoreOrderListData = NO;
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
    if ([self.delegate respondsToSelector:@selector(productOrderListView:actionType:value:)]) {
        [self.delegate productOrderListView:self actionType:ProductOrderListViewActionTypeLoadData value:@(refresh)];
    }
}

- (void)beginRefreshing {
    [self.tableView.mj_header beginRefreshing];
}

- (void)reloadData {
    [self.tableView reloadData];
}

- (void)dealWithUI:(NSUInteger)loadCount isRecommend:(BOOL)isRecommend {
    self.tableView.tableHeaderView.hidden = self.items.count<1;
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    if (!isRecommend) {
        if (loadCount<1) {
            self.noMoreOrderListData = YES;
            if ([self.delegate respondsToSelector:@selector(productOrderListView:actionType:value:)]) {
                [self.delegate productOrderListView:self actionType:ProductOrderListViewActionTypeLoadData value:@(YES)];
            }
        }
    }else{
        if (loadCount<1) {
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

- (void)setItems:(NSArray<ProductOrderListItem *> *)items {
    _items = items;
    [self setupSections];
}

- (void)setupSections {
    NSMutableArray *sections = [NSMutableArray array];
    [self.items enumerateObjectsUsingBlock:^(ProductOrderListItem *obj, NSUInteger idx, BOOL *stop) {
        NSMutableArray *section = [NSMutableArray array];
        
        ProductOrderListCell *listCell = [self cellWithID:ListCellID];
        if (listCell) [section addObject:listCell];
        
        if ([obj.useTimeStr isNotNull]) {
            ProductOrderListTimeCell *timeCell = [self cellWithID:TimeCellID];
            if (timeCell) [section addObject:timeCell];
        }
        
        if ([obj.storeName isNotNull] || [obj.storeAddress isNotNull]) {
            ProductOrderListAddressCell *addressCell = [self cellWithID:AddressCellID];
            if (addressCell) [section addObject:addressCell];
        }
        
        if (obj.btns.count>0) {
            ProductOrderListBtnsCell *btnsCell = [self cellWithID:BtnsCellID];
            if (btnsCell) [section addObject:btnsCell];
        }
        
        if (section.count>0) [sections addObject:section];
    }];
    self.sections = [NSArray arrayWithArray:sections];
}

- (__kindof UITableViewCell *)cellWithID:(NSString *)ID {
    return [self.tableView dequeueReusableCellWithIdentifier:ID];
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
        NSArray<ProductOrderListBaseCell *> *rows = self.sections[section];
        if (row<rows.count) {
            ProductOrderListBaseCell *cell = rows[row];
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
        ProductOrderListItem *item = self.items[section];
        if ([self.delegate respondsToSelector:@selector(productOrderListView:actionType:value:)]) {
            [self.delegate productOrderListView:self actionType:ProductOrderListViewActionTypeSegue value:item.segueModel];
        }
    }
}

#pragma mark - ProductOrderListCellDelegate

- (void)productOrderListBaseCell:(ProductOrderListCell *)cell actionType:(ProductOrderListBaseCellActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(productOrderListView:actionType:value:)]) {
        [self.delegate productOrderListView:self actionType:(ProductOrderListViewActionType)type value:value];
    }
}

#pragma mark - RecommendProductViewDelegate

- (void)recommendProductView:(RecommendProductView *)view actionType:(RecommendProductViewActionType)type value:(id)value {
    switch (type) {
        case RecommendProductViewActionTypeSegue:
        {
            if ([self.delegate respondsToSelector:@selector(productOrderListView:actionType:value:)]) {
                [self.delegate productOrderListView:self actionType:ProductOrderListViewActionTypeSegue value:value];
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
