//
//  RecommendStoreCollectStoreCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/21.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RecommendStoreCollectStoreCell.h"
#import "Colours.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "NSString+Category.h"

@interface RecommendStoreCollectStoreCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineH;
@end

@implementation RecommendStoreCollectStoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setNeedsLayout];
    [self layoutIfNeeded];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.icon.layer.borderWidth = LINE_H;
    self.icon.layer.cornerRadius = 4;
    self.icon.layer.masksToBounds = YES;
    self.lineH.constant = LINE_H;
    self.nameL.textColor = [UIColor colorFromHexString:@"555555"];
    self.priceL.textColor = [UIColor colorFromHexString:@"F36863"];
    
}


- (void)setStoreProduct:(RecommendStoreProduct *)storeProduct {
    _storeProduct = storeProduct;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:storeProduct.picUrl] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    self.nameL.text = storeProduct.productName;
    self.priceL.text = [NSString stringWithFormat:@"%@",storeProduct.priceStr];

}

@end
