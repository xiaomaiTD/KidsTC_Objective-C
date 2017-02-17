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
@property (weak, nonatomic) IBOutlet UILabel *priceL;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@end

@implementation KTCBrowseHistoryViewServiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.contentView setBackgroundColor:COLOR_BG_CEll];
    
    self.cellImageView.layer.cornerRadius = 4;
    self.cellImageView.layer.masksToBounds = YES;
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.HLineH.constant = LINE_H;
}


- (void)configWithModel:(BrowseHistoryServiceListItemModel *)model {
    if (model) {
        [self.cellImageView sd_setImageWithURL:model.imageUrl placeholderImage:PLACEHOLDERIMAGE_SMALL];
        [self.titleLabel setText:model.name];
        self.priceL.text = model.priceStr;
    }
}

+ (CGFloat)cellHeight {
    return (SCREEN_WIDTH / 4) - 20 + 60;
}

@end
