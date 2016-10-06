//
//  UserCenterContactCell.m
//  KidsTC
//
//  Created by 詹平 on 16/7/27.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "UserCenterContactCell.h"

@interface UserCenterContactCell ()
@property (weak, nonatomic) IBOutlet UIView *consultBGView;
@property (weak, nonatomic) IBOutlet UIView *contactBGView;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;
@end

@implementation UserCenterContactCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.subTitleLabel.textColor = COLOR_PINK;
    self.HLineConstraintHeight.constant = LINE_H;
    
    UITapGestureRecognizer *contactBGViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(contactBGViewAction:)];
    [self.contactBGView addGestureRecognizer:contactBGViewTap];
    UITapGestureRecognizer *consultBGViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(consultBGViewAction:)];
    [self.consultBGView addGestureRecognizer:consultBGViewTap];
}

- (void)setModel:(UserCenterModel *)model{
    [super setModel:model];
}

- (void)consultBGViewAction:(UITapGestureRecognizer *)sender {
    if ([self.delegate respondsToSelector:@selector(userCenterCell:actionType:addIndex:)]) {
        [self.delegate userCenterCell:self actionType:UserCenterCellActionTypeConsult addIndex:0];
    }
}

- (void)contactBGViewAction:(UITapGestureRecognizer *)sender {
    if ([self.delegate respondsToSelector:@selector(userCenterCell:actionType:addIndex:)]) {
        [self.delegate userCenterCell:self actionType:UserCenterCellActionTypeContact addIndex:0];
    }
}


@end
