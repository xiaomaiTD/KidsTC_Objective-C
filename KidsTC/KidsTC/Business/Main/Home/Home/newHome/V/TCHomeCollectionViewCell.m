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
        [self addSubview:titleLabel];
        self.titleLabel = titleLabel;
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
}

- (void)setContent:(TCHomeFloorContent *)content {
    _content = content;
    [self setupSubViews];
    self.titleLabel.attributedText = content.attTitle;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:content.imageUrl] placeholderImage:PLACEHOLDERIMAGE_SMALL];
    
}

@end
