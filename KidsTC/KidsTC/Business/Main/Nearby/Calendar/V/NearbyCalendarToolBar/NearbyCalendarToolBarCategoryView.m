//
//  NearbyCalendarToolBarCategoryView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/1.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyCalendarToolBarCategoryView.h"
#import "NearbyCalendarToolBarCategoryCell.h"

static NSString *const CellID = @"NearbyCalendarToolBarCategoryCell";

@interface NearbyCalendarToolBarCategoryView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray<NearbyCalendarToolBarCategoryItem *> *items;
@property (nonatomic, strong) NearbyCalendarToolBarCategoryItem *selectedItem;
@end

@implementation NearbyCalendarToolBarCategoryView

- (NSArray<NearbyCalendarToolBarCategoryItem *> *)items {
    if (!_items) {
        _items = [NearbyCalendarToolBarCategoryItem items];
    }
    return _items;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tableView.estimatedRowHeight = 44;
    [self.tableView registerNib:[UINib nibWithNibName:@"NearbyCalendarToolBarCategoryCell" bundle:nil] forCellReuseIdentifier:CellID];
    [self layoutIfNeeded];
    if (self.items.count>0)[self selectedItem:self.items.firstObject];
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
    NearbyCalendarToolBarCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"NearbyCalendarToolBarCategoryCell" owner:self options:nil].firstObject;
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
        NearbyCalendarToolBarCategoryItem *item = self.items[row];
        [self selectedItem:item];
        if ([self.delegate respondsToSelector:@selector(nearbyCalendarToolBarCategoryView:didSelectItem:)]) {
            [self.delegate nearbyCalendarToolBarCategoryView:self didSelectItem:item];
        }
    }
}

- (void)selectedItem:(NearbyCalendarToolBarCategoryItem *)item {
    _selectedItem.selected = NO;
    item.selected = YES;
    _selectedItem = item;
    [self.tableView reloadData];
}

@end
