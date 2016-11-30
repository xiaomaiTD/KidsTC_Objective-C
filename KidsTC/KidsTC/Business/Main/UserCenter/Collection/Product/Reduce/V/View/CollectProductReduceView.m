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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CollectProductReduceCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    NSInteger section = indexPath.section;
    if (section<self.items.count) {
        cell.item = self.items[section];
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

@end
