//
//  AddressPickerViewCell.m
//  KidsTC
//
//  Created by zhanping on 8/4/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "AddressPickerViewCell.h"

@interface AddressPickerViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *checkAccessoryView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;
@end

@implementation AddressPickerViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineConstraintHeight.constant = LINE_H;
    UIView *selectedBGView = [[UIView alloc]init];
    selectedBGView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.selectedBackgroundView = selectedBGView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.checkAccessoryView.hidden = !selected;
    self.titleLabel.textColor = selected?COLOR_PINK:[UIColor darkGrayColor];
    
}

@end
