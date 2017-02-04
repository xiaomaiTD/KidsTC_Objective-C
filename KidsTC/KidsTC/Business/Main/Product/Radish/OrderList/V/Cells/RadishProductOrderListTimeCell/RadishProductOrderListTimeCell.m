//
//  RadishProductOrderListTimeCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/3.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishProductOrderListTimeCell.h"

@interface RadishProductOrderListTimeCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@end

@implementation RadishProductOrderListTimeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}


- (void)setItem:(RadishProductOrderListItem *)item {
    [super setItem:item];
    self.timeL.text = item.useTimeStr;
}

@end
