//
//  WolesaleProductDetailAddressCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WolesaleProductDetailAddressCell.h"

@interface WolesaleProductDetailAddressCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;

@end

@implementation WolesaleProductDetailAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
