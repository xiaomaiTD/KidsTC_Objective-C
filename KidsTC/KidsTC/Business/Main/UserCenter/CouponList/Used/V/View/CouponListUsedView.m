//
//  CouponListUsedView.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CouponListUsedView.h"
#import "CouponListUsedCell.h"
#import "CouponListTipCell.h"

static NSString *const CellID = @"CouponListUsedCell";

@implementation CouponListUsedView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.tableView registerNib:[UINib nibWithNibName:@"CouponListUsedCell" bundle:nil] forCellReuseIdentifier:CellID];
        
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
    
    CouponListUsedCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    NSInteger section = indexPath.section;
    if (section<self.items.count) {
        cell.item = self.items[section];
    }
    return cell;
}

@end
