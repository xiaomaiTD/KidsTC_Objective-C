//
//  SeckillOtherView.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/11.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "SeckillOtherView.h"
#import "KTCEmptyDataView.h"

#import "SeckillOtherLeftCell.h"
#import "SeckillOtherRightCell.h"

static NSString *LeftCellID = @"SeckillOtherLeftCell";
static NSString *RightCellID = @"SeckillOtherRightCell";

@interface SeckillOtherView ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;
@property (weak, nonatomic) SeckillOtherItem *selectItem;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomMargin;
@end

@implementation SeckillOtherView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.bottomMargin.constant = - SCREEN_HEIGHT * 0.6;
    self.leftTableView.estimatedRowHeight = 50;
    self.rightTableView.estimatedRowHeight = 80;
    [self.leftTableView registerNib:[UINib nibWithNibName:@"SeckillOtherLeftCell" bundle:nil] forCellReuseIdentifier:LeftCellID];
    [self.rightTableView registerNib:[UINib nibWithNibName:@"SeckillOtherRightCell" bundle:nil] forCellReuseIdentifier:RightCellID];
    [self layoutIfNeeded];
}

- (void)setData:(NSArray<SeckillOtherItem *> *)data {
    _data = data;
    __block SeckillOtherItem *selectItem = nil;
    [_data enumerateObjectsUsingBlock:^(SeckillOtherItem *obj, NSUInteger idx, BOOL *stop) {
        if (obj.selected && !selectItem) {
            selectItem = obj;
        }
    }];
    if (_data.count>0 && !selectItem) {
        selectItem = _data.firstObject;
    }
    [self setSelectItem:selectItem];
}

- (void)selectLeftItem:(SeckillOtherItem *)item {
    self.selectItem.selected = NO;
    item.selected = YES;
    self.selectItem = item;
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
    [self setupBGView];
}

- (void)setupBGView {
    if (self.data.count<1) {
        self.leftTableView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:self.leftTableView.bounds
                                                                              image:nil description:@"啥都没有啊…"
                                                                         needGoHome:NO];
    }else self.leftTableView.backgroundView = nil;
    
    if (self.selectItem.items.count<1) {
        self.rightTableView.backgroundView = [[KTCEmptyDataView alloc] initWithFrame:self.rightTableView.bounds
                                                                              image:nil description:@"啥都没有啊…"
                                                                         needGoHome:NO];
    }else self.rightTableView.backgroundView = nil;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.leftTableView) {
        return self.data.count;
    }else{
        return self.selectItem.items.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (tableView == self.leftTableView) {
        SeckillOtherLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:LeftCellID];
        if (row<self.data.count) {
            SeckillOtherItem *item = self.data[row];
            cell.item = item;
        }
        return cell;
    }else{
        SeckillOtherRightCell *cell = [tableView dequeueReusableCellWithIdentifier:RightCellID];
        if (row<self.selectItem.items.count) {
            SeckillOtherFloorItem *item = self.selectItem.items[row];
            cell.item = item;
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSInteger row = indexPath.row;
    if (tableView == self.leftTableView) {
        if (row<self.data.count) {
            SeckillOtherItem *item = self.data[row];
            [self selectLeftItem:item];
        }
    }else{
        if (row<self.selectItem.items.count) {
            SeckillOtherFloorItem *item = self.selectItem.items[row];
            if ([self.delegate respondsToSelector:@selector(seckillOtherView:actionType:value:)]) {
                [self.delegate seckillOtherView:self actionType:SeckillOtherViewActionTypeDidSelectItem value:item];
            }
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if ([self.delegate respondsToSelector:@selector(seckillOtherView:actionType:value:)]) {
        [self.delegate seckillOtherView:self actionType:SeckillOtherViewActionTypeDidHide value:nil];
    }
}

- (void)show {
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomMargin.constant = 0;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        [self layoutIfNeeded];
    }];
}
- (void)hide:(void(^)(BOOL finish))completion {
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomMargin.constant = - SCREEN_HEIGHT * 0.6;
        self.backgroundColor = [UIColor clearColor];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        if(completion) completion(finished);
    }];
}

@end
