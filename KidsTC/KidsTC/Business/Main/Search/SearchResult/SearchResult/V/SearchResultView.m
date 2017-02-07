//
//  SearchResultView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchResultView.h"
#import "Colours.h"
#import "RefreshHeader.h"
#import "RefreshFooter.h"
#import "KTCEmptyDataView.h"

#import "SearchResultProductHeader.h"
#import "SearchResultProductFooter.h"
#import "SearchResultProductSmallCell.h"
#import "SearchResultProductLargeCell.h"

#import "SearchResultStoreHeader.h"
#import "SearchResultStoreFooter.h"
#import "SearchResultStoreProductCell.h"

static NSString *const CellID = @"UITableViewCell";

static NSString *const ProductHeaderID = @"SearchResultProductHeader";
static NSString *const ProductFooterID = @"SearchResultProductFooter";
static NSString *const SmallCellID = @"SearchResultProductSmallCell";
static NSString *const LargeCellID = @"SearchResultProductLargeCell";

static NSString *const StoreHeaderID = @"SearchResultStoreHeader";
static NSString *const StoreFooterID = @"SearchResultStoreFooter";
static NSString *const StoreProductCellID = @"SearchResultStoreProductCell";

@interface SearchResultView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation SearchResultView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _showType = SearchResultProductViewShowTypeSmall;
        [self setupTableView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tableView.frame = self.bounds;
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 131;
    tableView.estimatedSectionFooterHeight = 10;
    tableView.estimatedSectionHeaderHeight = 87;
    tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellID];
    [tableView registerNib:[UINib nibWithNibName:@"SearchResultStoreHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:StoreHeaderID];
    [tableView registerNib:[UINib nibWithNibName:@"SearchResultStoreFooter" bundle:nil] forHeaderFooterViewReuseIdentifier:StoreFooterID];
    [tableView registerNib:[UINib nibWithNibName:@"SearchResultStoreProductCell" bundle:nil] forCellReuseIdentifier:StoreProductCellID];
    [tableView registerNib:[UINib nibWithNibName:@"SearchResultProductHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:ProductHeaderID];
    [tableView registerNib:[UINib nibWithNibName:@"SearchResultProductFooter" bundle:nil] forHeaderFooterViewReuseIdentifier:ProductFooterID];
    [tableView registerNib:[UINib nibWithNibName:@"SearchResultProductSmallCell" bundle:nil] forCellReuseIdentifier:SmallCellID];
    [tableView registerNib:[UINib nibWithNibName:@"SearchResultProductLargeCell" bundle:nil] forCellReuseIdentifier:LargeCellID];
    [self addSubview:tableView];
    self.tableView = tableView;
    
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
    if ([self.delegate respondsToSelector:@selector(searchResultView:actionType:value:)]) {
        [self.delegate searchResultView:self actionType:SearchResultViewActionTypeLoadData value:@(refresh)];
    }
}

- (void)dealWithUI:(NSUInteger)loadCount {
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    if (loadCount<1) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    if (self.items.count<1) {
        self.tableView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)
                                                                          image:nil description:@"啥都没有啊…"
                                                                     needGoHome:NO];
    }else self.tableView.backgroundView = nil;
}

- (void)setShowType:(SearchResultProductViewShowType)showType {
    _showType = showType;
    [self.tableView reloadData];
}

- (void)beginRefreshing {
    [self.tableView.mj_header beginRefreshing];
}

- (void)reloadData {
    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    switch (_searchType) {
        case SearchTypeProduct:
        {
            return 1;
        }
            break;
        case SearchTypeStore:
        {
            return self.items.count;
        }
            break;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (_searchType) {
        case SearchTypeProduct:
        {
            return self.items.count;
        }
            break;
        case SearchTypeStore:
        {
            if (section<self.items.count) {
                SearchResultStore *store = self.items[section];
                if ([store isKindOfClass:[SearchResultStore class]]) {
                    return store.products.count;
                } return 0;
            }
        }
            break;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.items.count<1) {
        return nil;
    }
    switch (_searchType) {
        case SearchTypeProduct:
        {
            SearchResultProductHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ProductHeaderID];
            switch (_showType) {
                case SearchResultProductViewShowTypeSmall:
                {
                    header.bgView.backgroundColor = [UIColor whiteColor];
                }
                    break;
                case SearchResultProductViewShowTypeLarge:
                {
                    header.bgView.backgroundColor = [UIColor clearColor];
                }
                    break;
            }
            return header;
        }
            break;
        case SearchTypeStore:
        {
            SearchResultStoreHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:StoreHeaderID];
            if (section<self.items.count) {
                SearchResultStore *store = self.items[section];
                header.store = store;
                header.actionBlock = ^(SearchResultStore *store){
                    if ([self.delegate respondsToSelector:@selector(searchResultView:actionType:value:)]) {
                        [self.delegate searchResultView:self actionType:SearchResultViewActionTypeSegue value:store.segueModel];
                    }
                };
            }
            return header;
        }
            break;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.items.count<1) {
        return nil;
    }
    switch (_searchType) {
        case SearchTypeProduct:
        {
            SearchResultProductFooter *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ProductFooterID];
            return footer;
        }
            break;
        case SearchTypeStore:
        {
            SearchResultStoreFooter *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:StoreFooterID];
            return footer;
        }
            break;
        default:
            break;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    switch (_searchType) {
        case SearchTypeProduct:
        {
            SearchResultProduct *product;
            if (row<self.items.count) {
                product = self.items[row];
            }
            switch (_showType) {
                case SearchResultProductViewShowTypeSmall:
                {
                    SearchResultProductSmallCell *smallCell = [tableView dequeueReusableCellWithIdentifier:SmallCellID];
                    smallCell.product = product;
                    cell = smallCell;
                }
                    break;
                case SearchResultProductViewShowTypeLarge:
                {
                    SearchResultProductLargeCell *largeCell = [tableView dequeueReusableCellWithIdentifier:LargeCellID];
                    largeCell.product = product;
                    cell = largeCell;
                }
                    break;
            }
        }
            break;
        case SearchTypeStore:
        {
            SearchResultStoreProductCell *storeProductCell = [tableView dequeueReusableCellWithIdentifier:StoreProductCellID];
            if (section<self.items.count) {
                SearchResultStore *store = self.items[section];
                NSArray<SearchResultStoreProduct *> *products = store.products;
                if (row<products.count) {
                    SearchResultStoreProduct *storeProduct = products[row];
                    storeProductCell.storeProduct = storeProduct;
                }
            }
            cell = storeProductCell;
        }
            break;
    }
    if (!cell) cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    switch (_searchType) {
        case SearchTypeProduct:
        {
            if (row<self.items.count) {
                SearchResultProduct *product = self.items[row];
                if ([self.delegate respondsToSelector:@selector(searchResultView:actionType:value:)]) {
                    [self.delegate searchResultView:self actionType:SearchResultViewActionTypeSegue value:product.segueModel];
                }
            }
        }
            break;
        case SearchTypeStore:
        {
            if (section<self.items.count) {
                SearchResultStore *store = self.items[section];
                NSArray<SearchResultStoreProduct *> *products = store.products;
                if (row<products.count) {
                    SearchResultStoreProduct *storeProduct = products[row];
                    if ([self.delegate respondsToSelector:@selector(searchResultView:actionType:value:)]) {
                        [self.delegate searchResultView:self actionType:SearchResultViewActionTypeSegue value:storeProduct.segueModel];
                    }
                }
            }
        }
            break;
    }
    
}


@end
