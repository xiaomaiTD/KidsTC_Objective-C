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

@interface ProductDetailRecommendCell ()
@property (weak, nonatomic) IBOutlet UIImageView *productImg;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet UILabel *statusL;
@end

@implementation ProductDetailRecommendCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.productImg.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.productImg.layer.borderWidth = LINE_H;
    self.productImg.layer.cornerRadius = 4;
    self.productImg.layer.masksToBounds = YES;
    self.priceL.textColor = PRODUCT_DETAIL_RED;
    
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGR];
}

- (void)setData:(ProductDetailData *)data {
    [super setData:data];
    
    if (_index<data.recommends.count) {
        ProductDetailRecommendItem *item = data.recommends[_index];
        [self.productImg sd_setImageWithURL:[NSURL URLWithString:item.img] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
        self.priceL.text = item.priceStr;
        self.addressL.text = item.locationStr;
        self.statusL.text = item.process;
    }
}

- (void)tapAction:(UITapGestureRecognizer *)tapGR {
    if (_index<self.data.recommends.count) {
        if ([self.delegate respondsToSelector:@selector(productDetailBaseCell:actionType:value:)]) {
            [self.delegate productDetailBaseCell:self actionType:ProductDetailBaseCellActionTypeRecommend value:self.data.recommends[_index]];
        }
    }
}

@end
