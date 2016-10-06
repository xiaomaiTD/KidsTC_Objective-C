//
//  UserCenterBannerCell.m
//  KidsTC
//
//  Created by 詹平 on 16/7/27.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "UserCenterBannerCell.h"
#import "UserCenterBannerAutoRollView.h"

@interface UserCenterBannerCell ()<AutoRollViewDelegate>
@property (nonatomic, strong) UserCenterBannerAutoRollView *autoRollView;
@end

@implementation UserCenterBannerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.autoRollView = [[UserCenterBannerAutoRollView alloc]init];
    self.autoRollView.delegate = self;
    [self addSubview:self.autoRollView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.autoRollView.frame = self.bounds;
}

- (void)setModel:(UserCenterModel *)model{
    [super setModel:model];
    self.autoRollView.items = model.data.config.banners;
}

#pragma mark - AutoRollViewDelegate

-(void)didSelectPageAtIndex:(NSUInteger)index{
    if ([self.delegate respondsToSelector:@selector(userCenterCell:actionType:addIndex:)]) {
        [self.delegate userCenterCell:self actionType:UserCenterCellActionTypeBanners addIndex:index];
    }
}

@end
