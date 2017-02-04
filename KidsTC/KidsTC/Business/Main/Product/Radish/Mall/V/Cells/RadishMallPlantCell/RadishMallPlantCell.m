//
//  RadishMallPlantCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/9.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishMallPlantCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+Category.h"
#import "User.h"

@interface RadishMallPlantCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;
@property (weak, nonatomic) IBOutlet UILabel *radishCountL;
@property (weak, nonatomic) IBOutlet UIButton *plantBtn;
@property (weak, nonatomic) IBOutlet UIButton *ruleBtn;
@property (weak, nonatomic) IBOutlet UIView *gradeBGView;
@property (weak, nonatomic) IBOutlet UIImageView *gradeIcon;
@property (weak, nonatomic) IBOutlet UIButton *gradeBtn;
@property (weak, nonatomic) IBOutlet UIView *plantCountBGView;
@property (weak, nonatomic) IBOutlet UILabel *plantCountL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *plantBtnTop;

@end

@implementation RadishMallPlantCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.plantBtn.tag = RadishMallBaseCellActionTypePlant;
    self.ruleBtn.tag = RadishMallBaseCellActionTypeRule;
    self.gradeBtn.tag = RadishMallBaseCellActionTypeGrade;
}
- (void)setData:(RadishMallData *)data {
    [super setData:data];
    RadishUserData *userData = data.userData;
    NSString *plantBtnImg = nil;
    NSString *radishCountL = nil;
    if ([User shareUser].hasLogin) {
        plantBtnImg = userData.isCheckIn?@"Radish_hasPlant":@"Radish_startPlant";
        radishCountL = [NSString stringWithFormat:@"%zd根",userData.radishCount];
        self.plantCountL.text = [NSString stringWithFormat:@"%zd",userData.checkInDays];
        [self.gradeIcon sd_setImageWithURL:[NSURL URLWithString:userData.radishGrade] placeholderImage:[UIImage imageNamed:@"Radish_score"]];
        self.gradeBGView.hidden = ![userData.radishGrade isNotNull];
        self.plantCountBGView.hidden = NO;
        self.plantBtnTop.constant = 15;
    }else{
        plantBtnImg = @"Radish_noLogin";
        radishCountL = @"??根";
        self.plantCountBGView.hidden = YES;
        self.gradeBGView.hidden = YES;
        self.plantBtnTop.constant = 35;
    }
    [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:data.backUrl] placeholderImage:[UIImage imageNamed:@"Radish_mallBG_sun"]];
    self.radishCountL.text = radishCountL;
    [self.plantBtn setImage:[UIImage imageNamed:plantBtnImg] forState:UIControlStateNormal];
    [self layoutIfNeeded];
}

- (IBAction)plant:(UIButton *)sender {
    if (!self.data.userData.isCheckIn || ![User shareUser].hasLogin) {
        if ([self.delegate respondsToSelector:@selector(radishMallBaseCell:actionType:value:)]) {
            [self.delegate radishMallBaseCell:self actionType:RadishMallBaseCellActionTypePlant value:self.data];
        }
    }
}

- (IBAction)rule:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(radishMallBaseCell:actionType:value:)]) {
        [self.delegate radishMallBaseCell:self actionType:RadishMallBaseCellActionTypeRule value:self.data];
    }
}

- (IBAction)grade:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(radishMallBaseCell:actionType:value:)]) {
        [self.delegate radishMallBaseCell:self actionType:RadishMallBaseCellActionTypeGrade value:self.data];
    }
}
@end
