//
//  AppointmentOrderListCell.m
//  KidsTC
//
//  Created by 钱烨 on 8/11/15.
//  Copyright (c) 2015 KidsTC. All rights reserved.
//

#import "AppointmentOrderListCell.h"
#import "ToolBox.h"
#import "UIImage+Category.h"
#import "UIImageView+WebCache.h"

@interface AppointmentOrderListCell ()
@property (weak, nonatomic) IBOutlet UIView *headerBG;
@property (weak, nonatomic) IBOutlet UIView *infoBG;

@property (weak, nonatomic) IBOutlet UILabel *orderIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStatusDesLabel;
@property (weak, nonatomic) IBOutlet UIView *gapLine;
@property (weak, nonatomic) IBOutlet UIImageView *storeImageView;
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *appointmentTimeDesLabel;

@end

@implementation AppointmentOrderListCell

- (void)awakeFromNib {
    
    [ToolBox resetLineView:self.gapLine withLayoutAttribute:NSLayoutAttributeHeight];
    [self.headerBG setBackgroundColor:[UIColor whiteColor]];
    [self.infoBG setBackgroundColor:[UIColor whiteColor]];
    
    [self.orderStatusDesLabel setTextColor:COLOR_PINK];
}

- (void)configWithOrderModel:(AppointmentOrderModel *)model {
    if (model) {
        [self.orderIdLabel setText:model.orderId];
        [self.orderStatusDesLabel setText:model.statusDescription];
        [self.storeImageView sd_setImageWithURL:model.imageUrl placeholderImage:PLACEHOLDERIMAGE_SMALL];
        [self.storeName setText:model.storeName];
        [self.appointmentTimeDesLabel setText:model.appointmentTimeDes];
    }
}

+ (CGFloat)cellHeight {
    return 140;
}

@end
