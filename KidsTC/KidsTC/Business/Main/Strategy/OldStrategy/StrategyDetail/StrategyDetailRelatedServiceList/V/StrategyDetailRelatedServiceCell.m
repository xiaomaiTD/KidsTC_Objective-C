//
//  StrategyDetailRelatedServiceCell.m
//  KidsTC
//
//  Created by Altair on 1/22/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "StrategyDetailRelatedServiceCell.h"
#import "RichPriceView.h"
#import "ToolBox.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"

@interface StrategyDetailRelatedServiceCell ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *serviceNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *serviceDesLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *serviceDesAlign;
@property (weak, nonatomic) IBOutlet UILabel *storeDesLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceDesLabel;
@property (weak, nonatomic) IBOutlet UILabel *saleCountLabel;
@property (weak, nonatomic) IBOutlet UIView *gapView;

@end

@implementation StrategyDetailRelatedServiceCell

- (void)awakeFromNib {
    [self.bgView setBackgroundColor:COLOR_BG_CEll];
    // Initialization code
    [self.priceDesLabel setTextColor:COLOR_PINK];
    
    [ToolBox resetLineView:self.gapView withLayoutAttribute:NSLayoutAttributeHeight];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)configWithModel:(StrategyDetailServiceItemModel *)model {
    [self.serviceNameLabel setText:model.serviceName];
    [self.serviceDesLabel setText:model.serviceDescription];
    [self.cellImageView sd_setImageWithURL:model.imageUrl placeholderImage:PLACEHOLDERIMAGE_SMALL_LOG];
    
    NSString *priceString = [NSString stringWithFormat:@"%g元", model.price];
    [self.priceDesLabel setText:priceString];
    
    if (model.saleCount > 0) {
        NSString *countString = [NSString stringWithFormat:@"%lu", (unsigned long)model.saleCount];
        NSString *wholeString = wholeString = [NSString stringWithFormat:@"已有%@人购买", countString];
        NSMutableAttributedString *labelString = [[NSMutableAttributedString alloc] initWithString:wholeString];
        NSDictionary *attribute = [NSDictionary dictionaryWithObject:COLOR_TEXT forKey:NSForegroundColorAttributeName];
        [labelString setAttributes:attribute range:NSMakeRange(2, [countString length])];
        [self.saleCountLabel setAttributedText:labelString];
    } else {
        [self.saleCountLabel setText:@""];
    }
    
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
