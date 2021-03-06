//
//  ActivityViewCell.m
//  KidsTC
//
//  Created by 钱烨 on 10/8/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "ActivityViewCell.h"
#import "RichPriceView.h"
#import "ActivityListItemModel.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"

@interface ActivityViewCell ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *mainImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet RichPriceView *priceView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UILabel *tipsLabel;

@end

@implementation ActivityViewCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    [self.priceView setContentColor:COLOR_PINK];
    [self.priceView setUnitFont:[UIFont systemFontOfSize:20]];
    [self.priceView setPriceFont:[UIFont systemFontOfSize:30]];
    
    self.progressView.layer.cornerRadius = 5;
    self.progressView.layer.borderColor = COLOR_PINK.CGColor;
    self.progressView.layer.borderWidth = LINE_H;
    self.progressView.layer.masksToBounds = YES;
}

- (void)configWithItemModel:(ActivityListItemModel *)itemModel {
    if (itemModel) {
        NSArray *constraintsArray = [self.mainImageView constraints];
        for (NSLayoutConstraint *constraint in constraintsArray) {
            if (constraint.firstAttribute == NSLayoutAttributeHeight) {
                //height constraint
                //new
                constraint.constant = itemModel.ratio * SCREEN_WIDTH;
                break;
            }
        }
        [self.mainImageView sd_setImageWithURL:itemModel.imageUrl placeholderImage:PLACEHOLDERIMAGE_BIG];
        [self.titleLabel setText:itemModel.title];
        [self.contentLabel setText:itemModel.activityContent];
        [self.priceView setPrice:itemModel.price];
        [self.progressView setProgress:itemModel.percent / 100 animated:YES];
        //tips
        if (itemModel.leftNumber == 0) {
            NSString *tip = @"人数已满";
            [self.tipsLabel setText:tip];
        } else {
            NSString *wholeString = [NSString stringWithFormat:@"已售%.f%%，剩余%zd", itemModel.percent, itemModel.leftNumber];
            NSMutableAttributedString *labelString = [[NSMutableAttributedString alloc] initWithString:wholeString];
            NSDictionary *attribute = [NSDictionary dictionaryWithObject:COLOR_BLUE forKey:NSForegroundColorAttributeName];
            NSUInteger commaIndex = [wholeString rangeOfString:@"，"].location;
            NSRange percentRange = NSMakeRange(2, commaIndex - 2);
            NSRange leftRange = NSMakeRange(commaIndex + 3, [wholeString length] - commaIndex - 3);
            [labelString setAttributes:attribute range:percentRange];
            [labelString addAttributes:attribute range:leftRange];
            [self.tipsLabel setAttributedText:labelString];
        }
    }
}

@end
