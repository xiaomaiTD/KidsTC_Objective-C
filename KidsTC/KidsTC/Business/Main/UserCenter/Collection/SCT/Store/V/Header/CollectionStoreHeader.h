//
//  CollectionStoreHeader.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CollectionStoreItem.h"

typedef enum : NSUInteger {
    CollectionStoreHeaderActionTypeSegue = 1,
    CollectionStoreHeaderActionTypeDelete
} CollectionStoreHeaderActionType;

@class CollectionStoreHeader;

@protocol CollectionStoreHeaderDelegate <NSObject>
- (void)collectionStoreHeader:(CollectionStoreHeader *)header actionType:(CollectionStoreHeaderActionType)type value:(id)value;
@end

@interface CollectionStoreHeader : UITableViewHeaderFooterView
@property (nonatomic, assign) NSInteger section;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (nonatomic, strong) CollectionStoreItem *item;
@property (nonatomic, weak) id<CollectionStoreHeaderDelegate> delegate;
@end
