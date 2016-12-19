//
//  ProductOrderFreeDetailTimeCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderFreeDetailTimeCell.h"

@interface ProductOrderFreeDetailTimeCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImg;
@end

@implementation ProductOrderFreeDetailTimeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.contentView addGestureRecognizer:tapGR];
}

- (void)setInfoData:(ProductOrderFreeDetailData *)infoData {
    [super setInfoData:infoData];
    ProductDetailTime *time = infoData.time;
    self.titleL.text = time.desc;
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(productOrderFreeDetailInfoBaseCell:actionType:value:)]) {
        [self.delegate productOrderFreeDetailInfoBaseCell:self actionType:ProductOrderFreeDetailInfoBaseCellActionTypeDate value:self.infoData];
    }
}

@end
