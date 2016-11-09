//
//  AccountCenterHeader.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "AccountCenterHeader.h"
#import "UIImageView+WebCache.h"
#import "TipButton.h"

@interface AccountCenterHeader ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIButton *settingBtn;
@property (weak, nonatomic) IBOutlet TipButton *messageBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UIView *headBgView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgRatio;
@end

@implementation AccountCenterHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    
    self.headBgView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
    self.headImageView.backgroundColor = [UIColor whiteColor];
    
    [self setupLayer:self.headBgView.layer];
    [self setupLayer:self.headImageView.layer];
    
    self.settingBtn.tag = AccountCenterHeaderActionTypeSoftwareSetting;
    self.messageBtn.tag = AccountCenterHeaderActionTypeMessageCenter;
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.headBgView addGestureRecognizer:tapGR];
}

- (void)setupLayer:(CALayer *)layer {
    layer.cornerRadius = CGRectGetWidth(layer.frame) * 0.5;
    layer.masksToBounds = YES;
    //layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    //layer.borderWidth = LINE_H;
}

- (void)setModel:(AccountCenterModel *)model {
    _model = model;
    AccountCenterUserInfo *userInfo = model.data.userInfo;
    if (userInfo) {
        self.headBgView.tag = AccountCenterHeaderActionTypeAccountSetting;
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:userInfo.headUrl] placeholderImage:[UIImage imageNamed:@"userCenter_header_boy"]];
        self.nameL.text = userInfo.usrName;
    }else{
        self.headBgView.tag = AccountCenterHeaderActionTypeLogin;
        self.headImageView.image = [UIImage imageNamed:@"userCenter_header_noLogin"];
        self.nameL.text = @"点击登录";
    }
    
    AccountCenterUserCount *userCount = model.data.userCount;
    self.messageBtn.badgeValue = userCount.unReadMsgCount;
}
- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(accountCenterHeader:actionType:value:)]) {
        [self.delegate accountCenterHeader:self actionType:sender.tag value:nil];
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    UIView *view = tapGR.view;
    if ([self.delegate respondsToSelector:@selector(accountCenterHeader:actionType:value:)]) {
        [self.delegate accountCenterHeader:self actionType:view.tag value:nil];
    }
}

@end
