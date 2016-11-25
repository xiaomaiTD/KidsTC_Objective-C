//
//  ProductDetailAddressCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailAddressCell.h"

@interface ProductDetailAddressCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@end

@implementation ProductDetailAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.nameL.textColor = [UIColor colorFromHexString:@"222222"];
    self.addressL.textColor = [UIColor colorFromHexString:@"B4B4B4"];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGR];
    
    [self layoutIfNeeded];
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    if (data.store.count>0) {
        ProductDetailStore *store = data.store.firstObject;
        self.nameL.text = store.storeName;
        self.addressL.text = store.address;
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(productDetailBaseCell:actionType:value:)]) {
        [self.delegate productDetailBaseCell:self actionType:ProductDetailBaseCellActionTypeShowAddress value:nil];
    }
}

@end
