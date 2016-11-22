//
//  ProductDetaiFreeStoreInfoCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetaiFreeStoreInfoCell.h"

@interface ProductDetaiFreeStoreInfoCell ()
@property (weak, nonatomic) IBOutlet UIButton *storeDetailBtn;
@property (weak, nonatomic) IBOutlet UILabel *storeNameL;
@property (weak, nonatomic) IBOutlet UILabel *storeAddressL;
@end

@implementation ProductDetaiFreeStoreInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.storeDetailBtn.tag = ProductDetailBaseCellActionTypeFreeStoreDetail;
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(productDetailBaseCell:actionType:value:)]) {
        [self.delegate productDetailBaseCell:self actionType:sender.tag value:nil];
    }
}


- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    if (data.store.count<1) return;
    ProductDetailStore *store = data.store.firstObject;
    self.storeNameL.text = store.storeName;
    self.storeAddressL.text = store.address;
}

@end
