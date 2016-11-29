//
//  SearchFactorSortCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchFactorSortDataItem.h"
@interface SearchFactorSortCell : UITableViewCell
@property (nonatomic, strong) SearchFactorSortDataItem *item;
@property (nonatomic, copy) void(^actionBlock)(SearchFactorSortDataItem *item);
@end
