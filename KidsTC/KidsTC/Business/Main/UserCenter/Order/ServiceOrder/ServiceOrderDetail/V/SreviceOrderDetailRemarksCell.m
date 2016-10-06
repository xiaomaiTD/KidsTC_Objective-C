//
//  SreviceOrderDetailRemarksCell.m
//  KidsTC
//
//  Created by zhanping on 8/15/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "SreviceOrderDetailRemarksCell.h"

@interface SreviceOrderDetailRemarksCell ()
@property (weak, nonatomic) IBOutlet UILabel *remarksLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;

@end

@implementation SreviceOrderDetailRemarksCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineConstraintHeight.constant = LINE_H;
}

- (void)setData:(ServiceOrderDetailData *)data{
    [super setData:data];
    self.remarksLabel.attributedText = data.remarksStr;
}

@end
