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
#import "YYKit.h"


@interface TCHomeNewsBar : UIView

@end

@implementation TCHomeNewsBar

@end


@interface TCHomeCollectionViewCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *tipImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) YYLabel *subTitleLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIView *line;
@end

@implementation TCHomeCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        //self.backgroundColor = [UIColor greenColor];
        
        UIImageView *imageView = [UIImageView new];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [self addSubview:imageView];
        self.imageView = imageView;
        
        UIImageView *tipImageView = [UIImageView new];
        [self addSubview:tipImageView];
        tipImageView.clipsToBounds = YES;
        self.tipImageView = tipImageView;
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.numberOfLines = 0;
        //titleLabel.backgroundColor = [UIColor redColor];
        titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *priceLabel = [UILabel new];
        //priceLabel.backgroundColor = [UIColor greenColor];
        [self addSubview:priceLabel];
        self.priceLabel = priceLabel;
        
        YYLabel *subTitleLabel = [YYLabel new];
        //subTitleLabel.backgroundColor = [UIColor blueColor];
        [self addSubview:subTitleLabel];
        self.subTitleLabel = subTitleLabel;
        
        UILabel *statusLabel = [UILabel new];
        //statusLabel.backgroundColor = [UIColor redColor];
        [self addSubview:statusLabel];
        self.statusLabel = statusLabel;
        
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        line.hidden = YES;
        [self addSubview:line];
        self.line = line;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self setupSubViews];
}

- (void)setupSubViews {
    
    TCHomeContentLayoutAttributes att = _content.layoutAttributes;
    
    _imageView.hidden = !att.showImg;
    if (!_imageView.hidden) {
        _imageView.frame = att.imgFrame;
    }
    
    _tipImageView.hidden = !att.showTipImg;
    if (!_tipImageView.hidden) {
        _tipImageView.frame = att.tipImgFrame;
        _tipImageView.image = [UIImage imageNamed:_content.tipImgName];
    }
    
    _titleLabel.hidden = !att.showTitle;
    if (!_titleLabel.hidden) {
        _titleLabel.frame = att.titleFrame;
    }
    
    _priceLabel.hidden = !att.showPrice;
    if (!_priceLabel.hidden) {
        _priceLabel.frame = att.priceFrame;
    }
    
    _subTitleLabel.hidden = !att.showSubTitle;
    if (!_subTitleLabel.hidden) {
        _subTitleLabel.frame = att.subTitleFrame;
    }
    
    _statusLabel.hidden = !att.showStatus;
    if (!_statusLabel.hidden) {
        _statusLabel.frame = att.statusFrame;
    }
    
    _line.hidden = !_content.hasLine;
    if (!_line.hidden) {
        _line.frame = CGRectMake(0, CGRectGetHeight(self.bounds) - LINE_H, CGRectGetWidth(self.bounds), LINE_H);
    }
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
