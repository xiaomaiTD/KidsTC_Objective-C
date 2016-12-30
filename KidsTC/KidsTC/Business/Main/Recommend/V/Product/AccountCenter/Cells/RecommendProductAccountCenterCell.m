//
//  RecommendProductAccountCenterCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/20.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RecommendProductAccountCenterCell.h"
#import "UIImageView+WebCache.h"
#import "NSString+Category.h"

@interface RecommendProductAccountCenterCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIView *infoContentView;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *freeL;
@property (weak, nonatomic) IBOutlet UILabel *freeNumL;
@property (weak, nonatomic) IBOutlet UILabel *signL;
@property (weak, nonatomic) IBOutlet UILabel *distanceL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@end

@implementation RecommendProductAccountCenterCell


- (void)setProduct:(RecommendProduct *)product {
    _product = product;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:product.picUrl] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    self.nameL.text = product.productName;
    NSString *distance = [product.distanceDesc isNotNull]?[NSString stringWithFormat:@"距离%@",product.distanceDesc]:nil;
    self.distanceL.text = distance;
    
    switch (product.productType) {
        case ProductDetailTypeFree:
        {
            self.freeL.text = @"免费名额";
            self.freeNumL.text = product.freeProductTotalNum;
            self.signL.text = [NSString stringWithFormat:@"已有%@人报名",product.freeProductSaleNum];
            self.priceL.text = @" ";
            self.priceL.hidden = YES;
            self.signL.hidden = NO;
        }
            break;
        default:
        {
            self.freeL.text = @"限时特卖";
            self.freeNumL.text = @" ";
            self.signL.text = @" ";
            self.priceL.text = product.priceStr;
            self.priceL.hidden = NO;
            self.signL.hidden = YES;
        }
            break;
    }
}

@end
