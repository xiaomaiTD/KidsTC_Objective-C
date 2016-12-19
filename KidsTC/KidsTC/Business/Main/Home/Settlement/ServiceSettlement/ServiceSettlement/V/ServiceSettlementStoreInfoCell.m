//
//  ServiceSettlementStoreInfoCell.m
//  KidsTC
//
//  Created by zhanping on 8/11/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ServiceSettlementStoreInfoCell.h"

@interface ServiceSettlementStoreInfoCell ()
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (weak, nonatomic) IBOutlet UILabel *storeDescLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstranitHeight;

@end

@implementation ServiceSettlementStoreInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineConstranitHeight.constant = LINE_H;
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(action:)];
    [self.contentView addGestureRecognizer:tapGR];
}

- (void)action:(UITapGestureRecognizer *)tapGR {
    
    switch (self.item.placeType) {
        case PlaceTypeStore:
        {
            if ([self.delegate respondsToSelector:@selector(serviceSettlementBaseCell:actionType:value:)]) {
                [self.delegate serviceSettlementBaseCell:self actionType:ServiceSettlementBaseCellActionTypeStore value:nil];
            }
        }
            break;
        case PlaceTypePlace:
        {
            if ([self.delegate respondsToSelector:@selector(serviceSettlementBaseCell:actionType:value:)]) {
                [self.delegate serviceSettlementBaseCell:self actionType:ServiceSettlementBaseCellActionTypePlace value:nil];
            }
        }
            break;
        case PlaceTypeNone:
        {
            
        }
            break;
        default:
        {
            if ([self.delegate respondsToSelector:@selector(serviceSettlementBaseCell:actionType:value:)]) {
                [self.delegate serviceSettlementBaseCell:self actionType:ServiceSettlementBaseCellActionTypeStore value:nil];
            }
        }
            break;
    }
}

- (void)setItem:(ServiceSettlementDataItem *)item{
    [super setItem:item];
    switch (item.placeType) {
        case PlaceTypeStore:
        {
            self.tipL.text = @"所选门店";
            self.storeDescLabel.attributedText = item.store.storeDesc;
        }
            break;
        case PlaceTypePlace:
        {
            self.tipL.text = @"所选地址";
            if (item.currentPlaceIndex<item.place.count) {
                ServiceSettlementPlace *place = item.place[item.currentPlaceIndex];
                self.storeDescLabel.attributedText = place.placeDesc;
            }
        }
            break;
        case PlaceTypeNone:
        {
            self.tipL.text = nil;
            self.storeDescLabel.attributedText = nil;
        }
            break;
        default:
        {
            self.tipL.text = @"所选门店";
            self.storeDescLabel.attributedText = item.store.storeDesc;
        }
            break;
    }
    
}





@end
