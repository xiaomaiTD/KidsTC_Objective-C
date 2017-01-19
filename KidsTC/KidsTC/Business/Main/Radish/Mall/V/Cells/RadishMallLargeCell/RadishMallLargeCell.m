//
//  RadishMallLargeCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/1/9.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishMallLargeCell.h"
#import "UIImageView+WebCache.h"

@interface RadishMallLargeCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *joinL;
@property (weak, nonatomic) IBOutlet UILabel *timeL;
@property (weak, nonatomic) IBOutlet UILabel *radishCountL;
@property (weak, nonatomic) IBOutlet UIButton *buyBtn;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *originalPriceL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconH;

@end

@implementation RadishMallLargeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    
    self.bgView.layer.cornerRadius = 4;
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.bgView.layer.borderWidth = LINE_H;
    
    self.icon.layer.cornerRadius = 4;
    self.icon.layer.masksToBounds = YES;
    
    self.buyBtn.layer.cornerRadius = 2;
    self.buyBtn.layer.masksToBounds = YES;
    
}
- (void)setProduct:(RadishMallProduct *)product {
    
    [super setProduct:product];
    
    self.iconH.constant = CGRectGetWidth(self.icon.bounds) * product.ratio;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:product.imgUrl] placeholderImage:PLACEHOLDERIMAGE_BIG];
    
    self.nameL.text = product.productName;
    self.joinL.text = [NSString stringWithFormat:@"已有%@人参与",product.buyCount];
    self.timeL.text = product.timeDesc;
    self.radishCountL.text = [NSString stringWithFormat:@"%@根",product.radishCount];
    if (product.price>0) {
        self.priceL.text = [NSString stringWithFormat:@"+%@元",@(product.price)];
    }else self.priceL.text = nil;
    
    if (product.originalPrice>0) {
        self.originalPriceL.text = [NSString stringWithFormat:@"%@元",@(product.originalPrice)];
    }else self.originalPriceL.text = nil;
    
    [self.buyBtn setTitle:product.btnName forState:UIControlStateNormal];
    NSString *btnColor = product.canBuy?@"FF8888":@"cccccc";
    self.buyBtn.backgroundColor = [UIColor colorFromHexString:btnColor];
    
    [self layoutIfNeeded];
}

@end
