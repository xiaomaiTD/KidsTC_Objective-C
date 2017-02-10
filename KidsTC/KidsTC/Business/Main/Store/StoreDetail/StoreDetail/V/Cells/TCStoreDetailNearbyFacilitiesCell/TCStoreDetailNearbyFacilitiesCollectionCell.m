//
//  TCStoreDetailNearbyFacilitiesCollectionCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/9.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "TCStoreDetailNearbyFacilitiesCollectionCell.h"

#import "UIImageView+WebCache.h"
#import "NSString+Category.h"

@interface TCStoreDetailNearbyFacilitiesCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameL;

@end

@implementation TCStoreDetailNearbyFacilitiesCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameL.layer.cornerRadius = 4;
    self.nameL.layer.masksToBounds = YES;
    self.nameL.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.nameL.layer.borderWidth = LINE_H;
}

- (void)setFacility:(TCStoreDetailFacility *)facility {
    _facility = facility;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:facility.imgUrl]];
    self.nameL.text = facility.name;
}

@end
