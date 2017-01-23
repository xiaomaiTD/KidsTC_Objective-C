//
//  FlashBuyProductDetailColumnsHeader.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/23.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "FlashBuyProductDetailColumnsHeader.h"

@interface FlashBuyProductDetailColumnsHeader ()
@property (weak, nonatomic) IBOutlet UIButton *detailBtn;
@property (weak, nonatomic) IBOutlet UIButton *storeBtn;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tipLeadingMargin;
@end

@implementation FlashBuyProductDetailColumnsHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.detailBtn.tag = FlashBuyProductDetailShowTypeDetail;
    self.storeBtn.tag = FlashBuyProductDetailShowTypeStore;
    self.commentBtn.tag = FlashBuyProductDetailShowTypeComment;
    self.HLineH.constant = LINE_H;
}

- (void)setData:(FlashBuyProductDetailData *)data {
    _data = data;
    self.tipLeadingMargin.constant = (data.showType-1)*(SCREEN_WIDTH/3);
    switch (data.showType) {
        case FlashBuyProductDetailShowTypeDetail:
        {
            self.detailBtn.selected = YES;
            self.storeBtn.selected = NO;
            self.commentBtn.selected = NO;
        }
            break;
        case FlashBuyProductDetailShowTypeStore:
        {
            self.detailBtn.selected = NO;
            self.storeBtn.selected = YES;
            self.commentBtn.selected = NO;
        }
            break;
        case FlashBuyProductDetailShowTypeComment:
        {
            self.detailBtn.selected = NO;
            self.storeBtn.selected = NO;
            self.commentBtn.selected = YES;
        }
            break;
        default:
        {
            self.detailBtn.selected = YES;
            self.storeBtn.selected = NO;
            self.commentBtn.selected = NO;
        }
            break;
    }
}

- (IBAction)action:(UIButton *)sender {
    if (sender.selected) return;
    self.data.showType = (FlashBuyProductDetailShowType)sender.tag;
    if (self.actionBlock) {
        self.actionBlock();
    }
}

@end
