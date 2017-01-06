//
//  RadishProductOrderListAddressCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/3.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishProductOrderListAddressCell.h"

@interface RadishProductOrderListAddressCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@end

@implementation RadishProductOrderListAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}

- (void)setItem:(RadishProductOrderListItem *)item {
    [super setItem:item];
    self.nameL.text = item.storeName;
    self.addressL.text = item.storeAddress;
}

@end
