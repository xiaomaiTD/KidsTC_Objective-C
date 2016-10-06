
//
//  HomeCollectionCell.m
//  KidsTC
//
//  Created by ling on 16/7/21.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "HomeCollectionCell.h"
#import "Masonry.h"
#import "UILabel+Additions.h"
#import "UIImageView+Webcache.h"
#import "UIImage+Category.h"
@interface HomeCollectionCell ()

@property (nonatomic, strong) UIImageView *iv_icon;
@property (nonatomic, strong) UILabel *lb_title;

@end

@implementation HomeCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        [self setUI];
    }
    return self;
}


-(void)setUI{
    
    [self.contentView addSubview:self.iv_icon];
    [self.contentView addSubview:self.lb_title];
    
    [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self);
        make.height.equalTo(@20);
    }];
    
    [self.iv_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.lb_title.mas_top).offset(-12);
        make.left.equalTo(self).offset(18.5);
        make.right.equalTo(self).offset(-18.5);//左右缩进比上下多5即可
        make.top.equalTo(self).offset(20);
    }];
}


#pragma mark-
#pragma mark 赋值
-(void)setContentItem:(HomeItemContentItem *)contentItem{
    _contentItem = contentItem;
    [_iv_icon sd_setImageWithURL:[NSURL URLWithString:contentItem.imageUrl] placeholderImage:PLACEHOLDERIMAGE_SMALL];
    _lb_title.text = contentItem.title;
    
}
#pragma mark-
#pragma mark lzy
-(UIImageView *)iv_icon{
    
    if(!_iv_icon){
        _iv_icon = [[UIImageView alloc] init];
        _iv_icon.contentMode = UIViewContentModeScaleAspectFit;
        _iv_icon.clipsToBounds = YES;
    }
    return _iv_icon;
}
-(UILabel *)lb_title{
    if (!_lb_title) {
        _lb_title = [[UILabel alloc] initWithTitle:@"天天特价" FontSize:13 FontColor:[UIColor darkGrayColor]];
        _lb_title.textAlignment = NSTextAlignmentCenter;
    }
    return _lb_title;
}
@end
