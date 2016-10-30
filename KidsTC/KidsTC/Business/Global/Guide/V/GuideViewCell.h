//
//  GuideViewCell.h
//  KidsTC
//
//  Created by 詹平 on 16/7/26.
//  Copyright © 2016年 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuideModel.h"

@interface GuideViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (nonatomic, strong) GuideDataItem *item;
@end
