//
//  WolesaleProductDetailAddressCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WolesaleProductDetailAddressCell.h"

@interface WolesaleProductDetailAddressCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;

@end

@implementation WolesaleProductDetailAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}

- (void)setData:(WolesaleProductDetailData *)data {
    [super setData:data];
    WholesaleProductDetailBase *base = data.fightGroupBase;
    switch (base.placeType) {
        case PlaceTypeStore:
        {
            if (base.stores.count>0) {
                WholesaleProductDetailStoreItem *store = base.stores.firstObject;
                self.nameL.text = store.storeName;
                self.addressL.text = store.address;
            }
        }
            break;
        case PlaceTypePlace:
        {
            if (base.place.count>0) {
                WolesaleProductDetailPlace *place = base.place.firstObject;
                self.nameL.text = place.name;
                self.addressL.text = place.address;
            }
        }
            break;
        default:
            break;
    }
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(wolesaleProductDetailBaseCell:actionType:value:)]) {
        [self.delegate wolesaleProductDetailBaseCell:self actionType:WolesaleProductDetailBaseCellActionTypeAddress value:@(NO)];
    }
}
@end
