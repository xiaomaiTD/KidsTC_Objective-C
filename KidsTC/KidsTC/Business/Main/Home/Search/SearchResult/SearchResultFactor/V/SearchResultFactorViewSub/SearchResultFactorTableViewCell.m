//
//  SearchResultFactorTableViewCell.m
//  KidsTC
//
//  Created by zhanping on 6/29/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "SearchResultFactorTableViewCell.h"
#import "Macro.h"
#import "UIImage+Category.h"
@interface SearchResultFactorTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *verticalLine;
@property (weak, nonatomic) IBOutlet UIView *horizontalLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;

@end

@implementation SearchResultFactorTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIColor *lineColor = [UIColor groupTableViewBackgroundColor];
    self.verticalLine.backgroundColor = lineColor;
    self.horizontalLine.backgroundColor = lineColor;
    
    self.leftTip.image = [UIImage imageWithColor:COLOR_PINK];
    self.leftTip.layer.cornerRadius = CGRectGetWidth(self.leftTip.frame)*0.5;
    self.leftTip.layer.masksToBounds = YES;
    
    self.rightTip.image = [UIImage imageWithColor:COLOR_PINK];
    
    self.accessoryImageView.image = [UIImage imageNamed:@"select_no"];
    self.HLineConstraintHeight.constant = LINE_H;
}

- (void)setSelfDefineSelected:(BOOL)selected animated:(BOOL)animated {

    UIColor *titleColor = nil;
    if (selected) {
        titleColor = COLOR_PINK;
    }else{
        titleColor = [UIColor darkGrayColor];
    }
    self.titleLabel.textColor = titleColor;

}

- (void)setItem:(SearchResultFactorItem *)item{
    _item = item;
    self.titleLabel.text = item.title;
}

@end
