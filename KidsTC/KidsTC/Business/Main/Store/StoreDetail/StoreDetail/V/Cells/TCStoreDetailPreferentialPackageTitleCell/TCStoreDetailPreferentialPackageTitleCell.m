//
//  TCStoreDetailPreferentialPackageTitleCell.m
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "TCStoreDetailPreferentialPackageTitleCell.h"
#import "NSString+Category.h"

@interface TCStoreDetailPreferentialPackageTitleCell ()
@property (weak, nonatomic) IBOutlet UIView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *iconL;
@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleLeadingMargin;
@end

@implementation TCStoreDetailPreferentialPackageTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.iconView.layer.borderColor = [UIColor colorFromHexString:@"71B0EA"].CGColor;
    self.iconView.layer.borderWidth = 1;
    self.HLineH.constant = LINE_H;
}

- (void)setData:(TCStoreDetailData *)data {
    [super setData:data];
    
    TCStoreDetailProductPackage *productPackage = data.productPackage;
    self.iconL.text = productPackage.iconText;
    self.iconView.hidden = ![productPackage.iconText isNotNull];
    self.titleL.text = [NSString stringWithFormat:@"%@(%zd)",productPackage.title,productPackage.products.count];
    self.titleLeadingMargin.constant = self.iconView.hidden?0:8;
    [self layoutIfNeeded];
}


@end
