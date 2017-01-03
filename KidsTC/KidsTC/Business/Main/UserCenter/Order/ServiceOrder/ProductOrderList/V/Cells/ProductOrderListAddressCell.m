//
//  ProductOrderListAddressCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/3.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ProductOrderListAddressCell.h"

@interface ProductOrderListAddressCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@end

@implementation ProductOrderListAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}

- (void)setItem:(ProductOrderListItem *)item {
    [super setItem:item];
    self.nameL.text = item.storeName;
    self.addressL.text = item.storeAddress;
}

@end
