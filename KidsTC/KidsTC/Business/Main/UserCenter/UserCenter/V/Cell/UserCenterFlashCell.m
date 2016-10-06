//
//  UserCenterFlashCell.m
//  KidsTC
//
//  Created by 詹平 on 16/7/27.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "UserCenterFlashCell.h"

@interface UserCenterFlashCell ()
@property (weak, nonatomic) IBOutlet UIView *flashByBGView;
@property (weak, nonatomic) IBOutlet UIView *headLineBGView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;

@end

@implementation UserCenterFlashCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineConstraintHeight.constant = LINE_H;
    
    UITapGestureRecognizer *flashByBGViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(flashByBGViewAction:)];
    [self.flashByBGView addGestureRecognizer:flashByBGViewTap];
    
    UITapGestureRecognizer *headLineBGViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headLineBGViewAction:)];
    [self.headLineBGView addGestureRecognizer:headLineBGViewTap];
}

- (void)setModel:(UserCenterModel *)model{
    [super setModel:model];
}

- (void)flashByBGViewAction:(UITapGestureRecognizer *)sender {
    if ([self.delegate respondsToSelector:@selector(userCenterCell:actionType:addIndex:)]) {
        [self.delegate userCenterCell:self actionType:UserCenterCellActionTypeFlashBy addIndex:0];
    }
}
- (void)headLineBGViewAction:(UITapGestureRecognizer *)sender {
    if ([self.delegate respondsToSelector:@selector(userCenterCell:actionType:addIndex:)]) {
        [self.delegate userCenterCell:self actionType:UserCenterCellActionTypeHeadLine addIndex:0];
    }
}


@end
