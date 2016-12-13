//
//  NearbyCategoryToolBar.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/2.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NearbyCategoryToolBar.h"
#import "NearbyCategoryToolBarItem.h"
#import "NearbyCategoryToolBarCell.h"

static NSString *const CellID = @"NearbyCategoryToolBarCell";
static CGFloat const kAnimationDuration = 0.3;

@interface NearbyCategoryToolBar ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray<NearbyCategoryToolBarItem *> *items;
@property (nonatomic, strong) NearbyCategoryToolBarItem *selectedItem;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopMargin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewH;
@property (nonatomic, assign) BOOL isShowing;
@end

@implementation NearbyCategoryToolBar

- (NSArray<NearbyCategoryToolBarItem *> *)items {
    if (!_items) {
        _items = [NearbyCategoryToolBarItem items];
    }
    return _items;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.tableView.estimatedRowHeight = 44;
    [self.tableView registerNib:[UINib nibWithNibName:@"NearbyCategoryToolBarCell" bundle:nil] forCellReuseIdentifier:CellID];
    
    if (self.items.count>0)[self selectedItem:self.items.firstObject];
    
    self.backgroundColor = [UIColor clearColor];
    self.tableViewTopMargin.constant = - self.tableViewH.constant - 4;
    self.alpha = 0;
    [self layoutIfNeeded];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tableViewH.constant = [self contentHeight];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self showHide];
}

- (CGFloat)contentHeight {
    CGFloat height = self.tableView.contentSize.height;
    CGFloat maxHeight = (SCREEN_HEIGHT - 64 - 44 - 49) * 0.8;
    if (height>maxHeight) {
        height = maxHeight;
    }
    return height;
}

- (void)showHide {
    if (self.isShowing) {
        [self hide];
    }else{
        [self show];
    }
}

- (void)show {
    self.isShowing = YES;
    self.hidden = NO;
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.alpha = 1;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.tableViewTopMargin.constant = 0;
        [self layoutIfNeeded];
    } completion:nil];
}

- (void)hide {
    self.isShowing = NO;
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.tableViewTopMargin.constant = - self.tableViewH.constant - 4;
        self.alpha = 0;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NearbyCategoryToolBarCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"NearbyCategoryToolBarCell" owner:self options:nil].firstObject;
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
        NearbyCategoryToolBarItem *item = self.items[row];
        [self selectedItem:item];
        [self showHide];
        if ([self.delegate respondsToSelector:@selector(nearbyCategoryToolBar:actionType:value:)]) {
            [self.delegate nearbyCategoryToolBar:self actionType:NearbyCategoryToolBarActionTypeDidSelectCategory value:item];
        }
    }
}

- (void)selectedItem:(NearbyCategoryToolBarItem *)item {
    _selectedItem.selected = NO;
    item.selected = YES;
    _selectedItem = item;
    [self.tableView reloadData];
}

@end
