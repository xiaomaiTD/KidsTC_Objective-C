//
//  ProductDetailToolBar.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/25.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailToolBar.h"

CGFloat const kProductDetailToolBarHeight = 60;

@interface ProductDetailToolBar ()
@property (weak, nonatomic) IBOutlet UIButton *contactBtn;
@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintH;
@end

@implementation ProductDetailToolBar

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.HLineConstraintH.constant = LINE_H;
    self.buyBtn.backgroundColor = COLOR_PINK;
    
    self.contactBtn.tag = ProductDetailToolBarBtnTypeContact;
    self.attentionBtn.tag = ProductDetailToolBarBtnTypeAttention;
    self.buyBtn.tag = ProductDetailToolBarBtnTypeBuy;
    
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(productDetailToolBar:btnType:value:)]) {
        [self.delegate productDetailToolBar:self btnType:(ProductDetailToolBarBtnType)sender.tag value:nil];
    }
}


@end
