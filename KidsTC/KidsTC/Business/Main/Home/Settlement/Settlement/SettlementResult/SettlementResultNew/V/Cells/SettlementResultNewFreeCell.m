//
//  SettlementResultNewFreeCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/21.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SettlementResultNewFreeCell.h"
#import "NSString+Category.h"

@interface SettlementResultNewFreeCell ()
@property (weak, nonatomic) IBOutlet UIButton *goHomeBtn;
@property (weak, nonatomic) IBOutlet UIButton *showDetailBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@end

@implementation SettlementResultNewFreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self addCorner:self.goHomeBtn.layer];
    [self addCorner:self.showDetailBtn.layer];
    self.goHomeBtn.tag = SettlementResultNewBaseCellActionTypeGoHome;
    self.showDetailBtn.tag = SettlementResultNewBaseCellActionTypeOrderDetail;
}

- (void)addCorner:(CALayer *)layer {
    layer.cornerRadius = 2;
    layer.masksToBounds = YES;
    layer.borderColor = [UIColor lightGrayColor].CGColor;
    layer.borderWidth = 1;
}

- (void)setData:(ProductDetailData *)data {
    _data = data;
    self.nameL.text = [NSString stringWithFormat:@"活动名称：%@",_data.serveName];
    self.timeL.text = [NSString stringWithFormat:@"活动时间：%@",_data.time.desc];
    
    NSString *tip = _data.onlineBespeak.advanceDayDesc;
    if ([tip isNotNull]) {
        self.tipL.text = [NSString stringWithFormat:@"温馨提示：%@",tip];
    }else self.tipL.text = nil;
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(settlementResultNewBaseCell:actionType:value:)]) {
        [self.delegate settlementResultNewBaseCell:self actionType:sender.tag value:nil];
    }
}

@end
