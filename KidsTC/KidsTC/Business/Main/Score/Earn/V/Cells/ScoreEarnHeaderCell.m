//
//  ScoreEarnHeaderCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ScoreEarnHeaderCell.h"
#import "UIImageView+WebCache.h"

@interface ScoreEarnHeaderCell ()
@property (weak, nonatomic) IBOutlet UIView *headerImgBGView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImg;
@property (weak, nonatomic) IBOutlet UILabel *scoreL;
@property (weak, nonatomic) IBOutlet UILabel *userNameL;

@end

@implementation ScoreEarnHeaderCell

- (void)layoutSubviews {
    [super layoutSubviews];
    self.headerImgBGView.layer.cornerRadius = CGRectGetHeight(self.headerImgBGView.frame)*0.5;
    self.headerImgBGView.layer.masksToBounds = YES;
    
    self.headerImg.layer.cornerRadius = CGRectGetHeight(self.headerImg.frame)*0.5;
    self.headerImg.layer.masksToBounds = YES;
}

- (void)setItem:(ScoreEarnShowItem *)item {
    [super setItem:item];
    
    [self.headerImg sd_setImageWithURL:[NSURL URLWithString:self.userInfoData.headImg] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    self.scoreL.text = [NSString stringWithFormat:@"%@",@(self.userInfoData.socreNum)];
    self.userNameL.text = self.userInfoData.nickName;
}



@end
