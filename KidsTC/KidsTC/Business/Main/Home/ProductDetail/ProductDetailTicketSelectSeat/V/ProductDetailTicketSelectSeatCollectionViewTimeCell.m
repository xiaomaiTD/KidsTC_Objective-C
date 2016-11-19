//
//  ProductDetailTicketSelectSeatCollectionViewTimeCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTicketSelectSeatCollectionViewTimeCell.h"
#import "UIButton+Category.h"
#import "Colours.h"
#import "YYKit.h"

@interface ProductDetailTicketSelectSeatCollectionViewTimeCell ()


@end

@implementation ProductDetailTicketSelectSeatCollectionViewTimeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.btn.titleLabel.numberOfLines = 0;
    self.btn.layer.borderColor = [UIColor colorFromHexString:@"dedede"].CGColor;
    self.btn.layer.borderWidth = 1;
    
    [self.btn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btn setBackgroundColor:[UIColor colorFromHexString:@"EEEEEE"] forState:UIControlStateDisabled];
    [self.btn setBackgroundColor:COLOR_PINK forState:UIControlStateSelected];
}

- (void)setIndexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    self.btn.tag = indexPath.row;
}

- (void)setTime:(ProductDetailTicketSelectSeatTime *)time {
    _time = time;
    
    [self setBtnTitleColor:[UIColor colorFromHexString:@"555555"] forState:UIControlStateNormal];
    [self setBtnTitleColor:[UIColor colorFromHexString:@"FFFFFF"] forState:UIControlStateSelected];
    [self setBtnTitleColor:[UIColor colorFromHexString:@"A9A9A9"] forState:UIControlStateDisabled];
    
    if (time.selected) {
        [self delegateAction:self.btn reload:NO];
    }
}

- (void)setBtnTitleColor:(UIColor *)color forState:(UIControlState)state {
    NSMutableAttributedString *attInfoStr = [_time.attInfoStr mutableCopy];
    attInfoStr.color = color;
    [self.btn setAttributedTitle:attInfoStr forState:state];
}

- (IBAction)action:(UIButton *)sender {
    [self delegateAction:self.btn reload:YES];
}

- (void)delegateAction:(UIButton *)btn reload:(BOOL)reload {
    if ([self.delegate respondsToSelector:@selector(productDetailTicketSelectSeatCollectionViewTimeCell:actionType:value:)]) {
        [self.delegate productDetailTicketSelectSeatCollectionViewTimeCell:self actionType:ProductDetailTicketSelectSeatCollectionViewTimeCellActionTypeClickBtn value:@(reload)];
    }
}
@end
