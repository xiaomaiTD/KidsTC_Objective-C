//
//  UserCenterItemsCell.m
//  KidsTC
//
//  Created by 詹平 on 16/7/27.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "UserCenterItemsCell.h"
#import "UIButton+WebCache.h"
#import "TipButton.h"

#define BTN_TITLE_HEIGHT 13
#define BTN_TITLE_BOTTOM_MARGIN 8
#define BTN_IMAGE_SIZE 40
@interface UserCenterItemsButton : TipButton
@end
@implementation UserCenterItemsButton
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

@interface UserCenterItemsCell ()
@property (weak, nonatomic) IBOutlet UserCenterItemsButton *couponBtn;
@property (weak, nonatomic) IBOutlet UserCenterItemsButton *pointmentBtn;
@property (weak, nonatomic) IBOutlet UserCenterItemsButton *carrotHistoryBtn;
@property (weak, nonatomic) IBOutlet UserCenterItemsButton *inviteBtn;

@end

@implementation UserCenterItemsCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setModel:(UserCenterModel *)model{
    [super setModel:model];
    
    NSArray<NSString *> *icons = model.data.config.icons;
    if (icons.count>=1) {
        NSString *couponImageStr = icons[0];
        if (couponImageStr.length>0) {
            [self.couponBtn sd_setImageWithURL:[NSURL URLWithString:couponImageStr]
                                      forState:UIControlStateNormal
                              placeholderImage:[UIImage imageNamed:@"userCenter_coupon"]];
        }
    }
    if (icons.count>=2) {
        NSString *pointmentImageStr = icons[1];
        if (pointmentImageStr.length>0) {
            [self.pointmentBtn sd_setImageWithURL:[NSURL URLWithString:pointmentImageStr]
                                         forState:UIControlStateNormal
                                 placeholderImage:[UIImage imageNamed:@"userCenter_pointment"]];
        }
    }
    if (icons.count>=3) {
        NSString *carrotHistoryImageStr = icons[2];
        if (carrotHistoryImageStr.length>0) {
            [self.carrotHistoryBtn sd_setImageWithURL:[NSURL URLWithString:carrotHistoryImageStr]
                                             forState:UIControlStateNormal
                                     placeholderImage:[UIImage imageNamed:@"userCenter_carrotHistory"]];
        }
    }
    if (icons.count>=4) {
        NSString *inviteImageStr = icons[3];
        if (inviteImageStr.length>0) {
            [self.inviteBtn sd_setImageWithURL:[NSURL URLWithString:inviteImageStr]
                                      forState:UIControlStateNormal
                              placeholderImage:[UIImage imageNamed:@"userCenter_invite"]];
        }
    }
    
    
}
- (IBAction)couponAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(userCenterCell:actionType:addIndex:)]) {
        [self.delegate userCenterCell:self actionType:UserCenterCellActionTypeCoupon addIndex:0];
    }
}
- (IBAction)pointmentAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(userCenterCell:actionType:addIndex:)]) {
        [self.delegate userCenterCell:self actionType:UserCenterCellActionTypePointment addIndex:0];
    }
}
- (IBAction)carrotHistoryAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(userCenterCell:actionType:addIndex:)]) {
        [self.delegate userCenterCell:self actionType:UserCenterCellActionTypeCarrotHistory addIndex:0];
    }
}
- (IBAction)inviteAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(userCenterCell:actionType:addIndex:)]) {
        [self.delegate userCenterCell:self actionType:UserCenterCellActionTypeInvite addIndex:0];
    }
}

@end
