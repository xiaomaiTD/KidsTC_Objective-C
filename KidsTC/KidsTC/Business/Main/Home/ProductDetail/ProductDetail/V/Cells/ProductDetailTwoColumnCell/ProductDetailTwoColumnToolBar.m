//
//  ProductDetailTwoColumnToolBar.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTwoColumnToolBar.h"

CGFloat const kTwoColumnToolBarH = 50;

@interface ProductDetailTwoColumnToolBar ()
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (weak, nonatomic) IBOutlet UIButton *consultBtn;
@property (weak, nonatomic) IBOutlet UIView *tipView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tipConstraintLeading;
@end

@implementation ProductDetailTwoColumnToolBar

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    [self.detailBtn setTitleColor:COLOR_PINK forState:UIControlStateNormal];
    [self.consultBtn setTitleColor:COLOR_PINK forState:UIControlStateNormal];
    self.tipView.backgroundColor = COLOR_PINK;
    self.detailBtn.tag = ProductDetailTwoColumnToolBarActionTypeDetail;
    self.consultBtn.tag = ProductDetailTwoColumnToolBarActionTypeConsult;
}

- (IBAction)action:(UIButton *)sender {
    self.tipConstraintLeading.constant = CGRectGetMinX(sender.frame);
    if ([self.delegate respondsToSelector:@selector(productDetailTwoColumnToolBar:ationType:value:)]) {
        [self.delegate productDetailTwoColumnToolBar:self ationType:(ProductDetailTwoColumnToolBarActionType)sender.tag value:nil];
    }
}


@end
