//
//  SharePaidInfoView.m
//  KidsTC
//
//  Created by zhanping on 5/9/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import "SharePaidInfoView.h"

@interface SharePaidInfoView ()
@property (nonatomic, weak) UIButton *closeBtn;
@property (nonatomic, weak) UIButton *shareBtn;
@property (nonatomic, weak) UIImageView *iconImageView;
@property (nonatomic, weak) UIImageView *cloudImageView;

@end

@implementation SharePaidInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        CGFloat btnSize = 20;
        UIButton *closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-btnSize-20, 20, btnSize, btnSize)];
        [self addSubview:closeBtn];
        [closeBtn setImage:[UIImage imageNamed:@"shareClose"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
        self.closeBtn = closeBtn;
        
        CGFloat shareBtn_w = 0.338*SCREEN_WIDTH;
        CGFloat shareBtn_h = 0.1*SCREEN_HEIGHT;
        CGFloat shareBtn_x = (SCREEN_WIDTH-shareBtn_w)*0.5;
        CGFloat shareBtn_y = 0.65*SCREEN_HEIGHT;
        UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(shareBtn_x, shareBtn_y, shareBtn_w, shareBtn_h)];
        [self addSubview:shareBtn];
        [shareBtn setImage:[UIImage imageNamed:@"shareBtn"] forState:UIControlStateNormal];
        [shareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
        self.shareBtn = shareBtn;
        
        CGFloat iconImageView_w = 0.5 * SCREEN_WIDTH;
        CGFloat iconImageView_h = 0.35 *SCREEN_HEIGHT;
        CGFloat iconImageView_x = (SCREEN_WIDTH - iconImageView_w)*0.5;
        CGFloat iconImageView_y = shareBtn_y- iconImageView_h - 30/736.0*SCREEN_HEIGHT;
        UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(iconImageView_x, iconImageView_y, iconImageView_w, iconImageView_h)];
        iconImageView.contentMode = UIViewContentModeScaleAspectFit;
        [iconImageView setImage:[UIImage imageNamed:@"shareImage"]];
        [self addSubview:iconImageView];
        self.iconImageView = iconImageView;
        
        CGFloat cloudImageView_w = iconImageView_w;
        CGFloat cloudImageView_h = cloudImageView_w*0.65;
        CGFloat cloudImageView_x = (SCREEN_WIDTH - cloudImageView_w)*0.5-8;
        CGFloat cloudImageView_y = iconImageView_y - cloudImageView_h + 0.09*SCREEN_HEIGHT;
        UIImageView *cloudImageView = [[UIImageView alloc]initWithFrame:CGRectMake(cloudImageView_x, cloudImageView_y, cloudImageView_w, cloudImageView_h)];
        cloudImageView.contentMode = UIViewContentModeScaleAspectFit;
        [cloudImageView setImage:[UIImage imageNamed:@"shareCloud"]];
        [self addSubview:cloudImageView];
        self.cloudImageView = cloudImageView;
        
        CGFloat tipLabel_w = cloudImageView_w*0.7;
        CGFloat tipLabel_h = cloudImageView_h*0.6;
        UILabel *tipLabel = [[UILabel alloc] init];
        tipLabel.bounds = CGRectMake(0, 0, tipLabel_w, tipLabel_h);
        tipLabel.numberOfLines = 0;
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.font = [UIFont systemFontOfSize:17];
        tipLabel.textColor = [UIColor colorWithRed:0.826  green:0.472  blue:0.665 alpha:1];
        tipLabel.lineBreakMode = NSLineBreakByWordWrapping;
        [self.cloudImageView addSubview:tipLabel];
        tipLabel.center = CGPointMake(cloudImageView_w*0.5, cloudImageView_h*0.5);
        self.tipLabel = tipLabel;
    }
    return self;
}


- (void)closeAction:(UIButton *)sender {
    [self removeFromSuperview];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}
- (void)shareAction:(UIButton *)sender {
    
    if (self.didClickShareBtn) {
        self.didClickShareBtn();
    }
    [self removeFromSuperview];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

@end
