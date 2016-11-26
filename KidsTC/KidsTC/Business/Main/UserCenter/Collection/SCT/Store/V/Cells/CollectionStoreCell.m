//
//  CollectionStoreCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "CollectionStoreCell.h"
#import "Colours.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "NSString+Category.h"

@interface CollectionStoreCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineH;
@end

@implementation CollectionStoreCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.icon.layer.borderWidth = LINE_H;
    self.icon.layer.cornerRadius = 4;
    self.icon.layer.masksToBounds = YES;
    self.lineH.constant = LINE_H;
    self.nameL.textColor = [UIColor colorFromHexString:@"555555"];
    self.priceL.textColor = [UIColor colorFromHexString:@"F36863"];
    [self layoutIfNeeded];
}

- (void)setProduct:(CollectionStoreProduct *)product {
    _product = product;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:product.img] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    self.nameL.text = product.name;
    self.priceL.text = [NSString stringWithFormat:@"¥%@",product.price];
}

@end
