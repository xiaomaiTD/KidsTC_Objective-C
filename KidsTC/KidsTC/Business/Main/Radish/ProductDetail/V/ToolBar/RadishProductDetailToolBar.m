//
//  RadishProductDetailToolBar.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/6.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishProductDetailToolBar.h"

CGFloat const kRadishProductDetailToolBarH = 49;

@interface RadishProductDetailToolBar ()

@property (weak, nonatomic) IBOutlet UIView *countDownView;
@property (weak, nonatomic) IBOutlet UILabel *countDownL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *countDownLineH;

@property (weak, nonatomic) IBOutlet UIView *btnsView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnsHLineH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnsVLineH;
@property (weak, nonatomic) IBOutlet UIButton *consultBtn;
@property (weak, nonatomic) IBOutlet UIButton *attentionBtn;
@property (weak, nonatomic) IBOutlet UIImageView *attentionImg;
@property (weak, nonatomic) IBOutlet UILabel *attentionL;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@end

@implementation RadishProductDetailToolBar

- (void)awakeFromNib {
    [super awakeFromNib];
    self.countDownLineH.constant = LINE_H;
    self.btnsHLineH.constant = LINE_H;
    self.btnsVLineH.constant = LINE_H;
    
    self.consultBtn.tag = RadishProductDetailToolBarActionTypeConsult;
    self.attentionBtn.tag = RadishProductDetailToolBarActionTypeAttention;
    self.buyBtn.tag = RadishProductDetailToolBarActionTypeBuyNow;
}

- (void)setData:(RadishProductDetailData *)data {
    _data = data;
    self.hidden = data==nil;
    
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(radishProductDetailToolBar:actionType:value:)]) {
        [self.delegate radishProductDetailToolBar:self actionType:sender.tag value:_data];
    }
}

@end
