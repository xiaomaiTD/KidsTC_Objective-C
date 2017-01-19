//
//  WholesaleSettlementDateCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/18.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "WholesaleSettlementDateCell.h"

@interface WholesaleSettlementDateCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineH;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImg;
@end

@implementation WholesaleSettlementDateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.lineH.constant = LINE_H;
}

- (void)setData:(WholesaleSettlementData *)data {
    [super setData:data];
    WholesaleSettlementTime *time = self.data.time;
    self.timeL.text = time.timeDesc;
    self.arrowImg.hidden = !time.isClick;
    self.userInteractionEnabled = time.isClick;
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(wholesaleSettlementBaseCell:actionType:value:)]) {
        [self.delegate wholesaleSettlementBaseCell:self actionType:WholesaleSettlementBaseCellActionTypeSelectDate value:nil];
    }
}
@end
