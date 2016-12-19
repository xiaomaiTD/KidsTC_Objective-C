//
//  ProductOrderFreeDetailAddressCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderFreeDetailAddressCell.h"

@interface ProductOrderFreeDetailAddressCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImg;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@end

@implementation ProductOrderFreeDetailAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.contentView addGestureRecognizer:tapGR];
}

- (void)setInfoData:(ProductOrderFreeDetailData *)infoData {
    [super setInfoData:infoData];
    ProductOrderFreeDetailStore *storeInfo = infoData.storeInfo;
    self.titleL.text = storeInfo.address;
}


- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(productOrderFreeDetailInfoBaseCell:actionType:value:)]) {
        [self.delegate productOrderFreeDetailInfoBaseCell:self actionType:ProductOrderFreeDetailInfoBaseCellActionTypeAddress value:self.infoData];
    }
}

@end
