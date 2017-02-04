//
//  FlashBuyProductDetailSelectStoreView.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/23.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlashBuyProductDetailStore.h"

typedef enum : NSUInteger {
    FlashBuyProductDetailSelectStoreViewActionTypeTouchBegin = 1,
    FlashBuyProductDetailSelectStoreViewActionTypeCommit,
} FlashBuyProductDetailSelectStoreViewActionType;

@class FlashBuyProductDetailSelectStoreView;
@protocol FlashBuyProductDetailSelectStoreViewDelegate <NSObject>
- (void)flashBuyProductDetailSelectStoreView:(FlashBuyProductDetailSelectStoreView *)view actionType:(FlashBuyProductDetailSelectStoreViewActionType)type value:(id)value;
@end

@interface FlashBuyProductDetailSelectStoreView : UIView
@property (nonatomic, strong) NSArray<FlashBuyProductDetailStore *> *stores;
@property (nonatomic, strong) NSString *prepaidPrice;
@property (nonatomic, weak  ) id<FlashBuyProductDetailSelectStoreViewDelegate> delegate;
- (void)show;
- (void)hide:(void(^)(BOOL finish))completionBlock;
@end
