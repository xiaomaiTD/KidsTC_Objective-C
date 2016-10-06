//
//  ServiceOrderDetailBaseCell.h
//  KidsTC
//
//  Created by zhanping on 8/15/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceOrderDetailModel.h"

typedef enum : NSUInteger {
    ServiceOrderDetailBaseCellActionTypeServiceDetail=1,
    ServiceOrderDetailBaseCellActionTypeOrderDetail,
    ServiceOrderDetailBaseCellActionTypeContact,
    ServiceOrderDetailBaseCellActionTypeBooking,
    ServiceOrderDetailBaseCellActionTypeBookingMustEdit,
    ServiceOrderDetailBaseCellActionTypeReload
} ServiceOrderDetailBaseCellActionType;

@class ServiceOrderDetailBaseCell;
@protocol ServiceOrderDetailBaseCellDelegate <NSObject>
- (void)serviceOrderDetailBaseCell:(ServiceOrderDetailBaseCell *)cell actionType:(ServiceOrderDetailBaseCellActionType)type;
@end

@interface ServiceOrderDetailBaseCell : UITableViewCell
@property (nonatomic, weak) ServiceOrderDetailData *data;
@property (nonatomic, weak) id<ServiceOrderDetailBaseCellDelegate> delegate;
@end
