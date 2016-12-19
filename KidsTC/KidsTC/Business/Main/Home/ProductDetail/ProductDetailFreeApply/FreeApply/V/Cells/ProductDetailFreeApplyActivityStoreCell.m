//
//  ProductDetailFreeApplyActivityStoreCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailFreeApplyActivityStoreCell.h"

@interface ProductDetailFreeApplyActivityStoreCell ()
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UILabel *storeNameL;

@end

@implementation ProductDetailFreeApplyActivityStoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setShowModel:(ProductDetailFreeApplyShowModel *)showModel {
    [super setShowModel:showModel];
    switch (showModel.placeType) {
        case PlaceTypeStore:
        {
            self.storeNameL.text = showModel.activityStore.storeName;
        }
            break;
        case PlaceTypePlace:
        {
            self.storeNameL.text = showModel.place.name;
        }
            break;
        case PlaceTypeNone:
        {
            self.storeNameL.text = nil;
        }
            break;
        default:
        {
            self.storeNameL.text = showModel.activityStore.storeName;
        }
            break;
    }
}

- (IBAction)action:(UIButton *)sender {
    switch (self.showModel.placeType) {
        case PlaceTypeStore:
        {
            if ([self.delegate respondsToSelector:@selector(productDetailFreeApplyBaseCell:actionType:value:)]) {
                [self.delegate productDetailFreeApplyBaseCell:self actionType:ProductDetailFreeApplyBaseCellActionTypeActivityStore value:nil];
            }
        }
            break;
        case PlaceTypePlace:
        {
            if ([self.delegate respondsToSelector:@selector(productDetailFreeApplyBaseCell:actionType:value:)]) {
                [self.delegate productDetailFreeApplyBaseCell:self actionType:ProductDetailFreeApplyBaseCellActionTypeActivityPlace value:nil];
            }
        }
            break;
        case PlaceTypeNone:
        {
            
        }
            break;
            
        default:
        {
            if ([self.delegate respondsToSelector:@selector(productDetailFreeApplyBaseCell:actionType:value:)]) {
                [self.delegate productDetailFreeApplyBaseCell:self actionType:ProductDetailFreeApplyBaseCellActionTypeActivityStore value:nil];
            }
        }
            break;
    }
    
}
@end
