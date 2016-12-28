//
//  WolesaleProductDetailTimeCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "WolesaleProductDetailTimeCell.h"

@interface WolesaleProductDetailTimeCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImg;

@end

@implementation WolesaleProductDetailTimeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
}

- (void)setData:(WolesaleProductDetailData *)data {
    [super setData:data];
    self.timeL.text = data.fightGroupBase.productTime.desc;
    NSArray<ProductDetailTimeItem *> *times = self.data.fightGroupBase.productTime.times;
    self.arrowImg.hidden = times.count<1;
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(wolesaleProductDetailBaseCell:actionType:value:)]) {
        [self.delegate wolesaleProductDetailBaseCell:self actionType:WolesaleProductDetailBaseCellActionTypeTime value:nil];
    }
}
@end
