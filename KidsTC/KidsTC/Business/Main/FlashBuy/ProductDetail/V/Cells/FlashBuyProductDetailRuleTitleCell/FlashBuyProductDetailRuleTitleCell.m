//
//  FlashBuyProductDetailRuleTitleCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/22.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "FlashBuyProductDetailRuleTitleCell.h"
#import "NSString+Category.h"

@interface FlashBuyProductDetailRuleTitleCell ()
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UILabel *ruleTipL;
@property (weak, nonatomic) IBOutlet UIImageView *ruleArrow;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;

@end

@implementation FlashBuyProductDetailRuleTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}

- (void)setData:(FlashBuyProductDetailData *)data {
    [super setData:data];
    if ([data.flowLinkUrl isNotNull]) {
        self.ruleTipL.hidden = NO;
        self.ruleArrow.hidden = NO;
        self.btn.enabled = YES;
    }else{
        self.ruleTipL.hidden = YES;
        self.ruleArrow.hidden = YES;
        self.btn.enabled = NO;
    }
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(flashBuyProductDetailBaseCell:actionType:vlaue:)]) {
        [self.delegate flashBuyProductDetailBaseCell:self actionType:FlashBuyProductDetailBaseCellActionTypeRule vlaue:nil];
    }
}


@end
