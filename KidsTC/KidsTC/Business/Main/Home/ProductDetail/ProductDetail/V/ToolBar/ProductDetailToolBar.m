//
//  ProductDetailToolBar.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/25.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailToolBar.h"
#import "UIButton+Category.h"
#import "User.h"

CGFloat const kProductDetailToolBarHeight = 60;

@interface ProductDetailToolBar ()
@property (weak, nonatomic) IBOutlet UIButton *contactBtn;
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
    
    [self.buyBtn setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [self.buyBtn setBackgroundColor:COLOR_PINK forState:UIControlStateNormal];
}

- (IBAction)action:(UIButton *)sender {
    
    ProductDetailToolBarBtnType type = (ProductDetailToolBarBtnType)sender.tag;
    if ([self.delegate respondsToSelector:@selector(productDetailToolBar:btnType:value:)]) {
        [self.delegate productDetailToolBar:self btnType:type value:self.data];
        if (type == ProductDetailToolBarBtnTypeAttention) {
            [[User shareUser] checkLoginWithTarget:nil resultBlock:^(NSString *uid, NSError *error) {
                self.data.isFavor = !self.data.isFavor;
                NSString *imageName = self.data.isFavor?@"ProductDetail_11":@"ProductDetail_04";
                [self.attentionBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            }];
        }
    }
}

- (void)setData:(ProductDetailData *)data {
    _data = data;
    if (data) self.hidden = NO;
    NSString *imageName = data.isFavor?@"ProductDetail_11":@"ProductDetail_04";
    [self.attentionBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    self.buyBtn.enabled = data.isCanBuy;
    [self.buyBtn setTitle:data.statusDesc forState:UIControlStateNormal];
}


@end
