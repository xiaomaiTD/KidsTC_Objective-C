//
//  RadishSettlementPayTypeCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishSettlementPayTypeCell.h"
#import "RadishSettlementPayTypeItemView.h"
#import "WeChatManager.h"

@interface RadishSettlementPayTypeCell ()<RadishSettlementPayTypeItemViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineOneH;
@property (weak, nonatomic) IBOutlet RadishSettlementPayTypeItemView *aliView;
@property (weak, nonatomic) IBOutlet RadishSettlementPayTypeItemView *weChatView;
@property (nonatomic, weak) RadishSettlementPayTypeItemView *currentView;
@end

@implementation RadishSettlementPayTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineOneH.constant = LINE_H;
    self.aliView.delegate = self;
    self.weChatView.delegate = self;
    self.aliView.tag = PayTypeAli;
    self.weChatView.tag = PayTypeWeChat;
    self.weChatView.nameTipL.hidden = [WeChatManager sharedManager].isOnline;
}

- (void)setData:(RadishSettlementData *)data {
    [super setData:data];
    
    RadishSettlementChannel *payChannel = data.payChannel;
    BOOL aliEnable = payChannel.ali;
    BOOL weChatEnable = payChannel.WeChat && ([WeChatManager sharedManager].isOnline);
    self.aliView.enable = aliEnable;
    self.weChatView.enable = weChatEnable;
    if (aliEnable) {
        [self didClickRadishSettlementPayTypeItemView:self.aliView];
    }else if (weChatEnable) {
        [self didClickRadishSettlementPayTypeItemView:self.weChatView];
    }else{
        [self didClickRadishSettlementPayTypeItemView:nil];
    }
    
}

#pragma mark - RadishSettlementPayTypeItemViewDelegate

- (void)didClickRadishSettlementPayTypeItemView:(RadishSettlementPayTypeItemView *)view {
    [self selectView:view];
    self.data.payType = view.tag;
}

- (void)selectView:(RadishSettlementPayTypeItemView *)view {
    self.currentView.select = NO;
    view.select = YES;
    self.currentView = view;
}

@end
