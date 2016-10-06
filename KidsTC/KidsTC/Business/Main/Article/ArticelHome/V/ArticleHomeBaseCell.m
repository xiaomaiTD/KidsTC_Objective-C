//
//  ArticleHomeBaseCell.m
//  KidsTC
//
//  Created by zhanping on 9/1/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import "ArticleHomeBaseCell.h"

@interface ArticleHomeBaseCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;

@end

@implementation ArticleHomeBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _HLineConstraintHeight.constant = LINE_H;
    
    UIView *selectedBackgroundView = [[UIView alloc]init];
    selectedBackgroundView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
    self.selectedBackgroundView = selectedBackgroundView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
