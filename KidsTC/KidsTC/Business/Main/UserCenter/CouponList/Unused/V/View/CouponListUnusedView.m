//
//  CouponListUnusedView.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CouponListUnusedView.h"
#import "CouponListUnusedCell.h"
#import "CouponListTipCell.h"


static NSString *const CellID = @"CouponListUnusedCell";
static NSString *const TipID = @"CouponListTipCell";
static NSString *const ID = @"UITableViewCell";

@interface CouponListUnusedView ()<CouponListUnusedCellDelegate>

@end

@implementation CouponListUnusedView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.tableView registerNib:[UINib nibWithNibName:@"CouponListUnusedCell" bundle:nil] forCellReuseIdentifier:CellID];
        [self.tableView registerNib:[UINib nibWithNibName:@"CouponListTipCell" bundle:nil] forCellReuseIdentifier:TipID];
        [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    }
    return self;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.items.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section<self.items.count) {
        CouponListItem *item = self.items[section];
        if (item.isTipOpen) {
            return 2;
        }
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;
    if (section<self.items.count) {
        NSInteger row = indexPath.row;
        CouponListItem *item = self.items[section];
        if (row == 0) {
            CouponListUnusedCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
            cell.item = item;
            cell.delegate = self;
            return cell;
        }else{
            CouponListTipCell *cell = [tableView dequeueReusableCellWithIdentifier:TipID];
            cell.tip = item.couponDesc;
            return cell;
        }
    }else{
        return [tableView dequeueReusableCellWithIdentifier:ID];
    }
}

#pragma mark - CouponListUnusedCellDelegate

- (void)couponListUnusedCell:(CouponListUnusedCell *)cell actionType:(CouponListUnusedCellActionType)type value:(id)value {
    switch (type) {
        case CouponListUnusedCellActionTypeOpearteTip:
        {
            [self.tableView reloadData];
        }
            break;
        case CouponListUnusedCellActionTypeUseCoupon:
        {
            if ([self.delegate respondsToSelector:@selector(couponListBaseView:actionType:value:)]) {
                [self.delegate couponListBaseView:self actionType:CouponListBaseViewActionTypeUseCoupon value:value];
            }
        }
            break;
    }
}

@end
