//
//  SearchFactorFilterCategoryView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchFactorFilterCategoryView.h"
#import "NSString+Category.h"

#import "SearchFactorFilterCategoryCellLeft.h"
#import "SearchFactorFilterCategoryCellRight.h"

static NSString *const CellLeftID = @"SearchFactorFilterCategoryCellLeft";
static NSString *const CellRightID = @"SearchFactorFilterCategoryCellRight";

@interface SearchFactorFilterCategoryView ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView_left;
@property (weak, nonatomic) IBOutlet UITableView *tableView_right;
@property (nonatomic, strong) NSArray<SearchFactorFilterCategoryItemLeft *> *leftItems;

@property (nonatomic, weak) SearchFactorFilterCategoryItemLeft *currentCellItemLeft;
@end

@implementation SearchFactorFilterCategoryView

- (NSArray<SearchFactorFilterCategoryItemLeft *> *)leftItems {
    if (!_leftItems) {
        _leftItems = [SearchFactorFilterCategoryItemLeft leftItems];
    }
    return _leftItems;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.tableView_left registerNib:[UINib nibWithNibName:@"SearchFactorFilterCategoryCellLeft" bundle:nil] forCellReuseIdentifier:CellLeftID];
    [self.tableView_right registerNib:[UINib nibWithNibName:@"SearchFactorFilterCategoryCellRight" bundle:nil] forCellReuseIdentifier:CellRightID];
}

- (CGFloat)contentHeight {
    if (self.leftItems.count>0) {
        CGFloat height = self.tableView_left.contentSize.height;
        CGFloat maxHeight = (SCREEN_HEIGHT - 64 - 44) * 0.8;
        if (height>maxHeight) {
            height = maxHeight;
        }
        return height;
    }else{
        return 0;
    }
}

- (void)clean {
    self.cellSelectedItemLeft.cellSelected = NO;
    self.cellSelectedItemRight.cellSelected = NO;
    [self.tableView_left reloadData];
    [self.tableView_right reloadData];
}

- (void)sure {
    self.cellSelectedItemLeft.dataSelected = self.cellSelectedItemLeft.cellSelected;
    self.cellSelectedItemRight.dataSelected = self.cellSelectedItemRight.cellSelected;
    [self.tableView_left reloadData];
    [self.tableView_right reloadData];
}

- (void)reset {
    self.cellSelectedItemLeft.cellSelected = self.cellSelectedItemLeft.dataSelected;
    self.cellSelectedItemRight.cellSelected = self.cellSelectedItemRight.dataSelected;
    [self.tableView_left reloadData];
    [self.tableView_right reloadData];
}

- (void)setInsetParam:(NSDictionary *)insetParam {
    _insetParam = insetParam;
    NSString *category = [NSString stringWithFormat:@"%@",insetParam[kSearchKey_category]];
    if ([category isNotNull]) {
        [self.leftItems enumerateObjectsUsingBlock:^(SearchFactorFilterCategoryItemLeft *itemLeft, NSUInteger idxLeft, BOOL *stopLeft) {
            [itemLeft.rightItems enumerateObjectsUsingBlock:^(SearchFactorFilterCategoryItemRight *itemRight, NSUInteger idxRight, BOOL *stopRight) {
                if ([category isEqualToString:itemRight.value]) {
                    itemLeft.dataSelected  = YES;
                    itemLeft.currentCell   = YES;
                    itemRight.dataSelected = YES;
                    [self setupSelectedItemLeft:itemLeft itemRight:itemRight];
                    *stopRight = YES;
                    *stopLeft  = YES;
                }
            }];
        }];
    }
    if (!self.currentCellItemLeft && self.leftItems.count>0) {
        [self setupSelectedItemLeft:self.leftItems.firstObject itemRight:nil];
    }
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableView_left) {
        return self.leftItems.count;
    }else{
        return self.currentCellItemLeft.rightItems.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (tableView == self.tableView_left) {
        SearchFactorFilterCategoryCellLeft *cell = [tableView dequeueReusableCellWithIdentifier:CellLeftID];
        if (row<self.leftItems.count) {
            SearchFactorFilterCategoryItemLeft *itemLeft = self.leftItems[row];
            cell.item = itemLeft;
        }
        return cell;
    }else{
        SearchFactorFilterCategoryCellRight *cell = [tableView dequeueReusableCellWithIdentifier:CellRightID];
        NSArray<SearchFactorFilterCategoryItemRight *> *rightItems = self.currentCellItemLeft.rightItems;
        if (row<rightItems.count) {
            SearchFactorFilterCategoryItemRight *itemRight = rightItems[row];
            cell.item = itemRight;
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (tableView == self.tableView_left) {
        if (row>=self.leftItems.count) return;
        SearchFactorFilterCategoryItemLeft *itemLeft = self.leftItems[row];
        [self setupCurrentCellItemLeft:itemLeft];
    }else {
        NSArray<SearchFactorFilterCategoryItemRight *> *rightItems = self.currentCellItemLeft.rightItems;
        if (row>=rightItems.count) return;
        SearchFactorFilterCategoryItemRight *itemRight = rightItems[row];
        [self setupSelectedItemLeft:self.currentCellItemLeft itemRight:itemRight];
    }
}

- (void)setupCurrentCellItemLeft:(SearchFactorFilterCategoryItemLeft *)itemLeft {
    self.currentCellItemLeft.currentCell = NO;
    itemLeft.currentCell = YES;
    self.currentCellItemLeft = itemLeft;
    [self.tableView_left reloadData];
    [self.tableView_right reloadData];
}

- (void)setupSelectedItemLeft:(SearchFactorFilterCategoryItemLeft *)itemLeft
                    itemRight:(SearchFactorFilterCategoryItemRight *)itemRight
{
    if (itemRight == self.cellSelectedItemRight) {
        itemRight.cellSelected = !itemRight.cellSelected;
    }else{
        self.cellSelectedItemRight.cellSelected = NO;
        itemRight.cellSelected = YES;
        self.cellSelectedItemRight = itemRight;
    }
    if (!self.currentCellItemLeft) {
        itemLeft.currentCell = YES;
        self.currentCellItemLeft = itemLeft;
    }
    self.cellSelectedItemLeft.cellSelected = NO;
    self.currentCellItemLeft.cellSelected = self.cellSelectedItemRight.cellSelected;
    self.cellSelectedItemLeft = itemLeft;
    [self.tableView_left reloadData];
    [self.tableView_right reloadData];
}

@end
