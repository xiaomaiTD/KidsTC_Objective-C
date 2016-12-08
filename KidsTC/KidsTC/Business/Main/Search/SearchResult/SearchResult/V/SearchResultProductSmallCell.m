//
//  SearchResultProductSmallCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "SearchResultProductSmallCell.h"
#import "FiveStarsView.h"
#import "UIImageView+WebCache.h"

@interface SearchResultProductSmallCell ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIView *infoContentView;
@property (weak, nonatomic) IBOutlet UILabel *nameL;
@property (weak, nonatomic) IBOutlet FiveStarsView *starsView;
@property (weak, nonatomic) IBOutlet UILabel *numL;
@property (weak, nonatomic) IBOutlet UILabel *numTipL;
@property (weak, nonatomic) IBOutlet UIImageView *addressTipIcon;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet UILabel *distanceL;
@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *cityL;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineH;
@end

@implementation SearchResultProductSmallCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.icon.layer.cornerRadius = 4;
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.borderColor = [UIColor groupTableViewBackgroundColor].CGColor;
    self.icon.layer.borderWidth = LINE_H;
    self.lineH.constant = LINE_H;
}

- (void)setProduct:(SearchResultProduct *)product {
    _product = product;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:_product.imgurl] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    self.nameL.text = _product.name;
    _starsView.starNumber = _product.level;
    _numL.text = _product.num;
    //_numTipL.text = _product.;
    _addressL.text = _product.address;
    _distanceL.text = _product.distance;
    _priceL.text = _product.price;
}

@end
