//
//  AppointmentListViewHeaderTabCell.m
//  KidsTC
//
//  Created by 钱烨 on 8/12/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//

#import "AppointmentListViewHeaderTabCell.h"

@interface AppointmentListViewHeaderTabCell ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *tagView;

@end

@implementation AppointmentListViewHeaderTabCell

- (void)awakeFromNib {
    
    [self.bgView setBackgroundColor:COLOR_BG_CEll];
    [self.tagView setBackgroundColor:COLOR_PINK];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    [self.tagView setHidden:!selected];
    self.titleLabel.textColor = selected?COLOR_PINK:[UIColor darkGrayColor];
}

@end
