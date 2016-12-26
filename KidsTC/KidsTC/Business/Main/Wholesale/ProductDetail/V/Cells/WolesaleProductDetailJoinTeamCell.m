//
//  WolesaleProductDetailJoinTeamCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WolesaleProductDetailJoinTeamCell.h"

@interface WolesaleProductDetailJoinTeamCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (weak, nonatomic) IBOutlet UIView *actionBGView;
@property (weak, nonatomic) IBOutlet UILabel *actionTipL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@end

@implementation WolesaleProductDetailJoinTeamCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.icon.layer.borderWidth = LINE_H;
    self.icon.layer.cornerRadius = CGRectGetHeight(self.icon.frame) * 0.5;
    self.icon.layer.masksToBounds = YES;
    
    self.actionBGView.backgroundColor = [UIColor colorFromHexString:@"F36863"];
    
    self.infoView.layer.cornerRadius = CGRectGetHeight(self.infoView.frame) * 0.5;
    self.infoView.layer.masksToBounds = YES;
    self.infoView.layer.borderWidth = 1;
    self.infoView.layer.borderColor = [UIColor colorFromHexString:@"F36863"].CGColor;
    
    self.HLineH.constant = LINE_H;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
