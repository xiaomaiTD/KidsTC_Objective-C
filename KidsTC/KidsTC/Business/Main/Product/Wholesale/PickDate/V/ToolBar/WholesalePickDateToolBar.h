//
//  WholesalePickDateToolBar.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/18.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WholesalePickDateSKU.h"
typedef enum : NSUInteger {
    WholesalePickDateToolBarActionTypeBuy = 100,
    WholesalePickDateToolBarActionTypeMakeSure,
} WholesalePickDateToolBarActionType;

@class WholesalePickDateToolBar;
@protocol WholesalePickDateToolBarDelegate <NSObject>
- (void)wholesalePickDateToolBar:(WholesalePickDateToolBar *)toolBar actionType:(WholesalePickDateToolBarActionType)type value:(id)value;
@end

@interface WholesalePickDateToolBar : UIView
@property (nonatomic, assign) WholesalePickDateSKUBtnType type;
@property (nonatomic, strong) WholesalePickDateTime *time;
@property (nonatomic, weak) id<WholesalePickDateToolBarDelegate> delegate;
@end
