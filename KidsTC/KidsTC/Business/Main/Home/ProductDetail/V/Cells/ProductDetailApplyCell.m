//
//  ProductDetailApplyCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailApplyCell.h"

@interface ProductDetailApplyCell ()
@property (weak, nonatomic) IBOutlet UIView *tipView;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@end

@implementation ProductDetailApplyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.tipView.layer.cornerRadius = 2;
    self.tipView.layer.masksToBounds = YES;
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

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    
}

- (void)setAttStr:(NSAttributedString *)attStr {
    _attStr = attStr;
    self.titleL.attributedText = attStr;
}

@end
