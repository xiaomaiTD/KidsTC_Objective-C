//
//  KTCBrowseHistoryViewStoreCell.m
//  KidsTC
//
//  Created by Altair on 12/3/15.
//  Copyright © 2015 KidsTC. All rights reserved.
//

#import "KTCBrowseHistoryViewStoreCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
@interface KTCBrowseHistoryViewStoreCell ()

@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bizZoneLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;

@end

@implementation KTCBrowseHistoryViewStoreCell

- (void)awakeFromNib {
    // Initialization code
    [self.contentView setBackgroundColor:COLOR_BG_CEll];
    
    self.cellImageView.layer.cornerRadius = 4;
    self.cellImageView.layer.masksToBounds = YES;
    self.HLineH.constant = LINE_H;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)configWithModel:(BrowseHistoryStoreListItemModel *)model {
    if (model) {
        [self.cellImageView sd_setImageWithURL:model.imageUrl placeholderImage:PLACEHOLDERIMAGE_SMALL];
        [self.titleLabel setText:model.name];
        [self.bizZoneLabel setText:model.bizZone];
    }
}

+ (CGFloat)cellHeight {
    return (SCREEN_WIDTH / 4) - 20 + 60;
}

@end
