//
//  ProductDetailTicketDesCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailTicketDesCell.h"

@interface ProductDetailTicketDesCell ()
@property (weak, nonatomic) IBOutlet UILabel *contentL;
@property (weak, nonatomic) IBOutlet UIButton *openBgn;
@end

@implementation ProductDetailTicketDesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.openBgn.tag = ProductDetailBaseCellActionTypeTicketOpenDes;
}

- (IBAction)action:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(productDetailBaseCell:actionType:value:)]) {
        [self.delegate productDetailBaseCell:self actionType:sender.tag value:nil];
    }
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    
}

@end
