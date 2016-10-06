//
//  KTCBrowseHistoryViewServiceCell.m
//  KidsTC
//
//  Created by Altair on 12/3/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "KTCBrowseHistoryViewServiceCell.h"
#import "RichPriceView.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"

@interface KTCBrowseHistoryViewServiceCell ()

@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet RichPriceView *priceView;

@end

@implementation KTCBrowseHistoryViewServiceCell

- (void)awakeFromNib {
    // Initialization code
    [self.contentView setBackgroundColor:COLOR_BG_CEll];
    
    self.cellImageView.layer.cornerRadius = 5;
    self.cellImageView.layer.masksToBounds = YES;
    
    //price view
    [self.priceView setContentColor:COLOR_PINK];
    [self.priceView setUnitFont:[UIFont systemFontOfSize:10]];
    [self.priceView setPriceFont:[UIFont systemFontOfSize:15]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configWithModel:(BrowseHistoryServiceListItemModel *)model {
    if (model) {
        [self.cellImageView sd_setImageWithURL:model.imageUrl placeholderImage:PLACEHOLDERIMAGE_SMALL];
        [self.titleLabel setText:model.name];
        [self.priceView setPrice:model.price];
    }
}

+ (CGFloat)cellHeight {
    return (SCREEN_WIDTH / 4) - 20 + 60;
}

@end
