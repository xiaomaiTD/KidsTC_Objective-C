//
//  CollectProductReduceView.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/9.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectProductReduceView.h"
#import "CollectProductReduceCell.h"

static NSString *const ID = @"CollectProductReduceCell";

@interface CollectProductReduceView ()
@end

@implementation CollectProductReduceView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.tableView registerNib:[UINib nibWithNibName:@"CollectProductReduceCell" bundle:nil] forCellReuseIdentifier:ID];
    }
    return self;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return (section == self.items.count - 1)?10:0.001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CollectProductReduceCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    NSInteger section = indexPath.section;
    if (section<self.items.count) {
        cell.item = self.items[section];
        cell.deleteBtn.hidden = !self.editing;
        cell.deleteAction = ^void(){
            [self deleteAtIndexPath:indexPath];
        };
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSInteger section = indexPath.section;
    if (section<self.items.count) {
        CollectProductItem *item = self.items[section];
        if ([self.delegate respondsToSelector:@selector(collectProductBaseView:actionType:value:completion:)]) {
            [self.delegate collectProductBaseView:self actionType:CollectProductBaseViewActionTypeSegue value:item.segueModel completion:nil];
        }
    }
}

- (void)deleteAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    if (section>=self.items.count) return;
    CollectProductItem *item = self.items[section];
    if ([self.delegate respondsToSelector:@selector(collectProductBaseView:actionType:value:completion:)]) {
        [self.delegate collectProductBaseView:self actionType:CollectProductBaseViewActionTypeDelete value:item.productSysNo completion:^(id value) {
            BOOL success = [value boolValue];
            if (!success) return;
            NSMutableArray *itemsAry = [NSMutableArray arrayWithArray:self.items];
            if (section>=itemsAry.count) return;
            [itemsAry removeObjectAtIndex:section];
            self.items = [NSArray arrayWithArray:itemsAry];
            [self.tableView reloadData];
        }];
    }
}

@end
