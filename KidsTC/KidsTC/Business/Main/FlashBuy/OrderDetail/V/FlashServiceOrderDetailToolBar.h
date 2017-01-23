//
//  FlashServiceOrderDetailToolBar.h
//  KidsTC
//
//  Created by zhanping on 8/17/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlashServiceOrderDetailModel.h"

#import "FlashServiceOrderDetailToolBarButton.h"

typedef enum : NSUInteger {
    FlashServiceOrderDetailToolBarActionTypeRefund=1,
    FlashServiceOrderDetailToolBarActionTypeGetCode,
    FlashServiceOrderDetailToolBarActionTypeLinkAction,
} FlashServiceOrderDetailToolBarActionType;

@class FlashServiceOrderDetailToolBar;
@protocol FlashServiceOrderDetailToolBarDelegate <NSObject>
- (void)flashServiceOrderDetailToolBar:(FlashServiceOrderDetailToolBar *)toolBar btn:(FlashServiceOrderDetailToolBarButton *)btn actionType:(FlashServiceOrderDetailToolBarButtonActionType)type value:(id)value;
@end

@interface FlashServiceOrderDetailToolBar : UIView

@property (nonatomic, weak) FlashServiceOrderDetailData *data;
@property (nonatomic, weak) id<FlashServiceOrderDetailToolBarDelegate> delegate;
@end
