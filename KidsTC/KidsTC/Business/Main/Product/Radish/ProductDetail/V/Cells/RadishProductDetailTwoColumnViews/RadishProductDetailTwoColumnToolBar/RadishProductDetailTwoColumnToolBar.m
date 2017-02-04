//
//  RadishProductDetailTwoColumnToolBar.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishProductDetailTwoColumnToolBar.h"
#import "Colours.h"

CGFloat const kRadishTwoColumnToolBarH = 46;

@interface RadishProductDetailTwoColumnToolBar ()
@property (weak, nonatomic) IBOutlet UILabel *detailL;
@property (weak, nonatomic) IBOutlet UILabel *consultL;
@property (weak, nonatomic) IBOutlet UIView *tipView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tipConstraintLeading;
@property (weak, nonatomic) UILabel *selectL;
@end

@implementation RadishProductDetailTwoColumnToolBar

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.detailL.backgroundColor = [UIColor whiteColor];
    self.consultL.backgroundColor = [UIColor whiteColor];
    self.tipView.backgroundColor = COLOR_PINK;
    
    self.detailL.tag = RadishProductDetailTwoColumnShowTypeDetail;
    self.consultL.tag = RadishProductDetailTwoColumnShowTypeConsult;
    
    UITapGestureRecognizer *detailGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.detailL addGestureRecognizer:detailGR];
    
    UITapGestureRecognizer *consultGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.consultL addGestureRecognizer:consultGR];
    
    [self layoutIfNeeded];
}

- (void)setData:(RadishProductDetailData *)data {
    _data = data;
    
    NSInteger count = data.advisoryCount;
    self.consultL.text = count>0 ? [NSString stringWithFormat:@"活动咨询(%zd)",count]:@"活动咨询";
    
    switch (data.showType) {
        case RadishProductDetailTwoColumnShowTypeDetail:
        {
            [self selectLabel:self.detailL];
        }
            break;
        case RadishProductDetailTwoColumnShowTypeConsult:
        {
            [self selectLabel:self.consultL];
        }
            break;
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    UILabel *label = (UILabel *)tapGR.view;
    if (self.selectL == label) {
        return;
    }
    [self selectLabel:label];
    self.data.showType = (RadishProductDetailTwoColumnShowType)label.tag;
    if ([self.delegate respondsToSelector:@selector(radishProductDetailTwoColumnToolBar:ationType:value:)]) {
        [self.delegate radishProductDetailTwoColumnToolBar:self ationType:(RadishProductDetailTwoColumnShowType)label.tag value:nil];
    }
}

- (void)selectLabel:(UILabel *)label {
    [self layoutIfNeeded];
    UIColor *dark = [UIColor colorFromHexString:@"222222"];
    self.detailL.textColor = (label == self.detailL)?COLOR_PINK:dark;
    self.consultL.textColor = (label == self.consultL)?COLOR_PINK:dark;
    self.tipConstraintLeading.constant = CGRectGetMinX(label.frame);
    self.selectL = label;
}


@end
