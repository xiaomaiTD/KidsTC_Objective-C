//
//  WholesaleOrderDetailLeaderCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleOrderDetailLeaderCell.h"
#import "UIButton+Category.h"
#import "UIImageView+WebCache.h"

@interface WholesaleOrderDetailLeaderCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation WholesaleOrderDetailLeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    self.icon.layer.cornerRadius = CGRectGetHeight(self.icon.frame) * 0.5;
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.borderWidth = LINE_H;
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    
    self.btn.layer.cornerRadius = 2;
    self.btn.layer.masksToBounds = YES;
    
    [self.btn setBackgroundColor:[UIColor colorFromHexString:@"F36863"] forState:UIControlStateNormal];
    [self.btn setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
}

- (void)setData:(WholesaleOrderDetailData *)data {
    [super setData:data];
    
    WholesaleOrderDetailUser *user = data.openGroupUser;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:user.userImg] placeholderImage:PLACEHOLDERIMAGE_SMALL_LOG];
    self.nameL.text = [NSString stringWithFormat:@"团长：%@",user.userName];
    
    NSString *rightBtnTitle = nil;
    BOOL btnEnable = NO;
    if (!data.countDown || !data.countDown.showCountDown || data.countDown.countDownOver)
    {
        rightBtnTitle = @"更多拼团";//跳到第一个商品详情页面
        btnEnable = YES;
    }else{
        switch (data.btnStatus) {
            case FightGroupBtnStatusShare:
            {
                rightBtnTitle = @"邀请好友参团";//分享
                btnEnable = YES;
            }
                break;
            case FightGroupBtnStatusBuy:
            {
                rightBtnTitle = @"我要参团";//去支付
                btnEnable = YES;
            }
                break;
            case FightGroupBtnStatusMySale://用户自己的拼团信息
            {
                rightBtnTitle = @"我的拼团";
                btnEnable = YES;
            }
                break;
            case FightGroupBtnStatusFull://置为灰色不可点击
            {
                rightBtnTitle = @"人数已满";
                btnEnable = NO;
            }
                break;
            case FightGroupBtnStatusProductHome:
            {
                rightBtnTitle = @"更多拼团";//跳到第一个商品详情页面
                btnEnable = YES;
            }
                break;
            default:
                break;
        }
    }
    [self.btn setTitle:rightBtnTitle forState:UIControlStateNormal];
    self.btn.enabled = btnEnable;
}

- (IBAction)action:(UIButton *)sender {
    
}

@end
