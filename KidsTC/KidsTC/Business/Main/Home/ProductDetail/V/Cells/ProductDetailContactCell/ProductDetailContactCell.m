//
//  ProductDetailContactCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailContactCell.h"
#import "OnlineCustomerService.h"

@interface ProductDetailContactCell ()
@property (weak, nonatomic) IBOutlet UIButton *consultBtn;
@property (weak, nonatomic) IBOutlet UIButton *contactBtn;
@end

@implementation ProductDetailContactCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    [self setupBtn:self.consultBtn];
    [self setupBtn:self.contactBtn];
}

- (void)setupBtn:(UIButton *)btn {
    btn.layer.cornerRadius = 4;
    btn.layer.borderColor = PRODUCT_DETAIL_BLUE.CGColor;
    btn.layer.borderWidth = 1;
    [btn setTitleColor:PRODUCT_DETAIL_BLUE forState:UIControlStateNormal];
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    
}

- (IBAction)consult:(UIButton *)sender {
    NSString *str = [OnlineCustomerService onlineCustomerServiceLinkUrlString];
    if (str.length>0) {
        if ([self.delegate respondsToSelector:@selector(productDetailBaseCell:actionType:value:)]) {
            [self.delegate productDetailBaseCell:self actionType:ProductDetailBaseCellActionTypeConsult value:str];
        }
    }
}

- (IBAction)contact:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(productDetailBaseCell:actionType:value:)]) {
        [self.delegate productDetailBaseCell:self actionType:ProductDetailBaseCellActionTypeContact value:nil];
    }
}
@end
