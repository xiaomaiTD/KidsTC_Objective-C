//
//  ProductOrderFreeListAddressCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/3.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ProductOrderFreeListAddressCell.h"

@interface ProductOrderFreeListAddressCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@end

@implementation ProductOrderFreeListAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}

- (void)setItem:(ProductOrderFreeListItem *)item {
    [super setItem:item];
    ProductOrderFreeListStore *store = item.storeInfo;
    self.nameL.text = store.storeName;
    self.addressL.text = store.address;
}

@end
