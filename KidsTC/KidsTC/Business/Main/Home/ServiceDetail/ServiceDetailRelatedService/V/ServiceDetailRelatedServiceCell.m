//
//  ServiceDetailRelatedServiceCell.m
//  KidsTC
//
//  Created by Altair on 1/21/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "ServiceDetailRelatedServiceCell.h"
#import "RichPriceView.h"
#import "UIButton+Category.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "ToolBox.h"
@interface ServiceDetailRelatedServiceCell ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *serviceNameLabel;
@property (weak, nonatomic) IBOutlet RichPriceView *promotionPriceView;
@property (weak, nonatomic) IBOutlet RichPriceView *originalPriceView;
@property (weak, nonatomic) IBOutlet UILabel *saleCountLabel;

@end

@implementation ServiceDetailRelatedServiceCell

- (void)awakeFromNib {
    // Initialization code
    [self setBackgroundColor:COLOR_BG_CEll];
    
    [self.saleCountLabel setTextColor:[UIColor darkGrayColor]];
    
    //price view
    [self.promotionPriceView setContentColor:COLOR_PINK];
    [self.promotionPriceView setUnitFont:[UIFont systemFontOfSize:16]];
    [self.promotionPriceView setPriceFont:[UIFont systemFontOfSize:20]];
    
    [self.originalPriceView setContentColor:[UIColor lightGrayColor]];
    [self.originalPriceView setUnitFont:[UIFont systemFontOfSize:12]];
    [self.originalPriceView setPriceFont:[UIFont systemFontOfSize:12]];
    [self.originalPriceView setSlashed:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configWithModel:(ServiceMoreDetailHotSalesItemModel *)model {
    [self.cellImageView sd_setImageWithURL:model.imageUrl];
    [self.serviceNameLabel setText:model.serviceName];
    [self.promotionPriceView setPrice:model.price];
    if (model.price >= model.originalPrice) {
        [self.originalPriceView setHidden:YES];
    } else {
        [self.originalPriceView setHidden:NO];
        [self.originalPriceView setPrice:model.originalPrice];
    }
    if (model.saleCount > 0) {
        NSString *countString = [NSString stringWithFormat:@"%lu", (unsigned long)model.saleCount];
        NSString *wholeString = [NSString stringWithFormat:@"已售%@", countString];
        NSMutableAttributedString *labelString = [[NSMutableAttributedString alloc] initWithString:wholeString];
        NSDictionary *attribute = [NSDictionary dictionaryWithObject:COLOR_TEXT forKey:NSForegroundColorAttributeName];
        [labelString setAttributes:attribute range:NSMakeRange(2, [countString length])];
        [self.saleCountLabel setAttributedText:labelString];
    } else {
        [self.saleCountLabel setText:@""];
    }
}

+ (CGFloat)cellHeight {
    return 100;
}

@end
