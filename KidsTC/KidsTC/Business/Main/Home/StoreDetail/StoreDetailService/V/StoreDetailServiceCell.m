//
//  StoreDetailServiceCell.m
//  KidsTC
//
//  Created by Altair on 1/16/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "StoreDetailServiceCell.h"
#import "RichPriceView.h"
#import "UIImage+Category.h"
#import "UIImageView+WebCache.h"
@interface StoreDetailServiceCell ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *serviceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceDesLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *serviceDesAlign;
@property (weak, nonatomic) IBOutlet UILabel *storeDesLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceDesLabel;
@property (weak, nonatomic) IBOutlet RichPriceView *priceView;

@end

@implementation StoreDetailServiceCell

- (void)awakeFromNib {
    [self.bgView setBackgroundColor:COLOR_BG_CEll];
    // Initialization code
    [self.priceDesLabel setTextColor:COLOR_PINK];
    
    [self.priceView setContentColor:COLOR_PINK];
    [self.priceView setUnitFont:[UIFont systemFontOfSize:12]];
    [self.priceView setPriceFont:[UIFont systemFontOfSize:16]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configWithModel:(StoreOwnedServiceModel *)model {
    [self.serviceNameLabel setText:model.serviceName];
    [self.serviceDesLabel setText:model.serviceDescription];
    [self.cellImageView sd_setImageWithURL:model.imageUrl];
    if ([model.priceDescription length] == 0) {
        [self.priceDesLabel setHidden:YES];
    } else {
        [self.priceDesLabel setHidden:NO];
        [self.priceDesLabel setText:[NSString stringWithFormat:@"%@:", model.priceDescription]];
    }
    [self.priceView setPrice:model.price];
    
    if (model.storeCount > 1) {
        [self.storeDesLabel setHidden:NO];
        self.serviceDesAlign.constant = -25;
        
        NSString *countString = [NSString stringWithFormat:@"%lu", (unsigned long)model.storeCount];
        NSString *wholeString = [NSString stringWithFormat:@"%@家门店通用", countString];
        NSMutableAttributedString *labelString = [[NSMutableAttributedString alloc] initWithString:wholeString];
        NSDictionary *attribute = [NSDictionary dictionaryWithObject:COLOR_TEXT forKey:NSForegroundColorAttributeName];
        [labelString setAttributes:attribute range:NSMakeRange(0, [countString length])];
        [self.storeDesLabel setAttributedText:labelString];
    } else {
        [self.storeDesLabel setHidden:YES];
        self.serviceDesAlign.constant = -3;
    }
}

+ (CGFloat)cellHeight {
    return 100;
}

@end
