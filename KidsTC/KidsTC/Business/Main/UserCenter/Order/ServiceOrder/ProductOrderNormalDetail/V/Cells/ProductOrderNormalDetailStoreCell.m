//
//  ProductOrderNormalDetailStoreCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderNormalDetailStoreCell.h"

@interface ProductOrderNormalDetailStoreCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@end

@implementation ProductOrderNormalDetailStoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.contentView addGestureRecognizer:tapGR];
}

- (void)setData:(ProductOrderNormalDetailData *)data {
    [super setData:data];
    self.nameL.text = self.data.storeInfo.storeName;
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(productOrderNormalDetailBaseCell:actionType:value:)]) {
        [self.delegate productOrderNormalDetailBaseCell:self actionType:ProductOrderNormalDetailBaseCellActionTypeSegue value:self.data.storeInfo.segueModel];
    }
}

@end
