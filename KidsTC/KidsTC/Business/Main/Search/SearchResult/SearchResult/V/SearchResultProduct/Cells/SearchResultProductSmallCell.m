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

@property (weak, nonatomic) IBOutlet UIView *serviceAndActivityBGView;
@property (weak, nonatomic) IBOutlet UIImageView *addressTipIcon;
@property (weak, nonatomic) IBOutlet UILabel *addressL;
@property (weak, nonatomic) IBOutlet UILabel *distanceL;

@property (weak, nonatomic) IBOutlet UIView *materialObjectBGView;
@property (weak, nonatomic) IBOutlet UILabel *commentNumL;
@property (weak, nonatomic) IBOutlet UILabel *commentPercentL;

@property (weak, nonatomic) IBOutlet UILabel *priceL;
@property (weak, nonatomic) IBOutlet UILabel *cityL;
@property (weak, nonatomic) IBOutlet UILabel *freeTransport;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineH;

@property (weak, nonatomic) IBOutlet UILabel *statusL;
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
    self.freeTransport.layer.cornerRadius = 2;
    self.freeTransport.layer.masksToBounds = YES;
    
    self.statusL.layer.cornerRadius = 4;
    self.statusL.layer.masksToBounds = YES;
}

- (void)setProduct:(SearchResultProduct *)product {
    if (![product isKindOfClass:[SearchResultProduct class]]) return;
    _product = product;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:_product.imgurl] placeholderImage:PLACEHOLDERIMAGE_BIG_LOG];
    self.nameL.text = _product.name;
    _starsView.starNumber = _product.level;
    _numL.text = _product.num;
    _numTipL.text = _product.joinText;
    _addressL.text = _product.address;
    _distanceL.text = _product.distance;
    _priceL.text = _product.price;
    
    switch (_product.productType) {
        case SearchResultProductTypeMaterialObject:
        {
            self.materialObjectBGView.hidden = NO;
            self.serviceAndActivityBGView.hidden = YES;
            self.cityL.hidden = NO;
            self.freeTransport.hidden = !_product.isFreeShipping;
            self.commentNumL.text = [NSString stringWithFormat:@"%@条评论",_product.commentNum];
            self.commentPercentL.text = [NSString stringWithFormat:@"%@%%好评",_product.goodCommentPercent];
            self.cityL.text = _product.freeShippingRange;
        }
            break;
            
        default:
        {
            self.materialObjectBGView.hidden = YES;
            self.serviceAndActivityBGView.hidden = NO;
            self.cityL.hidden = YES;
            self.freeTransport.hidden = YES;
        }
            break;
    }

    switch (_product.status) {
        case SearchResultProductStatusUnder://已下架
        {
            self.statusL.text = @"已下架";
            self.statusL.hidden = NO;
        }
            break;
        case SearchResultProductStatusSlodOut://已售罄
        {
            self.statusL.text = @"已售罄";
            self.statusL.hidden = NO;
        }
            break;
        case SearchResultProductStatusNoStore://没有门店-暂不销售
        case SearchResultProductStatusFinished://已经结束-暂不销售
        {
            self.statusL.text = @"暂不销售";
            self.statusL.hidden = NO;
        }
            break;
        default:
        {
            self.statusL.hidden = YES;
        }
            break;
    }
}

@end
