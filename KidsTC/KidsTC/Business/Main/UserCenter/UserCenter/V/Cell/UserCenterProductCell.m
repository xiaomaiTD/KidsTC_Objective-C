//
//  UserCenterProductCell.m
//  KidsTC
//
//  Created by 詹平 on 16/7/27.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import "UserCenterProductCell.h"
#import "UserCenterProductAutoRollView.h"

@interface UserCenterProductCell ()<UserCenterProductAutoRollViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *HLine;
@property (weak, nonatomic) IBOutlet UIView *ProductBGView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *HLineConstraintHeight;
@property (nonatomic, strong) UserCenterProductAutoRollView *autoRollView;
@end

@implementation UserCenterProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.HLineConstraintHeight.constant = LINE_H;
    
    self.autoRollView = [[UserCenterProductAutoRollView alloc]init];
    self.autoRollView.delegate = self;
    [self.ProductBGView addSubview:self.autoRollView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.ProductBGView layoutIfNeeded];
    self.autoRollView.frame = self.ProductBGView.bounds;
}

- (void)setModel:(UserCenterModel *)model{
    [super setModel:model];
    UserCenterHotProduct *hotProduct = model.data.config.hotProduct;
    self.titleLabel.text = hotProduct.tit;
    self.autoRollView.productType = hotProduct.productType;
    self.autoRollView.originalItems = model.data.config.hotProduct.productLs;
}

#pragma mark - UserCenterProductAutoRollViewDelegate
-(void)didSelectPageAtIndex:(NSUInteger)index{
    if ([self.delegate respondsToSelector:@selector(userCenterCell:actionType:addIndex:)]) {
        [self.delegate userCenterCell:self actionType:UserCenterCellActionTypeProduct addIndex:index];
    }
}
@end
