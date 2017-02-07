//
//  RadishMallView.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/5.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishMallView.h"
#import "RefreshHeader.h"
#import "RefreshFooter.h"
#import "KTCEmptyDataView.h"

#import "RadishMallBaseCell.h"
#import "RadishMallPlantCell.h"
#import "RadishMallItemsCell.h"
#import "RadishMallBannerCell.h"
#import "RadishMallLargeCell.h"
#import "RadishMallHotTipCell.h"
#import "RadishMallSmallCell.h"

static NSString *const BaseCellID = @"RadishMallBaseCell";
static NSString *const PlantCellID = @"RadishMallPlantCell";
static NSString *const ItemsCellID = @"RadishMallItemsCell";
static NSString *const BannerCellID = @"RadishMallBannerCell";
static NSString *const LargeCellID = @"RadishMallLargeCell";
static NSString *const HotTipCellID = @"RadishMallHotTipCell";
static NSString *const SmallCellID = @"RadishMallSmallCell";

@interface RadishMallView ()<UITableViewDelegate,UITableViewDataSource,RadishMallBaseCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation RadishMallView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
        [self setupTableView];
    }
    return self;
}

- (void)reloadData {
    [self.tableView reloadData];
}

- (void)dealWithUI:(NSUInteger)loadCount{
    
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    
    [self.tableView reloadData];
    
    if (loadCount<1) {
        [self.tableView.mj_footer endRefreshingWithNoMoreData];
    }
    if (self.data.showProducts.count<1) {
        self.tableView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:self.tableView.bounds
                                                                          image:nil description:@"啥都没有啊…"
                                                                     needGoHome:NO];
    }else self.tableView.backgroundView = nil;
}

#pragma mark - setupTableView

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor colorFromHexString:@"F7F7F7"];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.estimatedRowHeight = 100;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self addSubview:tableView];
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    
    self.tableView = tableView;
    [self registerCells];
    
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
    if ([self.delegate respondsToSelector:@selector(radishMallView:actionType:value:)]) {
        [self.delegate radishMallView:self actionType:RadishMallViewActionTypeLoadData value:@(refresh)];
    }
}

- (void)registerCells {
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishMallBaseCell" bundle:nil] forCellReuseIdentifier:BaseCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishMallPlantCell" bundle:nil] forCellReuseIdentifier:PlantCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishMallItemsCell" bundle:nil] forCellReuseIdentifier:ItemsCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishMallBannerCell" bundle:nil] forCellReuseIdentifier:BannerCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishMallLargeCell" bundle:nil] forCellReuseIdentifier:LargeCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishMallHotTipCell" bundle:nil] forCellReuseIdentifier:HotTipCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RadishMallSmallCell" bundle:nil] forCellReuseIdentifier:SmallCellID];
}

- (__kindof UITableViewCell *)cellWithID:(NSString *)cellID {
    return [self.tableView dequeueReusableCellWithIdentifier:cellID];
}

- (NSString *)cellIdWithType:(RadishMallProductType)type {
    switch (type) {
        case RadishMallProductTypePlant:
        {
            return PlantCellID;
        }
            break;
        case RadishMallProductTypeItems:
        {
            return ItemsCellID;
        }
            break;
        case RadishMallProductTypeLarge:
        {
            return LargeCellID;
        }
            break;
        case RadishMallProductTypeSmall:
        {
            return SmallCellID;
        }
            break;
        case RadishMallProductTypeBanner:
        {
            return BannerCellID;
        }
            break;
        case RadishMallProductTypeHot:
        {
            return HotTipCellID;
        }
            break;
    }
    return BaseCellID;
}

#pragma mark UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.showProducts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    NSArray<RadishMallProduct *> *showProducts = self.data.showProducts;
    if (row<showProducts.count) {
        RadishMallProduct *product = showProducts[row];
        NSString *cellId = [self cellIdWithType:product.showType];
        RadishMallBaseCell *cell = [self cellWithID:cellId];
        cell.data = self.data;
        cell.product = product;
        cell.delegate = self;
        return cell;
    }
    return [tableView dequeueReusableCellWithIdentifier:BaseCellID];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSInteger row = indexPath.row;
    NSArray<RadishMallProduct *> *showProducts = self.data.showProducts;
    if (row<showProducts.count) {
        RadishMallProduct *product = showProducts[row];
        if (!product.segueModel) return;
        if ([self.delegate respondsToSelector:@selector(radishMallView:actionType:value:)]) {
            [self.delegate radishMallView:self actionType:RadishMallViewActionTypeSegue value:product.segueModel];
        }
    }
}

#pragma mark RadishMallBaseCellDelegate

- (void)radishMallBaseCell:(RadishMallBaseCell *)cell actionType:(RadishMallBaseCellActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(radishMallView:actionType:value:)]) {
        [self.delegate radishMallView:self actionType:(RadishMallViewActionType)type value:value];
    }
}

@end
