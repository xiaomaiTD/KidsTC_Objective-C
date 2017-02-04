//
//  WholesaleSettlementPayTypeCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WholesaleSettlementPayTypeCell.h"
#import "WholesaleSettlementPayTypeItemView.h"
#import "WeChatManager.h"

@interface WholesaleSettlementPayTypeCell ()<WholesaleSettlementPayTypeItemViewDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineOneH;
@property (weak, nonatomic) IBOutlet WholesaleSettlementPayTypeItemView *aliView;
@property (weak, nonatomic) IBOutlet WholesaleSettlementPayTypeItemView *weChatView;
@property (nonatomic, weak) WholesaleSettlementPayTypeItemView *currentView;
@end

@implementation WholesaleSettlementPayTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineOneH.constant = LINE_H;
    self.aliView.delegate = self;
    self.weChatView.delegate = self;
    self.aliView.tag = PayTypeAli;
    self.weChatView.tag = PayTypeWeChat;
    self.weChatView.nameTipL.hidden = [WeChatManager sharedManager].isOnline;
}

- (void)setData:(WholesaleSettlementData *)data {
    [super setData:data];
    WholesaleSettlementPayChannel *payChannel = data.appPayChannel;
    BOOL aliEnable = payChannel.ali;
    BOOL weChatEnable = payChannel.WeChat && ([WeChatManager sharedManager].isOnline);
    self.aliView.enable = aliEnable;
    self.weChatView.enable = weChatEnable;
    if (aliEnable) {
        [self didClickWholesaleSettlementPayTypeItemView:self.aliView];
    }else if (weChatEnable) {
        [self didClickWholesaleSettlementPayTypeItemView:self.weChatView];
    }else{
        [self didClickWholesaleSettlementPayTypeItemView:nil];
    }
}

#pragma mark - WholesaleSettlementPayTypeItemViewDelegate

- (void)didClickWholesaleSettlementPayTypeItemView:(WholesaleSettlementPayTypeItemView *)view {
    [self selectView:view];
    self.data.payType = view.tag;
}

- (void)selectView:(WholesaleSettlementPayTypeItemView *)view {
    self.currentView.select = NO;
    view.select = YES;
    self.currentView = view;
}

@end
