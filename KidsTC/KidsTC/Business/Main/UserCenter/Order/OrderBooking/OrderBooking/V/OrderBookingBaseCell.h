//
//  OrderBookingBaseCell.h
//  KidsTC
//
//  Created by zhanping on 2016/9/19.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderBookingModel.h"

typedef enum : NSUInteger {
    OrderBookingBaseCellActionTypeServiceInfo=1,
    OrderBookingBaseCellActionTypeStoreInfo,
    OrderBookingBaseCellActionTypeSelectTime,
    OrderBookingBaseCellActionTypeSelectAge,
    OrderBookingBaseCellActionTypeMakeSure,
} OrderBookingBaseCellActionType;

@class OrderBookingBaseCell;
@protocol OrderBookingBaseCellDelegate <NSObject>
- (void)orderBookingBaseCell:(OrderBookingBaseCell *)cell actionType:(OrderBookingBaseCellActionType)type value:(id)value;
@end

@interface OrderBookingBaseCell : UITableViewCell
@property (nonatomic, strong) OrderBookingData *data;
@property (nonatomic, assign) BOOL mustEdit;
@property (nonatomic, weak) id<OrderBookingBaseCellDelegate> delegate;
@end
