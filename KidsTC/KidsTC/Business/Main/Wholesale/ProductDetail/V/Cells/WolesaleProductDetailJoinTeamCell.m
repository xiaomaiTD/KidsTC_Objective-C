//
//  WolesaleProductDetailJoinTeamCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WolesaleProductDetailJoinTeamCell.h"
#import "UIImageView+WebCache.h"

@interface WolesaleProductDetailJoinTeamCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (weak, nonatomic) IBOutlet UIView *actionBGView;
@property (weak, nonatomic) IBOutlet UILabel *actionTipL;
@property (weak, nonatomic) IBOutlet UIImageView *successLog;
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

- (void)setTeam:(WholesaleProductDetailTeam *)team {
    _team = team;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:team.userImg] placeholderImage:PLACEHOLDERIMAGE_SMALL_LOG];
    self.nameL.text = team.userName;
    self.tipL.text = [NSString stringWithFormat:@"还差%zd人成团",team.surplusCount];
    self.tipL.hidden = team.surplusCount<=0;
    self.successLog.hidden = team.surplusCount>0;
    
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(wolesaleProductDetailBaseCell:actionType:value:)]) {
        [self.delegate wolesaleProductDetailBaseCell:self actionType:WolesaleProductDetailBaseCellActionTypeJoinOther value:_team];
    }
}
@end
