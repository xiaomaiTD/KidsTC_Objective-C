//
//  SearchFactorSortView.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchFactorSortView.h"
#import "NSString+Category.h"

#import "SearchFactorSortCell.h"

static NSString *const ID = @"SearchFactorSortCell";

@interface SearchFactorSortView ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray<SearchFactorSortDataItem *> *items;
@property (nonatomic, strong) SearchFactorSortDataItem *selectedItem;
@end

@implementation SearchFactorSortView

- (void)awakeFromNib {
    [super awakeFromNib];
    _items = [SearchFactorSortDataManager shareSearchFactorSortDataManager].items;
    self.tableView.estimatedRowHeight = 44.0;
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchFactorSortCell" bundle:nil] forCellReuseIdentifier:ID];

    [self selectFirstItem];
}

- (void)setInsetParam:(NSDictionary *)insetParam {
    _insetParam = insetParam;
    NSString *sort = [NSString stringWithFormat:@"%@",insetParam[kSearchKey_sort]];;
    if ([sort isNotNull]) {
        [self.items enumerateObjectsUsingBlock:^(SearchFactorSortDataItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([sort isEqualToString:obj.value]) {
                [self setupSelectItem:obj byClick:NO];
                *stop = YES;
            }
        }];
    }
    if (!self.selectedItem && _items.count>0) {
        [self setupSelectItem:_items.firstObject byClick:NO];
    }
}

- (void)selectFirstItem {
    if (_items.count>0) [self setupSelectItem:_items.firstObject byClick:NO];
}

- (CGFloat)contentHeight {
    
    CGFloat height = self.tableView.contentSize.height;
    CGFloat maxHeight = (SCREEN_HEIGHT - 64 - 44) * 0.8;
    if (height>maxHeight) {
        height = maxHeight;
    }
    return height;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchFactorSortCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    NSInteger row = indexPath.row;
    if (row<_items.count) {
        cell.item = _items[row];
        cell.actionBlock = ^(SearchFactorSortDataItem *item){
            [self setupSelectItem:item byClick:YES];
        };
    }
    return cell;
}

- (void)setupSelectItem:(SearchFactorSortDataItem *)item byClick:(BOOL)byClick {
    self.selectedItem.selected = NO;
    item.selected = YES;
    self.selectedItem = item;
    [self.tableView reloadData];
    if ([self.delegate respondsToSelector:@selector(searchFactorSortView:didSelectItem:byClick:)]) {
        [self.delegate searchFactorSortView:self didSelectItem:item byClick:byClick];
    }
}

@end
