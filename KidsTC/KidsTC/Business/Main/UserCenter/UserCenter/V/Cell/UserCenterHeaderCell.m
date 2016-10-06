//
//  UserCenterHeaderCell.m
//  KidsTC
//
//  Created by 詹平 on 16/7/26.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "UserCenterHeaderCell.h"
#import "User.h"
#import "UIImage+Category.h"
#import "UIImageView+Category.h"

#define BTN_TITLE_HEIGHT 15
#define BTN_TITLE_BOTTOM_MARGIN 8
#define BTN_IMAGE_SIZE 30
@interface UserCenterHeaderButton : UIButton
@end
@implementation UserCenterHeaderButton
- (void)awakeFromNib{
    [super awakeFromNib];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageX = (CGRectGetWidth(contentRect)-BTN_IMAGE_SIZE)*0.5;
    CGFloat imageY = (CGRectGetHeight(contentRect)-BTN_TITLE_BOTTOM_MARGIN-BTN_TITLE_HEIGHT-BTN_IMAGE_SIZE)*0.5;
    return CGRectMake(imageX, imageY, BTN_IMAGE_SIZE, BTN_IMAGE_SIZE);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleW = CGRectGetWidth(contentRect);
    CGFloat titleY = CGRectGetHeight(contentRect)-BTN_TITLE_HEIGHT-BTN_TITLE_BOTTOM_MARGIN;
    return CGRectMake(0, titleY, titleW, BTN_TITLE_HEIGHT);
}
@end

@interface UserCenterHeaderCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@property (weak, nonatomic) IBOutlet UIView *userHasLoginBGView;
@property (weak, nonatomic) IBOutlet UIImageView *userLoginHeaderImageView;
@property (weak, nonatomic) IBOutlet UIView *userLoginHeaderImageViewBGView;
@property (weak, nonatomic) IBOutlet UILabel *userInfoLabel;

@property (weak, nonatomic) IBOutlet UIImageView *userUnLoginImageView;

@property (weak, nonatomic) IBOutlet UIView *HLine;

@property (weak, nonatomic) IBOutlet UIView *btnsBGView;
@property (weak, nonatomic) IBOutlet UserCenterHeaderButton *myCollectionBtn;
@property (weak, nonatomic) IBOutlet UserCenterHeaderButton *signupBtn;
@property (weak, nonatomic) IBOutlet UserCenterHeaderButton *browHistoryBtn;
@property (weak, nonatomic) IBOutlet UIView *VLineOne;
@property (weak, nonatomic) IBOutlet UIView *VLineTwo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VLineOneConstraintHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VLineTwoConstraintHeight;

@property (nonatomic, strong) CAGradientLayer *layer1;
@property (nonatomic, strong) CAGradientLayer *layer2;
@end

@implementation UserCenterHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.userLoginHeaderImageView.layer.cornerRadius = 38;
    self.userLoginHeaderImageView.layer.masksToBounds = YES;
    
    self.userLoginHeaderImageViewBGView.layer.cornerRadius =40;
    self.userLoginHeaderImageViewBGView.layer.masksToBounds = YES;
    self.userLoginHeaderImageViewBGView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    
    self.VLineOne.backgroundColor = [UIColor clearColor];
    self.VLineTwo.backgroundColor = [UIColor clearColor];
    self.btnsBGView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    
    self.HLineConstraintHeight.constant = LINE_H;
    self.VLineOneConstraintHeight.constant = LINE_H;
    self.VLineTwoConstraintHeight.constant = LINE_H;
    
    UIColor *middle_color = [UIColor colorWithWhite:1 alpha:0.4];
    UIColor *start_end_color = [UIColor clearColor];
    NSArray *colors = @[(id)start_end_color.CGColor,(id)middle_color.CGColor, (id)start_end_color.CGColor];
    NSArray *locations = @[@(-0.5), @0.5, @1.5];
    
    CAGradientLayer *layer1 = [CAGradientLayer layer];
    layer1.colors = colors;
    layer1.locations = locations;
    layer1.startPoint = CGPointMake(0, 0);
    layer1.endPoint = CGPointMake(0, 1);
    [self.VLineOne.layer addSublayer:layer1];
    self.layer1 = layer1;
    
    CAGradientLayer *layer2 = [CAGradientLayer layer];
    layer2.colors = colors;
    layer2.locations = locations;
    layer2.startPoint = CGPointMake(0, 0);
    layer2.endPoint = CGPointMake(0, 1);
    [self.VLineTwo.layer addSublayer:layer2];
    self.layer2 = layer2;
    
    UITapGestureRecognizer *userHasLoginBGViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userHasLoginAction:)];
    [self.userHasLoginBGView addGestureRecognizer:userHasLoginBGViewTap];
    
    UITapGestureRecognizer *userUnLoginImageViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userUnLoginAction:)];
    [self.userUnLoginImageView addGestureRecognizer:userUnLoginImageViewTap];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.VLineOne layoutIfNeeded];
    [self.VLineTwo layoutIfNeeded];
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    self.layer1.frame = self.VLineOne.bounds;
    self.layer2.frame = self.VLineOne.bounds;
    [CATransaction commit];
}

