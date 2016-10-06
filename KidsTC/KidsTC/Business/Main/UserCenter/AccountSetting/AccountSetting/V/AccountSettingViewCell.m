//
//  AccountSettingViewCell.m
//  KidsTC
//
//  Created by zhanping on 7/26/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "AccountSettingViewCell.h"
#import "UIImageView+Category.h"
#import "UIImageView+WebCache.h"
#import "User.h"

@interface AccountSettingViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet UIImageView *userHeaderIamgeView;
@end

@implementation AccountSettingViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self layoutIfNeeded];
    self.userHeaderIamgeView.layer.cornerRadius = CGRectGetWidth(self.userHeaderIamgeView.bounds)*0.5;
    self.userHeaderIamgeView.layer.masksToBounds = YES;
}

- (void)setModel:(AccountSettingModel *)model{
    _model = model;
    NSUInteger tag = self.tag;
    
    NSString *title = @"";
    if (tag==0){title = @"头像";}else
    if (tag==1){title = @"阶段";}else
    if (tag==2){title = @"昵称";}else
    if (tag==3){title = @"手机号";}else
    if (tag==4){title = @"地址管理";}else
    if (tag==5){title = @"重置密码";}
    self.titleLabel.text = title;
    
    self.arrowImageView.hidden = tag==3;
    
    self.userHeaderIamgeView.hidden = tag!=0;
    if (!self.userHeaderIamgeView.hidden) {
        RoleSex sex = [User shareUser].role.sex;
        NSString *palceHolder = (sex==RoleSexFemale)?@"userCenter_header_girl":@"userCenter_header_boy";
        [self.userHeaderIamgeView sd_setImageWithURL:[NSURL URLWithString:model.headerUrl] placeholderImage:[UIImage imageNamed:palceHolder]];
    }
    
    self.subTitleLabel.hidden = (tag==0 || tag==4 || tag==5);
    if (!self.subTitleLabel.hidden) {
        self.subTitleLabel.textColor = (tag==3)?[UIColor lightGrayColor]:[UIColor darkGrayColor];
        NSString *subTitle = @"";
        if (tag==1){subTitle = [User shareUser].role.roleName;}else
        if (tag==2){subTitle = model.userName;;}else
        if (tag==3){subTitle = model.mobile;}
        self.subTitleLabel.text = subTitle;
    }
}

@end
