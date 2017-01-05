//
//  WholesaleOrderDetailJoinMemberCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleOrderDetailJoinMemberCell.h"
#import "UIImageView+WebCache.h"

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

- (void)setPartner:(WholesaleOrderDetailPartner *)partner {
    _partner = partner;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:_partner.userImg] placeholderImage:PLACEHOLDERIMAGE_SMALL_LOG];
    self.nameL.text = _partner.userName;
    self.tipL.text = [NSString stringWithFormat:@"%@ %@",_partner.time,(_partner.isHead?@"开团":@"参团")];
    self.leaderTipIcon.hidden  = !_partner.isHead;
}

@end
