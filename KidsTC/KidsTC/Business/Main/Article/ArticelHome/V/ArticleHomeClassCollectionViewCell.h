//
//  ArticleHomeClassCollectionViewCell.h
//  KidsTC
//
//  Created by zhanping on 9/5/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArticleHomeModel.h"
@interface ArticleHomeClassCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) ArticleHomeClassItem *item;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end
