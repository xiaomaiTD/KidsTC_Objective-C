//
//  AccountCenterRecommendsCell.m
//  KidsTC
//
//  Created by 詹平 on 2016/11/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "AccountCenterRecommendsCell.h"
#import "RecommendDataManager.h"

#import "RecommendProductAccountCenterView.h"

@interface AccountCenterRecommendsCell ()<RecommendProductViewDelegate>
@property (nonatomic, strong) RecommendProductAccountCenterView *recommendView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeightH;
@end

@implementation AccountCenterRecommendsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self layoutIfNeeded];
    
    RecommendProductAccountCenterView *recommendView = [[NSBundle mainBundle] loadNibNamed:@"RecommendProductAccountCenterView" owner:self options:nil].firstObject;
    recommendView.delegate = self;
    [self.contentView addSubview:recommendView];
    self.recommendView = recommendView;
    
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.recommendView.frame = self.bounds;
}

- (void)reloadRecommends {
    BOOL hasRecommend = [[RecommendDataManager shareRecommendDataManager] hasRecommendProductsWithType:RecommendProductTypeUserCenter];
    self.hidden = !hasRecommend;
    [self.recommendView reloadData];
    self.contentHeightH.constant = hasRecommend?[self.recommendView contentHeight]:0.001;
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

#pragma mark - RecommendProductViewDelegate

- (void)recommendProductView:(RecommendProductView *)view actionType:(RecommendProductViewActionType)type value:(id)value {
    switch (type) {
        case RecommendProductViewActionTypeSegue:
        {
            if ([self.delegate respondsToSelector:@selector(accountCenterBaseCell:actionType:value:)]) {
                [self.delegate accountCenterBaseCell:self actionType:AccountCenterCellActionTypeSegue value:value];
            }
        }
            break;
        default:
            break;
    }
}

@end
