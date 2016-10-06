//
//  UserCenterOrderCell.m
//  KidsTC
//
//  Created by 詹平 on 16/7/26.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "UserCenterOrderCell.h"
#import "TipButton.h"
#define BTN_TITLE_HEIGHT 13
#define BTN_TITLE_BOTTOM_MARGIN 8
#define BTN_IMAGE_SIZE 24
@interface UserCenterOrderButton : TipButton
@end
@implementation UserCenterOrderButton
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

@interface UserCenterOrderCell ()
@property (weak, nonatomic) IBOutlet UIView *allOrderBGView;
@property (weak, nonatomic) IBOutlet UIView *HLine;
@property (weak, nonatomic) IBOutlet UIView *OrdersBGView;
@property (weak, nonatomic) IBOutlet UserCenterOrderButton *waitPayBtn;
@property (weak, nonatomic) IBOutlet UserCenterOrderButton *waitUseBtn;
@property (weak, nonatomic) IBOutlet UserCenterOrderButton *myCommentBtn;
@property (weak, nonatomic) IBOutlet UserCenterOrderButton *refundBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;

@end

@implementation UserCenterOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineConstraintHeight.constant = LINE_H;
    UITapGestureRecognizer *allOrderBGViewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(allOrderBGViewAction:)];
    [self.allOrderBGView addGestureRecognizer:allOrderBGViewTap];
}

- (void)setModel:(UserCenterModel *)model{
    [super setModel:model];
    UserCenterUserCount *userCount = model.data.userCount;
    self.waitPayBtn.badgeValue = userCount.order_wait_pay;
    self.waitUseBtn.badgeValue = userCount.order_wait_use;
    self.myCommentBtn.badgeValue = userCount.order_wait_evaluate;
}

- (void)allOrderBGViewAction:(UITapGestureRecognizer *)sender {
    if ([self.delegate respondsToSelector:@selector(userCenterCell:actionType:addIndex:)]) {
        [self.delegate userCenterCell:self actionType:UserCenterCellActionTypeAllOrder addIndex:0];
    }
}
- (IBAction)waitPayAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(userCenterCell:actionType:addIndex:)]) {
        [self.delegate userCenterCell:self actionType:UserCenterCellActionTypeWaitPay addIndex:0];
    }
}
- (IBAction)waitUseAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(userCenterCell:actionType:addIndex:)]) {
        [self.delegate userCenterCell:self actionType:UserCenterCellActionTypeWaitUse addIndex:0];
    }
}
- (IBAction)myCommentAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(userCenterCell:actionType:addIndex:)]) {
        [self.delegate userCenterCell:self actionType:UserCenterCellActionTypeMyComment addIndex:0];
    }
}
- (IBAction)refundAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(userCenterCell:actionType:addIndex:)]) {
        [self.delegate userCenterCell:self actionType:UserCenterCellActionTypeRefund addIndex:0];
    }
}

@end
