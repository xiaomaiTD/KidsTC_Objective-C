//
//  StoreDetailAppointmentPreferenceTipCell.m
//  KidsTC
//
//  Created by zhanping on 8/21/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "StoreDetailAppointmentPreferenceTipCell.h"

@interface StoreDetailAppointmentPreferenceTipCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;

@end

@implementation StoreDetailAppointmentPreferenceTipCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineConstraintHeight.constant = LINE_H;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
