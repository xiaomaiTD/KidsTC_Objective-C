//
//  SearchFactorFilterView.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchFactorFilterView.h"

#import "SearchFactorFilterLeftCell.h"
#import "SearchFactorFilterRightCell.h"

#import "SearchFactorFilterDataManager.h"

static NSString *const ID_left = @"SearchFactorFilterLeftCell";
static NSString *const ID_right = @"SearchFactorFilterRightCell";

@interface SearchFactorFilterView ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView_left;
@property (weak, nonatomic) IBOutlet UITableView *tableView_right;
@property (nonatomic, strong) NSArray<NSArray<SearchFactorFilterDataItemLefe *> *> *filters;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@property (weak, nonatomic) IBOutlet UIView *btnsBgView;

@property (nonatomic, strong) NSMutableDictionary *selectItemDic_left;
@property (nonatomic, strong) NSMutableDictionary *selectItemDic_right;

@end

@implementation SearchFactorFilterView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _selectItemDic_left = [NSMutableDictionary new];
    _selectItemDic_right = [NSMutableDictionary new];
    
    _filters = [SearchFactorFilterDataManager shareSearchFactorFilterDataManager].filters;
    
    self.tableView_left.estimatedRowHeight = 44.0;
    self.tableView_right.estimatedRowHeight = 44.0;
    
    [self.tableView_left registerNib:[UINib nibWithNibName:@"SearchFactorFilterLeftCell" bundle:nil] forCellReuseIdentifier:ID_left];
    [self.tableView_right registerNib:[UINib nibWithNibName:@"SearchFactorFilterRightCell" bundle:nil] forCellReuseIdentifier:ID_right];
    
    [self layoutIfNeeded];
    [self.tableView_left reloadData];
    [self.tableView_right reloadData];
}

- (CGFloat)contentHeight {
    
    CGFloat height = self.tableView_left.contentSize.height + CGRectGetHeight(self.btnsBgView.frame);
    CGFloat maxHeight = (SCREEN_HEIGHT - 64 - 44) * 0.8;
    if (height>maxHeight) {
        height = maxHeight;
    }
    return height;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.tableView_left) {
        return _filters.count;
    }else{
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView_left) {
        if (section<_filters.count) {
            return _filters[section].count;
        }
        return 0;
    }else{
        if (_selectedIndexPath.section<_filters.count) {
            NSArray<SearchFactorFilterDataItemLefe *> *lefe_items = _filters[_selectedIndexPath.section];
            if (_selectedIndexPath.row<lefe_items.count) {
                SearchFactorFilterDataItemLefe *left_item = lefe_items[_selectedIndexPath.row];
                NSArray<SearchFactorFilterDataItemRight *> *right_items = left_item.items;
                return right_items.count;
            }
        }
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (tableView == self.tableView_left) {
        return section == (_filters.count - 1) ? 0.001 : 10;
    }
    return 0.001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    if (tableView == self.tableView_left) {
        SearchFactorFilterLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_left];
        if (section<_filters.count) {
            NSArray<SearchFactorFilterDataItemLefe *> *lefe_items = _filters[section];
            if (row<lefe_items.count) {
                cell.item = lefe_items[row];
            }
        }
        return cell;
    }else{
        SearchFactorFilterRightCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_right];
        if (_selectedIndexPath.section<_filters.count) {
            NSArray<SearchFactorFilterDataItemLefe *> *lefe_items = _filters[_selectedIndexPath.section];
            if (_selectedIndexPath.row<lefe_items.count) {
                SearchFactorFilterDataItemLefe *left_item = lefe_items[_selectedIndexPath.row];
                NSArray<SearchFactorFilterDataItemRight *> *right_items = left_item.items;
                if (row<right_items.count) {
                    cell.item = right_items[row];
                }
            }
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    if (tableView == self.tableView_left) {
        _selectedIndexPath = indexPath;
        [self.tableView_right reloadData];
    }else{
        if (_selectedIndexPath.section<_filters.count) {
            NSArray<SearchFactorFilterDataItemLefe *> *lefe_items = _filters[_selectedIndexPath.section];
            if (_selectedIndexPath.row<lefe_items.count) {
                SearchFactorFilterDataItemLefe *item_left = lefe_items[_selectedIndexPath.row];
                NSArray<SearchFactorFilterDataItemRight *> *right_items = item_left.items;
                if (row<right_items.count) {
                    NSNumber *key = @(_selectedIndexPath.section);
                    
                    SearchFactorFilterDataItemRight *selectedItem_right = [_selectItemDic_right objectForKey:key];
                    SearchFactorFilterDataItemRight *item_right = right_items[row];
                    if (selectedItem_right == item_right) {
                        item_right.selected = !item_right.selected;
                    }else{
                        selectedItem_right.selected = NO;
                        item_right.selected = YES;
                        [_selectItemDic_right setObject:item_right forKey:key];
                    }
                    [self.tableView_right reloadData];
                    
                    SearchFactorFilterDataItemLefe *selectItem_left = [_selectItemDic_left objectForKey:key];
                    selectItem_left.selected = NO;
                    item_left.selected = item_right.selected;
                    [_selectItemDic_left setObject:item_left forKey:key];
                    [self.tableView_left reloadData];
                }
            }
        }
    }
}


@end
