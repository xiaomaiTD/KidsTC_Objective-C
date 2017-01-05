//
//  WolesaleProductDetailV2PlaceCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/4.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "WolesaleProductDetailV2PlaceCell.h"
#import "NSString+Category.h"

@interface WolesaleProductDetailV2PlaceCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *distanceL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation WolesaleProductDetailV2PlaceCell

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
                self.distanceL.text = [store.distance isNotNull]?[NSString stringWithFormat:@"距离：%@",store.distance]:nil;
                self.addressL.text = store.address;
            }
        }
            break;
        case PlaceTypePlace:
        {
            if (base.place.count>0) {
                WolesaleProductDetailPlace *place = base.place.firstObject;
                self.nameL.text = place.name;
                self.distanceL.text = [place.distance isNotNull]?[NSString stringWithFormat:@"距离：%@",place.distance]:nil;
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
