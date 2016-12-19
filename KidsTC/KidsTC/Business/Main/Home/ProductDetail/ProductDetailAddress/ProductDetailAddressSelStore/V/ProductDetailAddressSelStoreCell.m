//
//  ProductDetailAddressSelStoreCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailAddressSelStoreCell.h"
#import "FiveStarsView.h"
#import "UIImageView+WebCache.h"

@interface ProductDetailAddressSelStoreCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet FiveStarsView *starsView;
@property (weak, nonatomic) IBOutlet UILabel *locationL;
@property (weak, nonatomic) IBOutlet UILabel *distanceL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;

@end

@implementation ProductDetailAddressSelStoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.iconImageView.layer.cornerRadius = 4;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.iconImageView.layer.borderWidth = LINE_H;
    self.HLineH.constant = LINE_H;
}

- (void)setPlace:(ProductDetailAddressSelStoreModel *)place {
    _place = place;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_place.imageUrl] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    self.nameL.text = _place.name;
    [self.starsView setStarNumber:_place.level];
    self.locationL.text = _place.address;
    self.distanceL.text = _place.distance;
}

@end
