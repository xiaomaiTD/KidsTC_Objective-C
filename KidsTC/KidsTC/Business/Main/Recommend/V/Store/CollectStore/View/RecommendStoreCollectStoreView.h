//
//  RecommendStoreCollectStoreView.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/21.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendStore.h"

typedef enum : NSUInteger {
    RecommendStoreCollectStoreViewActionTypeSegue = 1,
    RecommendStoreCollectStoreViewActionTypeCollect,
} RecommendStoreCollectStoreViewActionType;

@class RecommendStoreCollectStoreView;
@protocol RecommendStoreCollectStoreViewDelegate <NSObject>
- (void)recommendStoreCollectStoreView:(RecommendStoreCollectStoreView *)view actionType:(RecommendStoreCollectStoreViewActionType)type value:(id)value;
@end

@interface RecommendStoreCollectStoreView : UIView
@property (nonatomic, strong) NSArray<RecommendStore *> *stores;
@property (nonatomic, weak) id<RecommendStoreCollectStoreViewDelegate> delegate;
- (void)reloadData;
- (CGFloat)contentHeight;
- (void)nilData;
@end
