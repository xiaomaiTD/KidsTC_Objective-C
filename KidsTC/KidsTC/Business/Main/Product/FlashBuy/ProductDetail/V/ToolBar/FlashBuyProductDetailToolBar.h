//
//  FlashBuyProductDetailToolBar.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/22.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlashBuyProductDetailData.h"

extern CGFloat const kFlashBuyProductDetailToolBarH;

typedef enum : NSUInteger {
    FlashBuyProductDetailToolBarActionTypeInvite = 100,
    FlashBuyProductDetailToolBarActionTypeOriginalPriceBuy,
    FlashBuyProductDetailToolBarActionTypeStatus,
    FlashBuyProductDetailToolBarActionTypeCountDownOver,
} FlashBuyProductDetailToolBarActionType;

@class FlashBuyProductDetailToolBar;
@protocol FlashBuyProductDetailToolBarDelegate <NSObject>
- (void)flashBuyProductDetailToolBar:(FlashBuyProductDetailToolBar *)toolBar actionType:(FlashBuyProductDetailToolBarActionType)type value:(id)value;
@end

@interface FlashBuyProductDetailToolBar : UIView
@property (nonatomic, strong) FlashBuyProductDetailData *data;
@property (nonatomic, weak) id<FlashBuyProductDetailToolBarDelegate> delegate;
@end
