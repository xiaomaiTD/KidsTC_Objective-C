//
//  WolesaleProductDetailV2JoinTeamCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/4.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "WolesaleProductDetailV2JoinTeamCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+Category.h"

@interface WolesaleProductDetailV2JoinTeamCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (weak, nonatomic) IBOutlet UIView *actionBGView;
@property (weak, nonatomic) IBOutlet UILabel *actionTipL;
@property (weak, nonatomic) IBOutlet UIImageView *successLog;
@property (weak, nonatomic) IBOutlet UILabel *countDownL;
@end

@implementation WolesaleProductDetailV2JoinTeamCell

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
    
    [NotificationCenter addObserver:self selector:@selector(countDown) name:kTCCountDownNoti object:nil];
}

- (void)setTeam:(WholesaleProductDetailTeam *)team {
    _team = team;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:team.userImg] placeholderImage:PLACEHOLDERIMAGE_SMALL_LOG];
    self.nameL.text = team.userName;
    self.tipL.text = [NSString stringWithFormat:@"还差%zd人成团",team.surplusCount];
    self.tipL.hidden = team.surplusCount<=0;
    self.successLog.hidden = team.surplusCount>0;
    self.actionTipL.text = team.surplusCount>0?@"去参团":@"已成团";
    [self countDown];
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(wolesaleProductDetailBaseCell:actionType:value:)]) {
        [self.delegate wolesaleProductDetailBaseCell:self actionType:WolesaleProductDetailBaseCellActionTypeJoinOther value:_team];
    }
}

- (void)countDown {
    NSString *str = self.team.countDownValueString;
    if ([str isNotNull] && self.team.surplusCount>0) {
        _countDownL.hidden = NO;
        _countDownL.text = str;
    }else{
        _countDownL.hidden = YES;
        //[NotificationCenter removeObserver:self name:kTCCountDownNoti object:nil];
        if (!self.team.countDownOver) {
            self.team.countDownOver = YES;
        }
    }
}

- (void)dealloc{
    [NotificationCenter removeObserver:self name:kTCCountDownNoti object:nil];
}

@end
