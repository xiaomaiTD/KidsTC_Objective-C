//
//  RadishSettlementBuyNumTfInputView.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishSettlementBuyNumTfInputView.h"

@interface RadishSettlementBuyNumTfInputView ()
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation RadishSettlementBuyNumTfInputView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.cancelBtn.tag = RadishSettlementBuyNumTfInputViewActionTypeCancel;
    self.sureBtn.tag = RadishSettlementBuyNumTfInputViewActionTypeSure;
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(radishSettlementBuyNumTfInputView:actionType:value:)]) {
        [self.delegate radishSettlementBuyNumTfInputView:self actionType:sender.tag value:nil];
    }
}

@end
