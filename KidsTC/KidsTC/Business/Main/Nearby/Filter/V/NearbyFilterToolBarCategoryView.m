//
//  NearbyFilterToolBarCategoryView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyFilterToolBarCategoryView.h"
#import "NearbyFilterToolBarCategoryCell.h"

static NSString *const CellID = @"NearbyFilterToolBarCategoryCell";

@interface NearbyFilterToolBarCategoryView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray<NearbyFilterToolBarCategoryItem *> *items;
@end

@implementation NearbyFilterToolBarCategoryView

- (NSArray<NearbyFilterToolBarCategoryItem *> *)items {
    if (!_items) {
        _items = [NearbyFilterToolBarCategoryItem items];
    }
    return _items;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tableView.estimatedRowHeight = 44;
    [self.tableView registerNib:[UINib nibWithNibName:@"NearbyFilterToolBarCategoryCell" bundle:nil] forCellReuseIdentifier:CellID];
    [self layoutIfNeeded];
}

- (CGFloat)contentHeight {
    CGFloat height = self.tableView.contentSize.height;
    CGFloat maxHeight = (SCREEN_HEIGHT - 64 - 44 - 49) * 0.8;
    if (height>maxHeight) {
        height = maxHeight;
    }
    return height;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NearbyFilterToolBarCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"NearbyFilterToolBarCategoryCell" owner:self options:nil].firstObject;
    }
    NSInteger row = indexPath.row;
    if (row<self.items.count) {
        cell.item = self.items[row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSInteger row = indexPath.row;
    if (row<self.items.count) {
        NearbyFilterToolBarCategoryItem *item = self.items[row];
        if ([self.delegate respondsToSelector:@selector(nearbyFilterToolBarCategoryView:didSelectItem:)]) {
            [self.delegate nearbyFilterToolBarCategoryView:self didSelectItem:item];
        }
    }
}

@end
