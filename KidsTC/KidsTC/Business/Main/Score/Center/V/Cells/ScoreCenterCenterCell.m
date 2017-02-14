//
//  ScoreCenterCenterCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/24.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreCenterCenterCell.h"

@interface ScoreCenterCenterCell ()
@property (weak, nonatomic) IBOutlet UILabel *scoreL;
@property (weak, nonatomic) IBOutlet UILabel *tipL;

@end

@implementation ScoreCenterCenterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setUserInfoData:(ScoreUserInfoData *)userInfoData {
    [super setUserInfoData:userInfoData];
    self.scoreL.text = [NSString stringWithFormat:@"%zd",userInfoData.socreNum];
    self.tipL.text = userInfoData.gatherSocreTips;
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(scoreCenterBaseCell:actionType:vlaue:)]) {
        [self.delegate scoreCenterBaseCell:self actionType:ScoreCenterBaseCellActionTypeRule vlaue:nil];
    }
}

@end
