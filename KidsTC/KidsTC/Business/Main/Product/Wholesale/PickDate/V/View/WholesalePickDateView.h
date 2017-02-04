//
//  WholesalePickDateView.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/18.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WholesalePickDateSKU.h"

typedef enum : NSUInteger {
    WholesalePickDateViewActionTypeTouchBegin = 1,
    WholesalePickDateViewActionTypeBuy = 100,
    WholesalePickDateViewActionTypeMakeSure,
} WholesalePickDateViewActionType;

@class WholesalePickDateView;
@protocol WholesalePickDateViewDelegate <NSObject>
- (void)wholesalePickDateView:(WholesalePickDateView *)view actionType:(WholesalePickDateViewActionType)type value:(id)value;
@end

@interface WholesalePickDateView : UIView
@property (nonatomic, strong) WholesalePickDateSKU *sku;
@property (nonatomic, weak) id<WholesalePickDateViewDelegate> delegate;
- (void)show;
- (void)hide:(void(^)(BOOL finish))completionBlock;
@end
