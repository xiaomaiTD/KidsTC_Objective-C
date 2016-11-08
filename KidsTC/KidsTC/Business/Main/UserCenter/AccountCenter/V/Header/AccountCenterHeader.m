//
//  AccountCenterHeader.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "AccountCenterHeader.h"

@interface AccountCenterHeader ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UIButton *settingBtn;
@property (weak, nonatomic) IBOutlet UIButton *messageBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UIView *headBgView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgRatio;
@end

@implementation AccountCenterHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    
    self.headBgView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
    self.headImageView.backgroundColor = [UIColor whiteColor];
    
    [self setupLayer:self.headBgView.layer];
    [self setupLayer:self.headImageView.layer];
}

- (void)setupLayer:(CALayer *)layer {
    layer.cornerRadius = CGRectGetWidth(layer.frame) * 0.5;
    layer.masksToBounds = YES;
    //layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    //layer.borderWidth = LINE_H;
}

- (void)setModel:(AccountCenterModel *)model {
    _model = model;
}

@end
