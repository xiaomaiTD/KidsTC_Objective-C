//
//  ProductStandardHeaderView.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductStandardHeaderView.h"
#import "UIImageView+WebCache.h"

@interface ProductStandardHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *storePriceL;
@property (weak, nonatomic) IBOutlet UILabel *stockL;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineOneH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineTwoH;
@end

@implementation ProductStandardHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineOneH.constant = LINE_H;
    self.HLineTwoH.constant = LINE_H;
    self.priceL.textColor = COLOR_PINK;
    self.icon.layer.cornerRadius = 4;
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.icon.layer.borderWidth = 1;
    self.icon.layer.masksToBounds = YES;
    self.hidden = YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{}

- (IBAction)closeAction:(UIButton *)sender {
    if (self.closeBlock) self.closeBlock();
}

- (void)setStandardDetailData:(ProductStandardDetailData *)standardDetailData {
    _standardDetailData = standardDetailData;
    self.hidden = _standardDetailData == nil;

    [self.icon sd_setImageWithURL:[NSURL URLWithString:_standardDetailData.productImg] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    self.priceL.text = [NSString stringWithFormat:@"¥%@",_standardDetailData.price];
    self.storePriceL.text = [NSString stringWithFormat:@"%@",_standardDetailData.storePrice];
    self.stockL.text = [NSString stringWithFormat:@"(库存%@)",_standardDetailData.remainStock];
    self.nameL.text = _standardDetailData.productName;
}

@end
