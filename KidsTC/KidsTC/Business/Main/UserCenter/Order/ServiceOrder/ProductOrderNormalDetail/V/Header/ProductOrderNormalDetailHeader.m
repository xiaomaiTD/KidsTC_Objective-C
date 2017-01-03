//
//  ProductOrderNormalDetailHeader.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductOrderNormalDetailHeader.h"

@interface ProductOrderNormalDetailHeader ()
@property (weak, nonatomic) IBOutlet UIButton *showRuleBtn;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

@end

@implementation ProductOrderNormalDetailHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    self.showRuleBtn.tag = ProductOrderNormalDetailHeaderActionTypeShowRule;
    self.closeBtn.tag = ProductOrderNormalDetailHeaderActionTypeClose;
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(productOrderNormalDetailHeader:actionType:)]) {
        [self.delegate productOrderNormalDetailHeader:self actionType:(ProductOrderNormalDetailHeaderActionType)sender.tag];
    }
}

@end
