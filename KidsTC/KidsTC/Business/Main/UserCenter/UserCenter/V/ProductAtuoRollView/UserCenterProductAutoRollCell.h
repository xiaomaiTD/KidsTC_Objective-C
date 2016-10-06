//
//  AutoRollCell.h
//  AutoRollViewController
//
//  Created by 平 on 15/12/12.
//  Copyright © 2015年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserCenterModel.h"

@class UserCenterProductAutoRollCell;
@protocol UserCenterProductAutoRollCellDelegate <NSObject>
- (void)userCenterProductAutoRollCell:(UserCenterProductAutoRollCell *)cell actionIndex:(NSUInteger)index;
@end

@interface UserCenterProductAutoRollCell : UICollectionViewCell
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *itemViews;

@property (weak, nonatomic) IBOutlet UIImageView *productImageViewOne;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabelOne;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageViewOne;
@property (weak, nonatomic) IBOutlet UILabel *priceLabelOne;
@property (weak, nonatomic) IBOutlet UILabel *saleNumLabelOne;

@property (weak, nonatomic) IBOutlet UIImageView *productImageViewTwo;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabelTwo;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageViewTwo;
@property (weak, nonatomic) IBOutlet UILabel *priceLabelTwo;
@property (weak, nonatomic) IBOutlet UILabel *saleNumLabelTwo;

@property (weak, nonatomic) IBOutlet UIImageView *productImageViewThree;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabelThree;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageViewThree;
@property (weak, nonatomic) IBOutlet UILabel *priceLabelThree;
@property (weak, nonatomic) IBOutlet UILabel *saleNumLabelThree;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconImageViewWidthOne;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconImageViewWidthTwo;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconImageViewWidthThree;

@property (nonatomic, assign) UserCenterHotProductType productType;

@property (nonatomic, strong) NSArray<UserCenterProductLsItem *> *items;//商品类型

@property (nonatomic, weak) id<UserCenterProductAutoRollCellDelegate> delegate;

@end
