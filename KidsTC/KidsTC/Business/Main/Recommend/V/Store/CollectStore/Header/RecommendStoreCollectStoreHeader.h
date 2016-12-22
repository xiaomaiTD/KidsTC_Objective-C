//
//  RecommendStoreCollectStoreHeader.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendStore.h"

typedef enum : NSUInteger {
    RecommendStoreCollectStoreHeaderActionTypeSegue = 1,
    RecommendStoreCollectStoreHeaderActionTypeCollect,
} RecommendStoreCollectStoreHeaderActionType;

@class RecommendStoreCollectStoreHeader;
@protocol RecommendStoreCollectStoreHeaderDelegate <NSObject>
- (void)recommendStoreCollectStoreHeader:(RecommendStoreCollectStoreHeader *)header actionType:(RecommendStoreCollectStoreHeaderActionType)type value:(id)value;
@end

@interface RecommendStoreCollectStoreHeader : UITableViewHeaderFooterView
@property (nonatomic, strong) RecommendStore *store;
@property (nonatomic, weak) id<RecommendStoreCollectStoreHeaderDelegate> delegate;
@end
