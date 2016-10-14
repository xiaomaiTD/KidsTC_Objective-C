//
//  TCHomeCollectionViewCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Category.h"



@interface TCHomeNewsBar : UIView

@end

@implementation TCHomeNewsBar

@end


@interface TCHomeCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@end

@implementation TCHomeCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *imageView = [UIImageView new];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [self addSubview:imageView];
        self.imageView = imageView;
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.numberOfLines = 2;
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *priceLabel = [UILabel new];
        [self addSubview:priceLabel];
        self.priceLabel = priceLabel;
        
        UILabel *subTitleLabel = [UILabel new];
        [self addSubview:subTitleLabel];
        self.subTitleLabel = subTitleLabel;
        
        UILabel *statusLabel = [UILabel new];
        [self addSubview:statusLabel];
        self.statusLabel = statusLabel;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupSubViews];
}

- (void)setupSubViews {
    TCHomeContentLayoutAttributes att = _content.layoutAttributes;
    self.imageView.frame = att.imgFrame;
    self.titleLabel.frame = att.titleFrame;
    self.priceLabel.frame = att.priceFrame;
    self.subTitleLabel.frame = att.subTitleFrame;
    self.statusLabel.frame = att.statusFrame;
}

- (void)setContent:(TCHomeFloorContent *)content {
    _content = content;
    [self setupSubViews];
    self.titleLabel.attributedText = content.attTitle;
    self.priceLabel.attributedText = content.attPrice;
    self.subTitleLabel.attributedText = content.attSubTitle;
    self.statusLabel.attributedText = content.attStatus;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:content.imageUrl] placeholderImage:PLACEHOLDERIMAGE_SMALL];
    
}

@end
