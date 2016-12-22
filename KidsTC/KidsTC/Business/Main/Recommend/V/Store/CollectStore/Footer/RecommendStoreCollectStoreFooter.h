//
//  RecommendStoreCollectStoreFooter.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendStore.h"

typedef enum : NSUInteger {
    RecommendStoreCollectStoreFooterActionTypeSegue = 1,
} RecommendStoreCollectStoreFooterActionType;

@class RecommendStoreCollectStoreFooter;
@protocol RecommendStoreCollectStoreFooterDelegate <NSObject>
- (void)recommendStoreCollectStoreFooter:(RecommendStoreCollectStoreFooter *)footer actionType:(RecommendStoreCollectStoreFooterActionType)type value:(id)value;
@end

@interface RecommendStoreCollectStoreFooter : UITableViewHeaderFooterView
@property (nonatomic, strong) RecommendStore *store;
@property (nonatomic, weak) id<RecommendStoreCollectStoreFooterDelegate> delegate;
@end
