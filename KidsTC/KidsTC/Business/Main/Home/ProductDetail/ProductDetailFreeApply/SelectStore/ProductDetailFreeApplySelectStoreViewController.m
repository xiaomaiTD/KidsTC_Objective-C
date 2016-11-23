//
//  ProductDetailFreeApplySelectStoreViewController.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/23.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailFreeApplySelectStoreViewController.h"
#import "ProductDetailFreeApplySelectStoreCell.h"

static NSString *const ID = @"ProductDetailFreeApplySelectStoreCell";

@interface ProductDetailFreeApplySelectStoreViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ProductDetailFreeApplySelectStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"选择门店";
    self.naviTheme = NaviThemeWihte;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.stores.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProductDetailFreeApplySelectStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    NSUInteger row = indexPath.row;
    if (row<self.stores.count) {
        cell.store = self.stores[row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = indexPath.row;
    if (row<self.stores.count) {
        ProductDetailStore *store = self.stores[indexPath.row];
        [self setSelectedStoreId:store.storeId];
        [tableView reloadData];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self back];
            if (self.pickStoreBlock) self.pickStoreBlock(store);
        });
    }
}

#pragma mark - helpers

- (void)setSelectedStoreId:(NSString *)storeId {
    [self.stores enumerateObjectsUsingBlock:^(ProductDetailStore *obj, NSUInteger idx, BOOL *stop) {
        obj.selected = [obj.storeId isEqualToString:storeId];
    }];
}

@end
