//
//  ProductOrderFreeListTimeCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/3.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ProductOrderFreeListTimeCell.h"

@interface ProductOrderFreeListTimeCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@end

@implementation ProductOrderFreeListTimeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}

- (void)setItem:(ProductOrderFreeListItem *)item {
    [super setItem:item];
    self.timeL.text = item.useTimeStr;
}

@end
