//
//  StoreDetailPackageMoreCell.m
//  KidsTC
//
//  Created by 童成mac-dev1 on 2017/2/12.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "StoreDetailPackageMoreCell.h"

#import "UIImageView+WebCache.h"
#import "NSString+Category.h"

@interface StoreDetailPackageMoreCell ()

@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;

@property (weak, nonatomic) IBOutlet UILabel *storePriceL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *storePriceLeading;

@property (weak, nonatomic) IBOutlet UIView *discountBGView;
@property (weak, nonatomic) IBOutlet UILabel *discountL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *discountBGViewLeading;

@property (weak, nonatomic) IBOutlet UIView *ageBGView;
@property (weak, nonatomic) IBOutlet UILabel *ageL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ageBGViewLeading;

@property (weak, nonatomic) IBOutlet UIView *tagBGView;
@property (weak, nonatomic) IBOutlet UILabel *tagL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagBGViewLeading;

@property (weak, nonatomic) IBOutlet UILabel *saleCountL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineH;
@end

@implementation StoreDetailPackageMoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.icon.layer.cornerRadius = 4;
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.borderWidth = LINE_H;
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    
    self.tagBGView.layer.cornerRadius = 2;
    self.tagBGView.layer.masksToBounds = YES;
    
    self.discountBGView.layer.cornerRadius = 2;
    self.discountBGView.layer.masksToBounds = YES;
    self.discountBGView.layer.borderColor = [UIColor colorFromHexString:@"ffbc00"].CGColor;
    self.discountBGView.layer.borderWidth = 1;
    
    self.ageBGView.layer.cornerRadius = 2;
    self.ageBGView.layer.masksToBounds = YES;
    self.ageBGView.layer.borderColor = [UIColor colorFromHexString:@"71B0EA"].CGColor;
    self.ageBGView.layer.borderWidth = 1;
    
    self.lineH.constant = LINE_H;
}

- (void)setProduct:(TCStoreDetailProductPackageItem *)product {
    _product = product;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:product.productImg] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    self.nameL.text = product.productName;
    self.priceL.text = product.price;
    
    if (product.isShowStorePrice) {
        self.storePriceL.text = product.storePrice;
        self.storePriceLeading.constant = 8;
        
        self.discountBGView.hidden = YES;
        self.discountBGViewLeading.constant = -8;
        self.discountL.text = nil;
        
    }else{
        self.storePriceL.text = nil;
        self.storePriceLeading.constant = 0;
        
        self.discountBGView.hidden = ![product.reducePrice isNotNull];
        self.discountBGViewLeading.constant = self.discountBGView.hidden?-8:8;
        self.discountL.text = product.reducePrice;
    }
    
    self.ageBGView.hidden = ![product.ageGroup isNotNull];
    self.ageBGViewLeading.constant = self.ageBGView.hidden?0:8;
    self.ageL.text = product.ageGroup;
    
    switch (product.productTagType) {
        case TCStoreDetailProductPackageItemTypeFightGroup:
        {
            self.tagBGView.hidden = NO;
            self.tagL.text = @"团";
        }
            break;
        case TCStoreDetailProductPackageItemTypeSeckill:
        {
            self.tagBGView.hidden = NO;
            self.tagL.text = @"秒";
        }
            break;
        default:
        {
            self.tagBGView.hidden = YES;
        }
            break;
    }
    
    self.saleCountL.text = [NSString stringWithFormat:@"已售%@",product.saleNum];
}

@end
