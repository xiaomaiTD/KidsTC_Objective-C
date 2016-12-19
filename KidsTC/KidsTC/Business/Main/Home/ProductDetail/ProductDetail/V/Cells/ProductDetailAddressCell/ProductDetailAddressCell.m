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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@end

@implementation ProductDetailAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.HLineH.constant = LINE_H;
    
    self.nameL.textColor = [UIColor colorFromHexString:@"222222"];
    self.addressL.textColor = [UIColor colorFromHexString:@"B4B4B4"];
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGR];
    
    [self layoutIfNeeded];
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    switch (data.type) {
        case ProductDetailTypeNormal:
        case ProductDetailTypeFree:
        {
            switch (data.placeType) {
                case PlaceTypeStore:
                {
                    if (data.store.count>0) {
                        ProductDetailStore *store = data.store.firstObject;
                        self.nameL.text = store.storeName;
                        self.addressL.text = store.address;
                    }
                }
                    break;
                case PlaceTypePlace:
                {
                    if (data.place.count>0) {
                        ProductDetailPlace *place = data.place.firstObject;
                        self.nameL.text = place.name;
                        self.addressL.text = place.address;
                    }
                }
                    break;
                default:
                    break;
            }
            
        }
            break;
        case ProductDetailTypeTicket:
        {
            ProductDetailTheater *theater = data.theater;
            self.nameL.text = theater.theaterName;
            self.addressL.text = theater.address;
        }
            break;
        default:
            break;
    }
    
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if ([self.delegate respondsToSelector:@selector(productDetailBaseCell:actionType:value:)]) {
        [self.delegate productDetailBaseCell:self actionType:ProductDetailBaseCellActionTypeShowAddress value:nil];
    }
}

@end
