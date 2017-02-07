//
//  NormalProductDetailNaviView.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/6.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "NormalProductDetailNaviView.h"

CGFloat const kNormalProductDetailNaviViewH = 64;

@interface NormalProductDetailNaviView ()
@property (weak, nonatomic) IBOutlet UIView *backBGView;
@property (weak, nonatomic) IBOutlet UIView *rightBGView;

@property (weak, nonatomic) IBOutlet UILabel *nameL;

@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

@property (weak, nonatomic) IBOutlet UIImageView *backImg;
@property (weak, nonatomic) IBOutlet UIImageView *timeImg;
@property (weak, nonatomic) IBOutlet UIImageView *moreImg;

@end

@implementation NormalProductDetailNaviView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    
    self.backBGView.layer.cornerRadius = CGRectGetHeight(self.backBGView.bounds) * 0.5;
    self.backBGView.layer.masksToBounds = YES;
    
    self.rightBGView.layer.cornerRadius = CGRectGetHeight(self.rightBGView.bounds) * 0.5;
    self.rightBGView.layer.masksToBounds = YES;
}


- (IBAction)action:(UIButton *)sender {
    
}

@end
