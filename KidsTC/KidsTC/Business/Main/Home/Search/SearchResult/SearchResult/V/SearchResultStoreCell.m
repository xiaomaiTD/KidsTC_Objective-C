//
//  SearchResultStoreCell.m
//  KidsTC
//
//  Created by 詹平 on 16/7/6.
//  Copyright © 2016年 KidsTC. All rights reserved.
//

#import "SearchResultStoreCell.h"
#import "FiveStarsView.h"
#import "GHeader.h"


@interface SearchResultStoreCell ()
@property (weak, nonatomic) IBOutlet UIView *imageBGView;
@property (weak, nonatomic) IBOutlet UIImageView *storeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *couponImageView;
@property (weak, nonatomic) IBOutlet FiveStarsView *startsView;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *featureLabel;
@property (weak, nonatomic) IBOutlet UILabel *businessZoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UIView *horizontalLine;

@property (weak, nonatomic) IBOutlet UILabel *firstStoreGiftLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstFullCutLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstStoreDiscountLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstStoreGiftLabelHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstFullCutLabelHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *firstStoreDiscountLabelHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HlineConstraintHeight;

@end

@implementation SearchResultStoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIView *selectedBackgroundView = [[UIView alloc]init];
    selectedBackgroundView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.selectedBackgroundView = selectedBackgroundView;
    self.imageBGView.layer.cornerRadius = 4;
    self.imageBGView.layer.masksToBounds = YES;
    self.imageBGView.layer.borderWidth = LINE_H;
    self.imageBGView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.horizontalLine.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.distanceLabel.textColor = COLOR_BLUE;
    self.HlineConstraintHeight.constant = LINE_H;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.distanceLabel setNeedsUpdateConstraints];
    [self.distanceLabel updateConstraintsIfNeeded];
    [self.distanceLabel setNeedsLayout];
    [self.distanceLabel layoutIfNeeded];
}

- (void)setItem:(SearchResultStoreItem *)item{
    _item = item;
    
    [self.storeImageView sd_setImageWithURL:[NSURL URLWithString:item.imgUrl] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    self.couponImageView.hidden = !item.isHaveCoupon;
    self.startsView.starNumber = item.level;
    self.storeNameLabel.text = item.storeName;
    self.commentCountLabel.attributedText = item.commentCountStr;
    self.featureLabel.text = item.feature;
    self.businessZoneLabel.text = item.businessZone;
    self.distanceLabel.text = item.distance;
    self.horizontalLine.hidden = !item.isHaveActivity;
    
    self.firstStoreGiftLabel.attributedText = item.firstStoreGiftStr;
    self.firstFullCutLabel.attributedText = item.firstFullCutStr;
    self.firstStoreDiscountLabel.attributedText = item.firstStoreDiscountStr;
    
    self.firstStoreGiftLabelHeightConstraint.constant = item.firstStoreGiftStr.length>0?24:0;
    self.firstFullCutLabelHeightConstraint.constant = item.firstFullCutStr.length>0?24:0;
    self.firstStoreDiscountLabelHeightConstraint.constant = item.firstStoreDiscountStr.length>0?24:0;
}

@end
