//
//  RadishSettlementPlaceInfoCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishSettlementPlaceInfoCell.h"

@interface RadishSettlementPlaceInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@end

@implementation RadishSettlementPlaceInfoCell

- (void)setData:(RadishSettlementData *)data {
    [super setData:data];
    
    switch (data.placeType) {
        case PlaceTypePlace:
        {
            if (data.currentPlaceIndex<data.place.count) {
                RadishSettlementPlace *place = data.place[data.currentPlaceIndex];
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
            if ([self.delegate respondsToSelector:@selector(radishSettlementBaseCell:actionType:value:)]) {
                [self.delegate radishSettlementBaseCell:self actionType:RadishSettlementBaseCellActionTypeSelectPlace value:nil];
            }
        }
            break;
        default:
        {
            if ([self.delegate respondsToSelector:@selector(radishSettlementBaseCell:actionType:value:)]) {
                [self.delegate radishSettlementBaseCell:self actionType:RadishSettlementBaseCellActionTypeSelectStore value:nil];
            }
        }
            break;
    }
}

@end
