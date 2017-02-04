//
//  FlashBuyProductDetailNaviRightView.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/23.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    FlashBuyProductDetailNaviRightViewActionTyepContact = 1,
    FlashBuyProductDetailNaviRightViewActionTyepMore,
} FlashBuyProductDetailNaviRightViewActionTyep;

@class FlashBuyProductDetailNaviRightView;
@protocol FlashBuyProductDetailNaviRightViewDelegate <NSObject>
- (void)flashBuyProductDetailNaviRightView:(FlashBuyProductDetailNaviRightView *)view actionType:(FlashBuyProductDetailNaviRightViewActionTyep)type value:(id)value;
@end

@interface FlashBuyProductDetailNaviRightView : UIView
@property (nonatomic, weak) id<FlashBuyProductDetailNaviRightViewDelegate> delegate;
@end
