//
//  ProductDetailRecommendCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ProductDetailRecommendCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "NSString+Category.h"

@interface ProductDetailRecommendCell ()
@property (weak, nonatomic) IBOutlet UIImageView *productImg;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet UIImageView *addressIcon;

@property (weak, nonatomic) IBOutlet UILabel *statusL;
@property (weak, nonatomic) IBOutlet UIImageView *statusIcon;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineH;
@end

@implementation ProductDetailRecommendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.productImg.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.productImg.layer.borderWidth = LINE_H;
    self.productImg.layer.cornerRadius = 4;
    self.productImg.layer.masksToBounds = YES;
    self.priceL.textColor = PRODUCT_DETAIL_RED;
    
    self.nameL.textColor = [UIColor colorFromHexString:@"222222"];
    self.addressL.textColor = [UIColor colorFromHexString:@"666666"];
    self.statusL.textColor = [UIColor colorFromHexString:@"666666"];
    self.lineH.constant = LINE_H;
    [self layoutIfNeeded];
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGR];
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    
    if (_index<data.recommends.count) {
        RecommendProduct *item = data.recommends[_index];
        self.nameL.text = item.productName;
        [self.productImg sd_setImageWithURL:[NSURL URLWithString:item.picUrl] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
        self.priceL.text = item.priceStr;
        self.addressL.text = [NSString stringWithFormat:@"%@ %@",item.address,item.distanceDesc];
        self.statusL.text = item.useValidTimeDesc;
        self.addressIcon.hidden = !([item.address isNotNull] && [item.distanceDesc isNotNull]);
        self.statusIcon.hidden = ![item.useValidTimeDesc isNotNull];
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if (_index<self.data.recommends.count) {
        if ([self.delegate respondsToSelector:@selector(productDetailBaseCell:actionType:value:)]) {
            [self.delegate productDetailBaseCell:self actionType:ProductDetailBaseCellActionTypeSegue value:self.data.recommends[_index].segueModel];
        }
    }
}

@end
