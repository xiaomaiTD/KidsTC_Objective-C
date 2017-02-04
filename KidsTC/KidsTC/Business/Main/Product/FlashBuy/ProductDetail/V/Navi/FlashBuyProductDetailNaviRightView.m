//
//  FlashBuyProductDetailNaviRightView.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/23.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "FlashBuyProductDetailNaviRightView.h"

@interface FlashBuyProductDetailNaviRightView ()
@property (weak, nonatomic) IBOutlet UIButton *contactBtn;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

@end

@implementation FlashBuyProductDetailNaviRightView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contactBtn.tag = FlashBuyProductDetailNaviRightViewActionTyepContact;
    self.moreBtn.tag = FlashBuyProductDetailNaviRightViewActionTyepMore;
}
- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(flashBuyProductDetailNaviRightView:actionType:value:)]) {
        [self.delegate flashBuyProductDetailNaviRightView:self actionType:sender.tag value:nil];
    }
}

@end
