//
//  CollectProductCategoryCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectProductCategoryItem.h"

typedef enum : NSUInteger {
    CollectProductCategoryCellActionTypeSegue = 1,
} CollectProductCategoryCellActionType;

@class CollectProductCategoryCell;
@protocol CollectProductCategoryCellDelegate <NSObject>
- (void)collectProductCategoryCell:(CollectProductCategoryCell *)cell actionType:(CollectProductCategoryCellActionType)type value:(id)value;
@end

@interface CollectProductCategoryCell : UITableViewCell
@property (nonatomic, strong) CollectProductCategoryItem *item;
@property (nonatomic, weak) id<CollectProductCategoryCellDelegate> delegate;
@end
