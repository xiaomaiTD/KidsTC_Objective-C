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
@property (weak, nonatomic) IBOutlet UIImageView *arrowImg;
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
    switch (data.placeType) {
        case PlaceTypeStore:
        {
            self.arrowImg.hidden = NO;
        }
            break;
            
        default:
        {
            self.arrowImg.hidden = YES;
        }
            break;
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    switch (self.data.placeType) {
        case PlaceTypeStore:
        {
            if ([self.delegate respondsToSelector:@selector(productOrderNormalDetailBaseCell:actionType:value:)]) {
                [self.delegate productOrderNormalDetailBaseCell:self actionType:ProductOrderNormalDetailBaseCellActionTypeSegue value:self.data.storeInfo.segueModel];
            }
        }
            break;
        default:
            break;
    }
    
}

@end
