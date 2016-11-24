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
    
    self.tipView.backgroundColor = COLOR_PINK;
    self.detailBtn.tag = ProductDetailTwoColumnToolBarActionTypeDetail;
    self.consultBtn.tag = ProductDetailTwoColumnToolBarActionTypeConsult;
}

- (void)setData:(ProductDetailData *)data {
    _data = data;
    
    NSInteger count = data.advisoryCount;
    NSString *consultTitle = count>0 ? [NSString stringWithFormat:@"活动咨询(%zd)",count]:@"活动咨询";
    [self.consultBtn setTitle:consultTitle forState:UIControlStateNormal];
    
    switch (data.showType) {
        case ProductDetailTwoColumnShowTypeDetail:
        {
            [self selectBtn:self.detailBtn];
        }
            break;
        case ProductDetailTwoColumnShowTypeConsult:
        {
            [self selectBtn:self.consultBtn];
        }
            break;
    }
}

- (IBAction)action:(UIButton *)sender {
    if (self.selectedBtn == sender) return;
    [self selectBtn:sender];
    self.data.showType = (ProductDetailTwoColumnShowType)sender.tag;
    if ([self.delegate respondsToSelector:@selector(productDetailTwoColumnToolBar:ationType:value:)]) {
        [self.delegate productDetailTwoColumnToolBar:self ationType:(ProductDetailTwoColumnToolBarActionType)sender.tag value:nil];
    }
}

- (void)selectBtn:(UIButton *)sender {
    self.selectedBtn.selected = NO;
    sender.selected = YES;
    self.selectedBtn = sender;
    self.tipConstraintLeading.constant = CGRectGetMinX(sender.frame);
}


@end