- (void)userUnLoginAction:(UITapGestureRecognizer *)sender {
    if ([self.delegate respondsToSelector:@selector(userCenterCell:actionType:addIndex:)]) {
        [self.delegate userCenterCell:self actionType:UserCenterCellActionTypeUnLogin addIndex:0];
    }
}
- (void)userHasLoginAction:(UITapGestureRecognizer *)sender {
    if ([self.delegate respondsToSelector:@selector(userCenterCell:actionType:addIndex:)]) {
        [self.delegate userCenterCell:self actionType:UserCenterCellActionTypeHasLogin addIndex:0];
    }
}
- (IBAction)myCollectionAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(userCenterCell:actionType:addIndex:)]) {
        [self.delegate userCenterCell:self actionType:UserCenterCellActionTypeMyCollection addIndex:0];
    }
}
- (IBAction)signupAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(userCenterCell:actionType:addIndex:)]) {
        [self.delegate userCenterCell:self actionType:UserCenterCellActionTypeSignup addIndex:0];
    }
}
- (IBAction)browHistoryAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(userCenterCell:actionType:addIndex:)]) {
        [self.delegate userCenterCell:self actionType:UserCenterCellActionTypeBrowHistory addIndex:0];
    }
}

- (void)setModel:(UserCenterModel *)model{
    [super setModel:model];
    UserCenterUserInfo *userInfo = model.data.userInfo;
    self.userHasLoginBGView.hidden = !userInfo;
    self.userUnLoginImageView.hidden = !self.userHasLoginBGView.hidden;
    if (userInfo) {
        RoleSex sex = [User shareUser].role.sex;
        NSString *palceHolder = (sex==RoleSexFemale)?@"userCenter_header_girl":@"userCenter_header_boy";
        [self.userLoginHeaderImageView sd_setImageWithURL:[NSURL URLWithString:userInfo.headUrl] placeholderImage:[UIImage imageNamed:palceHolder]];
        self.userInfoLabel.attributedText = self.userInfoAttStr;
    }
}

- (NSAttributedString *)userInfoAttStr{
    
    UserCenterUserInfo *userInfo = self.model.data.userInfo;
    
    NSDictionary *statusAtt = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                                NSForegroundColorAttributeName:[UIColor whiteColor]};
    //1.status
    NSString *status = [NSString stringWithFormat:@"状态:%@期\n",[User shareUser].role.statusName];
    NSAttributedString *statusAttStr = [[NSAttributedString alloc]initWithString:status attributes:statusAtt];
    //2.level
    NSString *level = [NSString stringWithFormat:@"等级:%@\n",userInfo.levelName];
    NSAttributedString *levelAttStr = [[NSAttributedString alloc]initWithString:level attributes:statusAtt];
    
    
    //3.num
    UserCenterUserCount *userCount = self.model.data.userCount;
    UIFont *numFont = [UIFont systemFontOfSize:11];
    NSDictionary *numAtt = @{NSFontAttributeName:numFont,
                             NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    NSTextAttachment *scoreAttachment =[[NSTextAttachment alloc]init];
    scoreAttachment.image = [UIImage imageNamed:@"userCenter_score"];
    scoreAttachment.bounds = CGRectMake(0, -2, numFont.lineHeight-2, numFont.lineHeight-2);
    NSAttributedString *scoreAttachmentStr = [NSAttributedString attributedStringWithAttachment:scoreAttachment];
    
    NSString *score = [NSString stringWithFormat:@"积分:%zd ",userCount.score_num];
    NSAttributedString *scoreAttStr = [[NSAttributedString alloc]initWithString:score];
    
    NSTextAttachment *carrotAttachment =[[NSTextAttachment alloc]init];
    carrotAttachment.image = [UIImage imageNamed:@"userCenter_carrot"];
    carrotAttachment.bounds = CGRectMake(0, -2, numFont.lineHeight-2, numFont.lineHeight-2);
    NSAttributedString *carrotAttachmentStr = [NSAttributedString attributedStringWithAttachment:carrotAttachment];
    
    NSString *carrot = [NSString stringWithFormat:@"萝卜:%zd",userCount.userRadishNum];
    NSAttributedString *carrotAttStr = [[NSAttributedString alloc]initWithString:carrot];
    
    NSMutableAttributedString *numAttStr = [[NSMutableAttributedString alloc]init];
    [numAttStr appendAttributedString:scoreAttachmentStr];
    [numAttStr appendAttributedString:scoreAttStr];
    [numAttStr appendAttributedString:carrotAttachmentStr];
    [numAttStr appendAttributedString:carrotAttStr];
    [numAttStr addAttributes:numAtt range:NSMakeRange(0, numAttStr.length)];
    
    NSMutableAttributedString *userInfoStr = [[NSMutableAttributedString alloc]init];
    [userInfoStr appendAttributedString:statusAttStr];
    [userInfoStr appendAttributedString:levelAttStr];
    [userInfoStr appendAttributedString:numAttStr];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = 6;
    [userInfoStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, userInfoStr.length)];
    
    return userInfoStr;
}

@end
