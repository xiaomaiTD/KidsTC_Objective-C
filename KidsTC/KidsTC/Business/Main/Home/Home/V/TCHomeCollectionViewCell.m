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

@interface TCHomeCollectionViewCell ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *tipImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *storeAddressLabel;
@property (nonatomic, strong) UILabel *saleNumLabel;
@property (nonatomic, strong) UIImageView *subImageView;
@property (nonatomic, strong) YYLabel *subTitleLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UIView *line;
@end

@implementation TCHomeCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        //self.backgroundColor = [UIColor whiteColor];
        
        UIImageView *imageView = [UIImageView new];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        [self addSubview:imageView];
        self.imageView = imageView;
        
        UIImageView *tipImageView = [UIImageView new];
        [self addSubview:tipImageView];
        tipImageView.clipsToBounds = YES;
        self.tipImageView = tipImageView;
        
        UILabel *priceLabel = [UILabel new];
        //priceLabel.backgroundColor = [UIColor greenColor];
        [self addSubview:priceLabel];
        self.priceLabel = priceLabel;
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.numberOfLines = 0;
        //titleLabel.backgroundColor = [UIColor redColor];
        titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
        
        UILabel *saleNumLabel = [UILabel new];
        //saleNumLabel.backgroundColor = [UIColor redColor];
        [self addSubview:saleNumLabel];
        self.saleNumLabel = saleNumLabel;
        
        UIImageView *subImageView = [UIImageView new];
        subImageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:subImageView];
        //subImageView.backgroundColor = [UIColor redColor];
        self.subImageView = subImageView;
        
        YYLabel *subTitleLabel = [YYLabel new];
        //subTitleLabel.backgroundColor = [UIColor blueColor];
        [self addSubview:subTitleLabel];
        self.subTitleLabel = subTitleLabel;
        
        UILabel *statusLabel = [UILabel new];
        //statusLabel.backgroundColor = [UIColor redColor];
        [self addSubview:statusLabel];
        self.statusLabel = statusLabel;
        
        UILabel *storeAddressLabel = [UILabel new];
        //storeAddressLabel.backgroundColor = [UIColor purpleColor];
        [self addSubview:storeAddressLabel];
        self.storeAddressLabel = storeAddressLabel;
        
        UIView *line = [UIView new];
        line.backgroundColor = [UIColor groupTableViewBackgroundColor];
        line.hidden = YES;
        [self addSubview:line];
        self.line = line;
    }
    return self;
}


- (void)setupSubViews {
    
    TCHomeContentLayoutAttributes att = _content.layoutAttributes;
    
    _imageView.hidden = !att.showImg;
    if (!_imageView.hidden) {
        _imageView.frame = att.imgFrame;
        [_imageView sd_setImageWithURL:[NSURL URLWithString:_content.imageUrl] placeholderImage:PLACEHOLDERIMAGE_SMALL];
    }
    
    _tipImageView.hidden = !att.showTipImg;
    if (!_tipImageView.hidden) {
        _tipImageView.frame = att.tipImgFrame;
        _tipImageView.image = [UIImage imageNamed:_content.tipImgName];
    }
    
    _priceLabel.hidden = !att.showPrice;
    if (!_priceLabel.hidden) {
        _priceLabel.frame = att.priceFrame;
        _priceLabel.attributedText = _content.attPrice;
    }
    
    _titleLabel.hidden = !att.showTitle;
    if (!_titleLabel.hidden) {
        _titleLabel.frame = att.titleFrame;
        _titleLabel.attributedText = _content.attTitle;
    }
    
    _saleNumLabel.hidden = !att.showSaleNum;
    if (!_saleNumLabel.hidden) {
        _saleNumLabel.frame = att.saleNumFrame;
        _saleNumLabel.attributedText = _content.attSaleNum;
    }
    
    _subImageView.hidden = !att.showSubImg;
    if (!_subImageView.hidden) {
        _subImageView.frame = att.subImgFrame;
        switch (_content.subImgType) {
            case TCHomeFloorContentSubImgTypeLocal:
            {
                _subImageView.image = [UIImage imageNamed:_content.subImgName];
            }
                break;
            case TCHomeFloorContentSubImgTypeUrl:
            {
                [_subImageView sd_setImageWithURL:[NSURL URLWithString:_content.subImgName] placeholderImage:PLACEHOLDERIMAGE_SMALL_LOG];
            }
                break;
            default:
            {
                _subImageView.hidden = YES;
            }
                break;
        }
    }
    
    _subTitleLabel.hidden = !att.showSubTitle;
    if (!_subTitleLabel.hidden) {
        _subTitleLabel.frame = att.subTitleFrame;
        _subTitleLabel.attributedText = _content.attSubTitle;
    }
    
    _statusLabel.hidden = !att.showStatus;
    if (!_statusLabel.hidden) {
        _statusLabel.frame = att.statusFrame;
        _statusLabel.attributedText = _content.attStatus;
    }
    
    _storeAddressLabel.hidden = !att.showStoreAddress;
    if (!_storeAddressLabel.hidden) {
        _storeAddressLabel.frame = att.storeAddressFrme;
        _storeAddressLabel.attributedText = _content.attStoreAddress;
    }
    
    _line.hidden = !att.showLine;
    if (!_line.hidden) {
        _line.frame = att.lineFrame;
    }
    
    switch (_content.type) {
        case TCHomeFloorContentTypeWholeImageNews:
        {
            _titleLabel.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
        }
            break;
            
        default:
        {
            _titleLabel.backgroundColor = [UIColor clearColor];
        }
            break;
    }
}

- (void)setContent:(TCHomeFloorContent *)content {
    _content = content;
    [self setupSubViews];
}

@end
