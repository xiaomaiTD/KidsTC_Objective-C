//
//  ZpMenuItemCell.h
//  ZpMenuController
//
//  Created by zhanping on 3/16/16.
//  Copyright © 2016 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZPPopoverItem.h"
@interface ZPPopoverCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *separatorImageView;
@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemTitleLabel;

@property (nonatomic, strong) ZPPopoverItem *item;
@end
