//
//  StoreListViewCell.m
//  KidsTC
//
//  Created by 钱烨 on 7/13/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//

#import "StoreListViewCell.h"
#import "AUIStackView.h"
#import "ToolBox.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"

@interface StoreListViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *stroeImageView;
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet AUIStackView *promotionLogoView;
@property (weak, nonatomic) IBOutlet FiveStarsView *starsView;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;
@property (weak, nonatomic) IBOutlet UIView *activityBGView;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *bizZoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *featureLable;
@property (weak, nonatomic) IBOutlet UIView *separateView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstrantHeight;

- (void)buildActivitysViewWithActivityLogoItems:(NSArray *)items;

@end

@implementation StoreListViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.contentView setBackgroundColor:COLOR_BG_CEll];
    [ToolBox resetLineView:self.separateView withLayoutAttribute:NSLayoutAttributeHeight];
    self.HLineConstrantHeight.constant = LINE_H;
    self.stroeImageView.layer.cornerRadius = 4;
    self.stroeImageView.layer.masksToBounds = YES;
    self.stroeImageView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.stroeImageView.layer.borderWidth = LINE_H;
    self.distanceLabel.textColor = COLOR_BLUE;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark Private methods

- (void)buildActivitysViewWithActivityLogoItems:(NSArray *)items {
    for (UIView *subView in self.activityBGView.subviews) {
        [subView removeFromSuperview];
    }
    
    CGFloat yPosition = 0;
    for (ActivityLogoItem *item in items) {
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, yPosition, self.activityBGView.frame.size.width, 20)];
        UIImageView *checkImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 2.5, 15, 15)];
        [checkImageView setImage:item.image];
        [bgView addSubview:checkImageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(18, 0, bgView.frame.size.width - 20, 20)];
        [label setTextColor:[UIColor orangeColor]];
        [label setFont:[UIFont systemFontOfSize:13]];
        [label setText:item.itemDescription];
        [bgView addSubview:label];
        
        [self.activityBGView addSubview:bgView];
        
        yPosition += bgView.frame.size.height + 5;
    }
}

#pragma mark Public methods

- (void)configWithItemModel:(StoreListItemModel *)model {
    if (!model) return;
    [self.stroeImageView sd_setImageWithURL:model.imageUrl placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    [self.storeName setText:model.storeName];
    [self.starsView setStarNumber:model.starNumber];
    [self.distanceLabel setText:model.distanceDescription];
    [self.bizZoneLabel setText:model.businessZone];
    [self.featureLable setText:model.feature];
    if (model.commentCount > 0) {
        NSString *commentCountString = [NSString stringWithFormat:@"%lu", (unsigned long)model.commentCount];
        NSString *wholeString = [NSString stringWithFormat:@"%@条热评", commentCountString];
        NSMutableAttributedString *labelString = [[NSMutableAttributedString alloc] initWithString:wholeString];
        NSDictionary *attribute = [NSDictionary dictionaryWithObject:COLOR_PINK forKey:NSForegroundColorAttributeName];
        [labelString setAttributes:attribute range:NSMakeRange(0, [commentCountString length])];
        [self.commentCountLabel setAttributedText:labelString];
    } else {
        [self.commentCountLabel setText:@""];
    }
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    for (PromotionLogoItem *item in model.promotionLogoItems) {
        UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 13, 13)];
        [logoView setImage:item.image];
        [tempArray addObject:logoView];
    }
    [self.promotionLogoView setSubViews:[NSArray arrayWithArray:tempArray]];
    if ([model.activityLogoItems count] > 0) {
        [self.separateView setHidden:NO];
    } else {
        [self.separateView setHidden:YES];
    }
    [self buildActivitysViewWithActivityLogoItems:model.activityLogoItems];
}

@end
