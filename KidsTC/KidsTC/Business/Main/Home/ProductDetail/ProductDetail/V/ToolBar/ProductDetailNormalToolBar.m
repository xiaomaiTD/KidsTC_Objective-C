//
//  ProductDetailNormalToolBar.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/25.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailNormalToolBar.h"
#import "UIButton+Category.h"
#import "User.h"



@interface ProductDetailNormalToolBar ()
@property (weak, nonatomic) IBOutlet UIButton *contactBtn;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintH;
@end

@implementation ProductDetailNormalToolBar

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.HLineConstraintH.constant = LINE_H;
    self.buyBtn.backgroundColor = COLOR_PINK;
    
    self.contactBtn.tag = ProductDetailBaseToolBarActionTypeConsult;
    self.attentionBtn.tag = ProductDetailBaseToolBarActionTypeAttention;
    self.buyBtn.tag = ProductDetailBaseToolBarActionTypeBuyNow;
    
    [self.buyBtn setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [self.buyBtn setBackgroundColor:COLOR_PINK forState:UIControlStateNormal];
}

- (IBAction)action:(UIButton *)sender {
    ProductDetailBaseToolBarActionType type = (ProductDetailBaseToolBarActionType)sender.tag;
    if ([self.delegate respondsToSelector:@selector(productDetailBaseToolBar:actionType:value:)]) {
        [self.delegate productDetailBaseToolBar:self actionType:type value:self.data];
        if (type == ProductDetailBaseToolBarActionTypeAttention) {
            [[User shareUser] checkLoginWithTarget:nil resultBlock:^(NSString *uid, NSError *error) {
                self.data.isFavor = !self.data.isFavor;
                NSString *imageName = self.data.isFavor?@"ProductDetail_11":@"ProductDetail_04";
                [self.attentionBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
            }];
        }
    }
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    if (data) self.hidden = NO;
    NSString *imageName = data.isFavor?@"ProductDetail_11":@"ProductDetail_04";
    [self.attentionBtn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    self.buyBtn.enabled = data.isCanBuy;
    [self.buyBtn setTitle:data.statusDesc forState:UIControlStateNormal];
}


@end
