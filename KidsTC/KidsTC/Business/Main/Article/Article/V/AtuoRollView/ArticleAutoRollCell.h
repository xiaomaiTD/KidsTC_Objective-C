//
//  AutoRollCell.h
//  AutoRollViewController
//
//  Created by 平 on 15/12/12.
//  Copyright © 2015年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "ArticleModel.h"
@interface ArticleAutoRollCell : UICollectionViewCell
@property (nonatomic, assign) BOOL isBannerHaveInset; //Banner是否有内边距
@property (weak, nonatomic) UIImageView *iconImageView;
@property (nonatomic,strong)AHBannersItem *bannerItem;
@end
