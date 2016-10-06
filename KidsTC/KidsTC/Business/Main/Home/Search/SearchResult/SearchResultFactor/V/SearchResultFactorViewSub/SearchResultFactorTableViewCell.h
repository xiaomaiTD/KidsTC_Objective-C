//
//  SearchResultFactorTableViewCell.h
//  KidsTC
//
//  Created by zhanping on 6/29/16.
//  Copyright © 2016 KidsTC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResultFactorShowModel.h"
@interface SearchResultFactorTableViewCell : UITableViewCell
@property (nonatomic, strong) SearchResultFactorItem *item;
@property (weak, nonatomic) IBOutlet UIImageView *accessoryImageView;
@property (weak, nonatomic) IBOutlet UIImageView *leftTip;
@property (weak, nonatomic) IBOutlet UIImageView *rightTip;

- (void)setSelfDefineSelected:(BOOL)selected animated:(BOOL)animated;
@end
