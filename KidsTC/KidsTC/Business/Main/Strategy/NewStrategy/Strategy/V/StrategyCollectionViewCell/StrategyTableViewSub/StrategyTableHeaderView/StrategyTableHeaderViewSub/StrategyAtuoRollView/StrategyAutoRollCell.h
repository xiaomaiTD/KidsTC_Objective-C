//
//  AutoRollCell.h
//  AutoRollViewController
//
//  Created by 平 on 15/12/12.
//  Copyright © 2015年 ping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StrategyModel.h"
@interface StrategyAutoRollCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (nonatomic, strong) StrategyTypeListBannerItem *item;
@end
