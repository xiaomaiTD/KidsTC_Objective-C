//
//  WolesaleProductDetailJoinCountDownCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WolesaleProductDetailJoinCountDownCell.h"

@interface WolesaleProductDetailJoinCountDownCell ()
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UIView *countDownView;
@property (weak, nonatomic) IBOutlet UIView *dayView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *dayViewW;
@property (weak, nonatomic) IBOutlet UILabel *dayL;
@property (weak, nonatomic) IBOutlet UILabel *hourL;
@property (weak, nonatomic) IBOutlet UILabel *minuteL;
@property (weak, nonatomic) IBOutlet UILabel *secondL;

@end

@implementation WolesaleProductDetailJoinCountDownCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.countDownView.layer.cornerRadius = 4;
    self.countDownView.layer.masksToBounds = YES;
    
    self.dayL.layer.cornerRadius = 2;
    self.dayL.layer.masksToBounds = YES;
    self.hourL.layer.cornerRadius = 2;
    self.hourL.layer.masksToBounds = YES;
    self.minuteL.layer.cornerRadius = 2;
    self.minuteL.layer.masksToBounds = YES;
    self.secondL.layer.cornerRadius = 2;
    self.secondL.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
