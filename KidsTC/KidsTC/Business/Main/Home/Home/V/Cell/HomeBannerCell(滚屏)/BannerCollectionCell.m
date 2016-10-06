//
//  BannerCollectionCell.m
//  KidsTC
//
//  Created by 潘灵 on 16/7/29.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "BannerCollectionCell.h"
#import "UIIMageView+WebCache.h"
#import "Masonry.h"
#import "HomeDataManager.h"

@interface BannerCollectionCell ()
@property (strong, nonatomic) UIImageView *iv_topic;
@end

@implementation BannerCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}


-(void)setUI{
    
    [self.contentView addSubview:self.iv_topic];
    self.backgroundColor = [UIColor whiteColor];
    
    [self.iv_topic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
}

- (void)setFloorItem:(HomeFloorsItem *)floorItem{
    _floorItem = floorItem;
    HomeItemContentItem *contentItem = floorItem.contents[self.tag];
    [self.iv_topic sd_setImageWithURL:[NSURL URLWithString:contentItem.imageUrl]];
       
}


- (UIImageView *)iv_topic{
    if (!_iv_topic) {
        _iv_topic = [[UIImageView alloc] init];
    }
    return _iv_topic;
}
@end
