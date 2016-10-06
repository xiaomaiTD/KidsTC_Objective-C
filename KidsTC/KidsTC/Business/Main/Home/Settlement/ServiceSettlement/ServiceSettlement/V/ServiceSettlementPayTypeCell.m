//
//  ServiceSettlementPayTypeCell.m
//  KidsTC
//
//  Created by zhanping on 8/11/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ServiceSettlementPayTypeCell.h"
#import "PayModel.h"
#import "WeChatManager.h"

@interface ServiceSettlementPayTypeCell ()
@property (weak, nonatomic) IBOutlet UILabel *choosePayTypeTipLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HOneLineConstraintHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HTwoLineConstraintHeight;
@property (weak, nonatomic) IBOutlet UIView *aliBGView;
@property (weak, nonatomic) IBOutlet UIView *weChatBGView;
@property (weak, nonatomic) IBOutlet UIButton *aliBtn;
@property (weak, nonatomic) IBOutlet UIButton *weChatBtn;
@property (weak, nonatomic) IBOutlet UILabel *weChatTipLabel;

@end


@implementation ServiceSettlementPayTypeCell

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

- (void)setItem:(ServiceSettlementDataItem *)item{
    [super setItem:item];
    ServiceSettlementPayType *pay_type = item.pay_type;
    
    BOOL aliEnable = pay_type && pay_type.ali && item.totalPrice>0;
    BOOL weChatEnable = pay_type && pay_type.WeChat && item.totalPrice>0 && [WeChatManager sharedManager].isOnline;
    
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
    if ([self.delegate respondsToSelector:@selector(serviceSettlementBaseCell:actionType:value:)]) {
        [self.delegate serviceSettlementBaseCell:self actionType:ServiceSettlementBaseCellActionTypeChangePayType value:@(payType)];
    }
}

@end
