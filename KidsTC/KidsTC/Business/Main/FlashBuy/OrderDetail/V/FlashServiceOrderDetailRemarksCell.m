//
//  FlashServiceOrderDetailRemarksCell.m
//  KidsTC
//
//  Created by zhanping on 8/17/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "FlashServiceOrderDetailRemarksCell.h"

@interface FlashServiceOrderDetailRemarksCell ()
@property (weak, nonatomic) IBOutlet UILabel *remarksLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;
@end

@implementation FlashServiceOrderDetailRemarksCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineConstraintHeight.constant = LINE_H;
}

- (void)setData:(FlashServiceOrderDetailData *)data{
    [super setData:data];
    self.remarksLabel.attributedText = data.remarksStr;
}

@end
