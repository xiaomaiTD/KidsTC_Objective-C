//
//  SoftwareSettingViewCell.m
//  KidsTC
//
//  Created by zhanping on 7/26/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "SoftwareSettingViewCell.h"

@interface SoftwareSettingViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@end
@implementation SoftwareSettingViewCell

- (void)setModel:(SoftwareSettingModel *)model{
    _model = model;
    self.titleLabel.text = model.title;
    self.subTitleLabel.text = model.subTitle;
    self.arrowImageView.hidden = !model.showArrow;
}

@end
