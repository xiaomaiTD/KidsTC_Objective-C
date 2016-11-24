//
//  ProductDetaiFreeLifeTipCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetaiFreeLifeTipCell.h"

@interface ProductDetaiFreeLifeTipCell ()
@property (weak, nonatomic) IBOutlet UILabel *tipL;
@property (weak, nonatomic) IBOutlet UILabel *contentL;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

@end

@implementation ProductDetaiFreeLifeTipCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.moreBtn.tag = ProductDetailBaseCellActionTypeFreeMoreTricks;
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(productDetailBaseCell:actionType:value:)]) {
        [self.delegate productDetailBaseCell:self actionType:sender.tag value:nil];
    }
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    self.tipL.text = data.trickName;
    self.contentL.attributedText = data.attTrickStr;
}

@end
