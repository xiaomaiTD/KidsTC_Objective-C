//
//  WholesaleSettlementPayTypeCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleSettlementPayTypeCell.h"

@interface WholesaleSettlementPayTypeCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineOneH;

@property (weak, nonatomic) IBOutlet UIView *aliBGView;
@property (weak, nonatomic) IBOutlet UIButton *aliBtn;
@property (weak, nonatomic) IBOutlet UIImageView *aliLogo;
@property (weak, nonatomic) IBOutlet UILabel *aliNameL;
@property (weak, nonatomic) IBOutlet UIImageView *aliSelectImg;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineTwoH;

@property (weak, nonatomic) IBOutlet UIView *weChatBGView;
@property (weak, nonatomic) IBOutlet UIButton *weChatBtn;
@property (weak, nonatomic) IBOutlet UIImageView *weChatLogo;
@property (weak, nonatomic) IBOutlet UILabel *weChatNameL;
@property (weak, nonatomic) IBOutlet UIImageView *weChatSelectImg;
@property (weak, nonatomic) IBOutlet UILabel *weChatInstallL;

@end

@implementation WholesaleSettlementPayTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.HLineOneH.constant = LINE_H;
    self.HLineTwoH.constant = LINE_H;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
