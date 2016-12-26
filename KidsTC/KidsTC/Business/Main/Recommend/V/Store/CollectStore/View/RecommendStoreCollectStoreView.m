//
//  RecommendStoreCollectStoreView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/21.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RecommendStoreCollectStoreView.h"
#import "RecommendDataManager.h"

#import "RecommendStoreCollectStoreHeader.h"
#import "RecommendStoreCollectStoreCell.h"
#import "RecommendStoreCollectStoreFooter.h"

static NSString *const HeaderID = @"RecommendStoreCollectStoreHeader";
static NSString *const CellID = @"RecommendStoreCollectStoreCell";
static NSString *const FooterID = @"RecommendStoreCollectStoreFooter";

@interface RecommendStoreCollectStoreView ()<UITableViewDelegate,UITableViewDataSource,RecommendStoreCollectStoreHeaderDelegate,RecommendStoreCollectStoreFooterDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation RecommendStoreCollectStoreView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.estimatedSectionFooterHeight = 60;
    self.tableView.estimatedSectionHeaderHeight = 80;
    self.tableView.backgroundColor = [UIColor colorFromHexString:@"EEEEEE"];
    [self.tableView registerNib:[UINib nibWithNibName:@"RecommendStoreCollectStoreHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:HeaderID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RecommendStoreCollectStoreCell" bundle:nil] forCellReuseIdentifier:CellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"RecommendStoreCollectStoreFooter" bundle:nil] forHeaderFooterViewReuseIdentifier:FooterID];
}

- (void)setStores:(NSArray<RecommendStore *> *)stores {
    _stores = stores;
    self.hidden = _stores.count<1;
    [self.tableView reloadData];
}

- (void)reloadData {
    self.stores = [[RecommendDataManager shareRecommendDataManager] recommendStore];
}

- (CGFloat)contentHeight {
    __block CGFloat height = 39.5;
    [self.stores enumerateObjectsUsingBlock:^(RecommendStore * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        height += 81+61+obj.productLst.count*122;
    }];
    return self.stores.count>0? height:0.001;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.stores.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section<self.stores.count) {
        return self.stores[section].productLst.count;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 81;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 61;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    RecommendStoreCollectStoreHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HeaderID];
    if (section<self.stores.count) {
        header.store = self.stores[section];
        header.delegate = self;
    }
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecommendStoreCollectStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section<self.stores.count) {
        NSArray<RecommendStoreProduct *> *productLst = self.stores[section].productLst;
        if (row<productLst.count) {
            RecommendStoreProduct *storeProduct = productLst[row];
            cell.storeProduct = storeProduct;
        }
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    RecommendStoreCollectStoreFooter *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:FooterID];
    if (section<self.stores.count) {
        footer.store = self.stores[section];
        footer.delegate = self;
    }
    return footer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (section<self.stores.count) {
        NSArray<RecommendStoreProduct *> *productLst = self.stores[section].productLst;
        if (row<productLst.count) {
            RecommendStoreProduct *storeProduct = productLst[row];
            if ([self.delegate respondsToSelector:@selector(recommendStoreCollectStoreView:actionType:value:)]) {
                [self.delegate recommendStoreCollectStoreView:self actionType:RecommendStoreCollectStoreViewActionTypeSegue value:storeProduct.segueModel];
            }
        }
    }
}

#pragma mark - RecommendStoreCollectStoreHeaderDelegate

- (void)recommendStoreCollectStoreHeader:(RecommendStoreCollectStoreHeader *)header actionType:(RecommendStoreCollectStoreHeaderActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(recommendStoreCollectStoreView:actionType:value:)]) {
        [self.delegate recommendStoreCollectStoreView:self actionType:(RecommendStoreCollectStoreViewActionType)type value:value];
    }
}

#pragma mark - RecommendStoreCollectStoreFooterDelegate

- (void)recommendStoreCollectStoreFooter:(RecommendStoreCollectStoreFooter *)footer actionType:(RecommendStoreCollectStoreFooterActionType)type value:(id)value {
    if ([self.delegate respondsToSelector:@selector(recommendStoreCollectStoreView:actionType:value:)]) {
        [self.delegate recommendStoreCollectStoreView:self actionType:(RecommendStoreCollectStoreViewActionType)type value:value];
    }
}

- (void)nilData {
    [[RecommendDataManager shareRecommendDataManager] nilRecommendStore];
}

- (void)dealloc {
    [self nilData];
}

@end
