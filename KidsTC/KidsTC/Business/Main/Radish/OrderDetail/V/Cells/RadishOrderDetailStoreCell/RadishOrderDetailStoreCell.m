//
//  RadishOrderDetailStoreCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishOrderDetailStoreCell.h"

@interface RadishOrderDetailStoreCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImg;
@end

@implementation RadishOrderDetailStoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.contentView addGestureRecognizer:tapGR];
}

- (void)setData:(RadishOrderDetailData *)data {
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
            if ([self.delegate respondsToSelector:@selector(radishOrderDetailBaseCell:actionType:value:)]) {
                [self.delegate radishOrderDetailBaseCell:self actionType:RadishOrderDetailBaseCellActionTypeSegue value:self.data.storeInfo.segueModel];
            }
        }
            break;
        default:
            break;
    }
    
}

@end
