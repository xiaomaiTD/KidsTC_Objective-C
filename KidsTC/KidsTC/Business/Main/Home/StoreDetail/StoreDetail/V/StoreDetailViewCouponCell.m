//
//  StoreDetailViewCouponCell.m
//  KidsTC
//
//  Created by Altair on 12/3/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "StoreDetailViewCouponCell.h"

@implementation StoreDetailViewCouponCell

- (void)awakeFromNib {
    // Initialization code
    [self.contentView setBackgroundColor:COLOR_BG_CEll];
    [self.descriptionLabel setTextColor:COLOR_PINK];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
