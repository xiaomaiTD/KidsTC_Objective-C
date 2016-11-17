//
//  ProductDetailTwoColumnToolBar.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTwoColumnToolBar.h"

CGFloat const kTwoColumnToolBarH = 46;

@interface ProductDetailTwoColumnToolBar ()
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (weak, nonatomic) IBOutlet UIButton *consultBtn;
@property (weak, nonatomic) IBOutlet UIView *tipView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tipConstraintLeading;
@property (nonatomic, strong) UIButton *selectedBtn;
@end

@implementation ProductDetailTwoColumnToolBar

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.detailBtn.backgroundColor = [UIColor whiteColor];
    self.consultBtn.backgroundColor = [UIColor whiteColor];
    [self.detailBtn setTitleColor:COLOR_PINK forState:UIControlStateSelected];
    [self.consultBtn setTitleColor:COLOR_PINK forState:UIControlStateSelected];
    [self.detailBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.consultBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.detailBtn.selected = YES;
    self.tipView.backgroundColor = COLOR_PINK;
    self.detailBtn.tag = ProductDetailTwoColumnToolBarActionTypeDetail;
    self.consultBtn.tag = ProductDetailTwoColumnToolBarActionTypeConsult;
}

- (void)setCount:(NSInteger)count {
    _count = count;
    if (count>0) {
        [self.consultBtn setTitle:[NSString stringWithFormat:@"活动咨询(%zd)",count] forState:UIControlStateNormal];
    }else{
        [self.consultBtn setTitle:@"活动咨询" forState:UIControlStateNormal];
    }
}

- (IBAction)action:(UIButton *)sender {
    
    if (self.selectedBtn == sender) {
        return;
    }
    
    self.tipConstraintLeading.constant = CGRectGetMinX(sender.frame);
    if ([self.delegate respondsToSelector:@selector(productDetailTwoColumnToolBar:ationType:value:)]) {
        [self.delegate productDetailTwoColumnToolBar:self ationType:(ProductDetailTwoColumnToolBarActionType)sender.tag value:nil];
    }
    self.selectedBtn.selected = NO;
    sender.selected = YES;
    self.selectedBtn = sender;
}


@end
