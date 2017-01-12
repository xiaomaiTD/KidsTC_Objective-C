//
//  RadishMallPlantCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/9.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishMallPlantCell.h"
#import "UIImageView+WebCache.h"

@interface RadishMallPlantCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;
@property (weak, nonatomic) IBOutlet UILabel *radishCountL;
@property (weak, nonatomic) IBOutlet UIButton *plantBtn;
@property (weak, nonatomic) IBOutlet UIButton *ruleBtn;
@property (weak, nonatomic) IBOutlet UILabel *peopleL;
@property (weak, nonatomic) IBOutlet UILabel *plantCountL;
@end

@implementation RadishMallPlantCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.plantBtn.tag = RadishMallBaseCellActionTypePlant;
    self.ruleBtn.tag = RadishMallBaseCellActionTypeRule;
}
- (void)setData:(RadishMallData *)data {
    [super setData:data];
    RadishUserData *userData = data.userData;
    NSString *plantBtnTitle = userData.isCheckIn?@"Radish_hasPlant":@"Radish_startPlant";
    [self.plantBtn setImage:[UIImage imageNamed:plantBtnTitle] forState:UIControlStateNormal];
    self.radishCountL.text = [NSString stringWithFormat:@"%zd",userData.radishCount];
    self.plantCountL.text = [NSString stringWithFormat:@"%zd",userData.checkInDays];
    self.peopleL.text = userData.radishGrade;
    [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:data.backUrl] placeholderImage:[UIImage imageNamed:@"Radish_mallBG_sun"]];
}

- (IBAction)plant:(UIButton *)sender {
    if (!self.data.userData.isCheckIn) {
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

@end
