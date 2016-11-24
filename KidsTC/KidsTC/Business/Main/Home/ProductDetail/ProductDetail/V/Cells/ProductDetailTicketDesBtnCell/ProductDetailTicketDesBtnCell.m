//
//  ProductDetailTicketDesBtnCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/18.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTicketDesBtnCell.h"

@interface ProductDetailTicketDesBtnCell ()
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ProductDetailTicketDesBtnCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.btn.tag = ProductDetailBaseCellActionTypeTicketOpenDes;
}
- (IBAction)action:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.data.synopsisOpen = sender.selected;
    if ([self.delegate respondsToSelector:@selector(productDetailBaseCell:actionType:value:)]) {
        [self.delegate productDetailBaseCell:self actionType:sender.tag value:nil];
    }
}
- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    self.btn.selected = data.synopsisOpen;
}

@end
