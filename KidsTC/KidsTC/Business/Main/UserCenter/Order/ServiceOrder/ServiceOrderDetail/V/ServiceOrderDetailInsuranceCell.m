//
//  ServiceOrderDetailInsuranceCell.m
//  KidsTC
//
//  Created by zhanping on 8/15/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ServiceOrderDetailInsuranceCell.h"

@interface ServiceOrderDetailInsuranceCell ()
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;

@end

@implementation ServiceOrderDetailInsuranceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineConstraintHeight.constant = LINE_H;
}

- (void)setData:(ServiceOrderDetailData *)data{
    [super setData:data];
    self.tipLabel.attributedText = data.insurance.tipStr;
}

@end
