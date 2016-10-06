//
//  CategoryItemCell.h
//  KidsTC
//
//  Created by zhanping on 3/17/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryModel.h"

@interface CategoryItemCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) CategoryListItem *item;
@end
