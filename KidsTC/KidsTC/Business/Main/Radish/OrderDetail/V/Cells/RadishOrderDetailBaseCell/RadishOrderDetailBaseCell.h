//
//  RadishOrderDetailBaseCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadishOrderDetailData.h"

typedef enum : NSUInteger {
    
    RadishOrderDetailBaseCellActionTypeSegue = 50,//通用跳转
    RadishOrderDetailBaseCellActionTypeDeliberCall,//订单电话
    RadishOrderDetailBaseCellActionTypeBooking,//我要预约
    RadishOrderDetailBaseCellActionTypeBookingMustEdit,//我要预约，编辑
    RadishOrderDetailBaseCellActionTypeContact,//联系商家
} RadishOrderDetailBaseCellActionType;

@class RadishOrderDetailBaseCell;
@protocol RadishOrderDetailBaseCellDelegate <NSObject>
- (void)radishOrderDetailBaseCell:(RadishOrderDetailBaseCell *)cell actionType:(RadishOrderDetailBaseCellActionType)type value:(id)value;
@end

@interface RadishOrderDetailBaseCell : UITableViewCell
@property (nonatomic, weak) RadishOrderDetailData *data;
@property (nonatomic, weak) id<RadishOrderDetailBaseCellDelegate> delegate;
@end
