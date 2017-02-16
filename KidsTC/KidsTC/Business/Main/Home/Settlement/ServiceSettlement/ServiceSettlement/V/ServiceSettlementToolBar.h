//
//  ServiceSettlementToolBar.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/21.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceSettlementDataItem.h"

extern CGFloat const kServiceSettlementToolBarH;

typedef enum : NSUInteger {
    ServiceSettlementToolBarActionTypeCommit = 1,//提交订单
} ServiceSettlementToolBarActionType;

@class ServiceSettlementToolBar;
@protocol ServiceSettlementToolBarDelegate <NSObject>
- (void)serviceSettlementToolBar:(ServiceSettlementToolBar *)toolBar actionType:(ServiceSettlementToolBarActionType)type value:(id)value;
@end

@interface ServiceSettlementToolBar : UIView
@property (nonatomic, weak) id<ServiceSettlementToolBarDelegate> delegate;
@property (nonatomic, strong) ServiceSettlementDataItem *item;
- (void)setAddressBGViewHide:(BOOL)hide;
@end
