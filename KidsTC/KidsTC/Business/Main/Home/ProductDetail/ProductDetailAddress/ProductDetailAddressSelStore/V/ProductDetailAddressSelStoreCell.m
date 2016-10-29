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

@end

@implementation ProductDetailAddressSelStoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.distanceL.textColor = COLOR_BLUE;
    self.iconImageView.layer.cornerRadius = 4;
    self.iconImageView.layer.masksToBounds = YES;
    self.iconImageView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.iconImageView.layer.borderWidth = LINE_H;
    
}

- (void)setStore:(ProductDetailStore *)store {
    _store = store;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:store.imageUrl] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    self.nameL.text = store.storeName;
    [self.starsView setStarNumber:store.level];
    self.locationL.text = store.address;
    self.distanceL.text = store.distance;
}

@end
