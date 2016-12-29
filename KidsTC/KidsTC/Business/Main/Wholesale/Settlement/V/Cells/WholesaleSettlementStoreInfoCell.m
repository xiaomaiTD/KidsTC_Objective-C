//
//  WholesaleSettlementStoreInfoCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleSettlementStoreInfoCell.h"

@interface WholesaleSettlementStoreInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@end

@implementation WholesaleSettlementStoreInfoCell

- (void)setData:(WholesaleSettlementData *)data {
    [super setData:data];
    switch (data.placeType) {
        case PlaceTypePlace:
        {
            if (data.currentPlaceIndex<data.place.count) {
                WholesaleSettlementPlace *place = data.place[data.currentPlaceIndex];
                self.nameL.text = place.name;
                self.addressL.text = place.address;
            }
        }
            break;
        default:
        {
            self.nameL.text = data.store.storeName;
            self.addressL.text = data.store.address;
        }
            break;
    }
}

- (IBAction)action:(UIButton *)sender {
    switch (self.data.placeType) {
        case PlaceTypePlace:
        {
            if ([self.delegate respondsToSelector:@selector(wholesaleSettlementBaseCell:actionType:value:)]) {
                [self.delegate wholesaleSettlementBaseCell:self actionType:WholesaleSettlementBaseCellActionTypeSelectPlace value:nil];
            }
        }
            break;
        default:
        {
            if ([self.delegate respondsToSelector:@selector(wholesaleSettlementBaseCell:actionType:value:)]) {
                [self.delegate wholesaleSettlementBaseCell:self actionType:WholesaleSettlementBaseCellActionTypeSelectStore value:nil];
            }
        }
            break;
    }
}

@end
