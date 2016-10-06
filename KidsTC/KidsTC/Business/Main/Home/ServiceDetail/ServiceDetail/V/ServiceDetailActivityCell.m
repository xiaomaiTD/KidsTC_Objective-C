//
//  ServiceDetailActivityCell.m
//  KidsTC
//
//  Created by Altair on 1/5/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "ServiceDetailActivityCell.h"

@implementation ServiceDetailActivityCell

- (void)awakeFromNib {
    // Initialization code
    [self.contentView setBackgroundColor:COLOR_BG_CEll];
    [self.descriptionLabel setTextColor:COLOR_PINK];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configWithModel:(ActivityLogoItem *)model {
    [self.activeImageView setImage:model.image];
    [self.descriptionLabel setText:model.itemDescription];
}

@end
