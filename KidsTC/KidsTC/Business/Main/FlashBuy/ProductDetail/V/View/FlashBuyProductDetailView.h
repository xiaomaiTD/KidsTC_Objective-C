//
//  FlashBuyProductDetailView.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/22.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlashBuyProductDetailData.h"

typedef enum : NSUInteger {
    FlashBuyProductDetailViewActionTypeSegue = 1,
    FlashBuyProductDetailViewActionTypeAddress,
    FlashBuyProductDetailViewActionTypeRule,
    FlashBuyProductDetailViewActionTypeChangeShowType,
    FlashBuyProductDetailViewActionTypeComment,
    FlashBuyProductDetailViewActionTypeMoreComment,
    FlashBuyProductDetailViewActionTypeWebLoadFinish,
    
    FlashBuyProductDetailViewActionTypeInvite = 100,
    FlashBuyProductDetailViewActionTypeOriginalPriceBuy,
    FlashBuyProductDetailViewActionTypeStatus,
    FlashBuyProductDetailViewActionTypeCountDownOver
    
} FlashBuyProductDetailViewActionType;

@class FlashBuyProductDetailView;
@protocol FlashBuyProductDetailViewDelegate <NSObject>
- (void)flashBuyProductDetailView:(FlashBuyProductDetailView *)view actionType:(FlashBuyProductDetailViewActionType)type value:(id)value;
@end

@interface FlashBuyProductDetailView : UIView
@property (nonatomic, strong) FlashBuyProductDetailData *data;
@property (nonatomic, weak) id<FlashBuyProductDetailViewDelegate> delegate;
@end
