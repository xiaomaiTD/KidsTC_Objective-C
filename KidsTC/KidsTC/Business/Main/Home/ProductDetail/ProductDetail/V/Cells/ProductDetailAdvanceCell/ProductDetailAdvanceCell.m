//
//  ProductDetailAdvanceCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/10.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "ProductDetailAdvanceCell.h"

@interface ProductDetailAdvanceCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (weak, nonatomic) IBOutlet UILabel *contentL;
@property (weak, nonatomic) IBOutlet UIView *segueLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineHTwo;

@end

@implementation ProductDetailAdvanceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineH.constant = LINE_H;
    self.HLineHTwo.constant = LINE_H;
}

- (void)setActivity:(ProductDetailActivity *)activity {
    _activity = activity;
    NSString *iconImg = nil;
    switch (_activity.type) {
        case ProductDetailActivityTypeSeckill:
        {
            iconImg = @"productDetail_seckill_pre";
        }
            break;
        case ProductDetailActivityTypeFightGroup:
        {
            iconImg = @"productDetail_fightGroup_pre";
        }
            break;
        default:
            break;
    }
    self.segueLine.hidden = _activity.segueModel==nil||_activity.segueModel.destination==SegueDestinationNone;
    self.icon.image = [UIImage imageNamed:iconImg];
    self.tipL.text = _activity.icon;
    self.contentL.text = _activity.tip;
}
- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(productDetailBaseCell:actionType:value:)]) {
        [self.delegate productDetailBaseCell:self actionType:ProductDetailBaseCellActionTypeSegue value:_activity.segueModel
         ];    }
}

@end
