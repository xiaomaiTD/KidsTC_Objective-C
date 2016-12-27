//
//  WholesaleOrderDetailJoinMemberCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleOrderDetailJoinMemberCell.h"

@interface WholesaleOrderDetailJoinMemberCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (weak, nonatomic) IBOutlet UIImageView *leaderTipIcon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@end

@implementation WholesaleOrderDetailJoinMemberCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    self.icon.layer.cornerRadius = CGRectGetHeight(self.icon.frame) * 0.5;
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.borderWidth = LINE_H;
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.HLineH.constant = LINE_H;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
