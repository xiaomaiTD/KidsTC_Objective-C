//
//  FlashAdvanceSettlementPayTypeCell.m
//  KidsTC
//
//  Created by zhanping on 8/16/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "FlashAdvanceSettlementPayTypeCell.h"
#import "PayModel.h"
#import "WeChatManager.h"

@interface FlashAdvanceSettlementPayTypeCell ()
@property (weak, nonatomic) IBOutlet UILabel *choosePayTypeTipLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HOneLineConstraintHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HTwoLineConstraintHeight;
@property (weak, nonatomic) IBOutlet UIView *aliBGView;
@property (weak, nonatomic) IBOutlet UIView *weChatBGView;
@property (weak, nonatomic) IBOutlet UIButton *aliBtn;
@property (weak, nonatomic) IBOutlet UIButton *weChatBtn;
@property (weak, nonatomic) IBOutlet UILabel *weChatTipLabel;
@end

@implementation FlashAdvanceSettlementPayTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HOneLineConstraintHeight.constant = LINE_H;
    self.HTwoLineConstraintHeight.constant = LINE_H;
    
    UITapGestureRecognizer *aliTapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(payTypeAction:)];
    [self.aliBGView addGestureRecognizer:aliTapGR];
    self.aliBGView.tag = PayTypeAli;
    
    UITapGestureRecognizer *weChatTapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(payTypeAction:)];
    [self.weChatBGView addGestureRecognizer:weChatTapGR];
    self.weChatBGView.tag = PayTypeWeChat;
}

- (void)setData:(FlashSettlementData *)data{
    [super setData:data];
    
    FlashSettlementPayChannel *payChannel = data.payChannel;
    
    BOOL aliEnable = payChannel && payChannel.ali && data.price>0;
    BOOL weChatEnable = payChannel && payChannel.WeChat && data.price>0 && [WeChatManager sharedManager].isOnline;
    self.weChatTipLabel.text = [WeChatManager sharedManager].isOnline?@"":@"（未安装）";
    
    self.aliBGView.userInteractionEnabled = aliEnable;
    self.weChatBGView.userInteractionEnabled = weChatEnable;
    
    self.aliBtn.enabled = aliEnable;
    self.weChatBtn.enabled = weChatEnable;
    
    self.aliBGView.alpha = aliEnable?1:0.3;
    self.weChatBGView.alpha = weChatEnable?1:0.3;
    
    if (aliEnable) {
        [self payTypeAction:self.aliBGView.gestureRecognizers.firstObject];
    }else{
        [self payTypeAction:self.weChatBGView.gestureRecognizers.firstObject];
    }
}

- (void)payTypeAction:(UITapGestureRecognizer *)tapGR {
    PayType payType = tapGR.view.tag;
    self.aliBtn.selected = payType==PayTypeAli;
    self.weChatBtn.selected = payType==PayTypeWeChat;
    if ([self.delegate respondsToSelector:@selector(flashAdvanceSettlementBaseCell:actionType:value:)]) {
        [self.delegate flashAdvanceSettlementBaseCell:self actionType:FlashAdvanceSettlementBaseCellActionTypePayType value:@(payType)];
    }
}

@end
