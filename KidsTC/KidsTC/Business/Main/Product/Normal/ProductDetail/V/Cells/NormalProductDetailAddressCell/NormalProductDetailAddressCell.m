//
//  NormalProductDetailAddressCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "NormalProductDetailAddressCell.h"

@interface NormalProductDetailAddressCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@end

@implementation NormalProductDetailAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.HLineH.constant = LINE_H;
    
    self.nameL.textColor = [UIColor colorFromHexString:@"222222"];
    self.addressL.textColor = [UIColor colorFromHexString:@"B4B4B4"];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGR];
    
    [self layoutIfNeeded];
}

- (void)setData:(NormalProductDetailData *)data {
    [super setData:data];
    switch (data.placeType) {
        case PlaceTypeStore:
        {
            if (data.store.count>0) {
                NormalProductDetailStore *store = data.store.firstObject;
                self.nameL.text = store.storeName;
                self.addressL.text = store.address;
            }
        }
            break;
        case PlaceTypePlace:
        {
            if (data.place.count>0) {
                NormalProductDetailPlace *place = data.place.firstObject;
                self.nameL.text = place.name;
                self.addressL.text = place.address;
            }
        }
            break;
        default:
            break;
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(normalProductDetailBaseCell:actionType:value:)]) {
        [self.delegate normalProductDetailBaseCell:self actionType:NormalProductDetailBaseCellActionTypeShowAddress value:nil];
    }
}

@end
