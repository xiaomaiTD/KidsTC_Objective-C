//
//  ProductDetailAddressSelPlaceCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailAddressSelPlaceCell.h"

@interface ProductDetailAddressSelPlaceCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *locationL;
@property (weak, nonatomic) IBOutlet UILabel *distanceL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;

@end

@implementation ProductDetailAddressSelPlaceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.HLineH.constant = LINE_H;
}

- (void)setPlace:(ProductDetailAddressSelStoreModel *)place {
    _place = place;
    self.nameL.text = _place.name;
    self.locationL.text = _place.address;
    self.distanceL.text = _place.distance;
}

@end
