//
//  TCHomeRecommendTableViewCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/10/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCHomeRecommendTableViewCell.h"

@interface TCHomeRecommendTableViewCell ()
@property (nonatomic, strong) UIImageView *contentImageView;
@property (nonatomic, strong) UIImageView *tipImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UILabel *statusLabel;
@end

@implementation TCHomeRecommendTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIImageView *contentImageView = [UIImageView new];
        [self addSubview:contentImageView];
        self.contentImageView = contentImageView;
        
        UIImageView *tipImageView = [UIImageView new];
        [self addSubview:tipImageView];
        self.tipImageView = tipImageView;
        
        UILabel *titleLabel = [UILabel new];
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



@end
