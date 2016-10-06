//
//  HorizontalCollectionCell.m
//  KidsTC
//
//  Created by ling on 16/7/22.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "HorizontalCollectionCell.h"
#import "RichPriceView.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"
#import "Macro.h"
@interface HorizontalCollectionCell ()

@property (nonatomic, strong) UIImageView *iv_icon;
@property (nonatomic, strong) RichPriceView *priceView;

@end
@implementation HorizontalCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    self.contentView.backgroundColor = COLOR_BG_CEll;
    [self.contentView addSubview:self.iv_icon];
    [self.contentView addSubview:self.priceView];
    self.backgroundColor = [UIColor whiteColor];
    
    [self.priceView setContentColor:COLOR_PINK];
    [self.priceView setUnitFont:[UIFont systemFontOfSize:12]];
    [self.priceView setPriceFont:[UIFont systemFontOfSize:16]];
    
    [self.iv_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.height.width.equalTo(@80);
        make.top.equalTo(self).offset(10);
        make.bottom.equalTo(self.priceView.mas_top).offset(-10);
    }];
    [self.priceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.equalTo(@30);
        make.height.equalTo(@20);
    }];
}

#pragma mark-
#pragma mark 赋值
-(void)setContentItem:(HomeItemContentItem *)contentItem{
    _contentItem = contentItem;
    [_iv_icon sd_setImageWithURL:[NSURL URLWithString:contentItem.imageUrl] placeholderImage:PLACEHOLDERIMAGE_SMALL];
    [_priceView setPrice:contentItem.price.floatValue];
}

#pragma mark-
#pragma mark lzy
-(UIImageView *)iv_icon{
    if (!_iv_icon) {
        _iv_icon = [[UIImageView alloc] init];
    }
    return _iv_icon;
}
-(RichPriceView *)priceView{
    if (!_priceView) {
        _priceView = [[RichPriceView alloc] init];
    }
    return _priceView;
}
@end
