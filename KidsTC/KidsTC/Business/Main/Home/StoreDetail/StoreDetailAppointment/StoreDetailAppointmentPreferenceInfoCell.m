//
//  StoreDetailAppointmentPreferenceInfoCell.m
//  KidsTC
//
//  Created by zhanping on 8/21/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "StoreDetailAppointmentPreferenceInfoCell.h"

@interface StoreDetailAppointmentPreferenceInfoCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;
@end

@implementation StoreDetailAppointmentPreferenceInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineConstraintHeight.constant = LINE_H;
}


- (void)setActiveModelsArray:(NSArray<ActivityLogoItem *> *)activeModelsArray {
    [super setActiveModelsArray:activeModelsArray];
    if (self.tag<activeModelsArray.count) {
        ActivityLogoItem *item = activeModelsArray[self.tag];
        self.iconImageView.image = item.image;
        self.valueLabel.text = item.itemDescription;
    }
}

@end
