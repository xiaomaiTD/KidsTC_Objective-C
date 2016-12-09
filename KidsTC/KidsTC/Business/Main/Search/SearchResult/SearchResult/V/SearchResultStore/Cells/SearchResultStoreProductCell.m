//
//  SearchResultStoreProductCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/8.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchResultStoreProductCell.h"
#import "UIImageView+WebCache.h"

@interface SearchResultStoreProductCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIView *infoBGView;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineH;
@end

@implementation SearchResultStoreProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.icon.layer.cornerRadius = 4;
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.icon.layer.borderWidth = LINE_H;
    self.HLineH.constant = LINE_H;
}

- (void)setStoreProduct:(SearchResultStoreProduct *)storeProduct {
    _storeProduct = storeProduct;
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:_storeProduct.ImgUrl] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    self.nameL.text = _storeProduct.ProductName;
    self.priceL.text = _storeProduct.Price;
}

@end
