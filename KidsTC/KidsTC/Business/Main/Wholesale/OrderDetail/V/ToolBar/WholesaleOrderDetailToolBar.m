//
//  WholesaleOrderDetailToolBar.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleOrderDetailToolBar.h"
#import "UIButton+Category.h"
#import "NSString+Category.h"

CGFloat const kWholesaleOrderDetailToolBarH = 49;

@interface WholesaleOrderDetailToolBar ()
@property (weak, nonatomic) IBOutlet UIView *consultBGView;
@property (weak, nonatomic) IBOutlet UIButton *consultBtn;
@property (weak, nonatomic) IBOutlet UIImageView *consultIcon;
@property (weak, nonatomic) IBOutlet UILabel *consultTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *consultLineH;

@property (weak, nonatomic) IBOutlet UIView *leftBGView;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIImageView *leftIcon;
@property (weak, nonatomic) IBOutlet UILabel *leftTitle;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftLineH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *VLeftLineH;

@property (weak, nonatomic) IBOutlet UIView *rightBGView;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightBGViewLeading;

@end

@implementation WholesaleOrderDetailToolBar

- (void)awakeFromNib {
    [super awakeFromNib];
    self.consultLineH.constant = LINE_H;
    self.leftLineH.constant = LINE_H;
    self.VLeftLineH.constant = LINE_H;
    [self.rightBtn setBackgroundColor:[UIColor colorFromHexString:@"F36863"] forState:UIControlStateNormal];
    [self.rightBtn setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
    self.consultBtn.tag = WholesaleOrderDetailToolBarActionTypeConsult;
    self.leftBtn.tag = WholesaleOrderDetailToolBarActionTypeShare;
    [self layoutIfNeeded];
    
}

- (void)setData:(WholesaleOrderDetailData *)data {
    _data = data;
    
    self.hidden = data.fightGroupBase == nil;
    
    /*
     FightGroupBtnStatusShare = 1,//邀请好友参团
     FightGroupBtnStatusBuy = 2,//我要参团
     FightGroupBtnStatusMySale = 3,//我的拼团
     FightGroupBtnStatusFull = 4,//人数已满
     FightGroupBtnStatusHome = 5,//更多拼团
     */
    NSString *rightBtnTitle = nil;
    BOOL btnEnable = NO;
    WholesaleOrderDetailToolBarActionType rightTag;
    CGFloat rightBGViewLeading = SCREEN_WIDTH*0.33;
    if (!data.countDown || !data.countDown.showCountDown || data.countDown.countDownOver)
    {
        rightBtnTitle = @"更多组团";//跳到第一个商品详情页面
        btnEnable = YES;
        rightTag = WholesaleOrderDetailToolBarActionTypeProductHome;
    }else{
        switch (data.btnStatus) {
            case FightGroupBtnStatusShare:
            {
                rightBtnTitle = @"邀请好友参团";//分享
                btnEnable = YES;
                rightTag = WholesaleOrderDetailToolBarActionTypeShare;
                rightBGViewLeading = 0;
            }
                break;
            case FightGroupBtnStatusBuy:
            {
                rightBtnTitle = @"我要参团";//去支付
                btnEnable = YES;
                rightTag = WholesaleOrderDetailToolBarActionTypeBuy;
            }
                break;
            case FightGroupBtnStatusMySale://用户自己的拼团信息
            {
                rightBtnTitle = @"我的拼团";
                btnEnable = YES;
                rightTag = WholesaleOrderDetailToolBarActionTypeMySale;
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
                rightBtnTitle = @"更多组团";//跳到第一个商品详情页面
                btnEnable = YES;
                rightTag = WholesaleOrderDetailToolBarActionTypeProductHome;
            }
                break;
            default:
                break;
        }
    }
    [self.rightBtn setTitle:rightBtnTitle forState:UIControlStateNormal];
    self.rightBtn.enabled = btnEnable;
    self.rightBtn.tag = rightTag;
    self.rightBGViewLeading.constant = rightBGViewLeading;
    [self layoutIfNeeded];
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(wholesaleOrderDetailToolBar:actionType:value:)]) {
        [self.delegate wholesaleOrderDetailToolBar:self actionType:sender.tag value:nil];
    }
}
@end
