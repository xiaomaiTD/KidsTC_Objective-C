//
//  NormalProductDetailColumnHeader.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/4.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "NormalProductDetailColumnHeader.h"

CGFloat const kNormalProductDetailColumnHeaderH = 46;

@interface NormalProductDetailColumnHeader ()
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (weak, nonatomic) IBOutlet UIButton *consultBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tipLeadingMargin;
@end

@implementation NormalProductDetailColumnHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    self.detailBtn.tag = NormalProductDetailColumnShowTypeDetail;
    self.consultBtn.tag = NormalProductDetailColumnShowTypeConsult;
    self.HLineH.constant = LINE_H;
    [self layoutIfNeeded];
}

- (void)setData:(NormalProductDetailData *)data {
    _data = data;
    switch (data.showType) {
        case NormalProductDetailColumnShowTypeConsult:
        {
            self.tipLeadingMargin.constant = SCREEN_WIDTH*0.5;
            self.detailBtn.selected = NO;
            self.consultBtn.selected = YES;
            [self layoutIfNeeded];
        }
            break;
        default:
        {
            self.tipLeadingMargin.constant = 0;
            self.detailBtn.selected = YES;
            self.consultBtn.selected = NO;
            [self layoutIfNeeded];
        }
            break;
    }
}

- (IBAction)action:(UIButton *)sender {
    if (sender.selected) return;
    self.data.showType = (NormalProductDetailColumnShowType)sender.tag;
    if (self.actionBlock) {
        self.actionBlock();
    }
}
@end
