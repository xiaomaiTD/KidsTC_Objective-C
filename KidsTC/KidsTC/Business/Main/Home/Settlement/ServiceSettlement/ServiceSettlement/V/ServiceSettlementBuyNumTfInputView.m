//
//  ServiceSettlementBuyNumTfInputView.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/29.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ServiceSettlementBuyNumTfInputView.h"

@interface ServiceSettlementBuyNumTfInputView ()
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@end

@implementation ServiceSettlementBuyNumTfInputView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.cancelBtn.tag = ServiceSettlementBuyNumTfInputViewActionTypeCancel;
    self.sureBtn.tag = ServiceSettlementBuyNumTfInputViewActionTypeSure;
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(serviceSettlementBuyNumTfInputView:actionType:value:)]) {
        [self.delegate serviceSettlementBuyNumTfInputView:self actionType:sender.tag value:nil];
    }
}

@end
