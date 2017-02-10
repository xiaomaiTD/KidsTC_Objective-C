//
//  StoreDetailAppointmentBaseCell.h
//  KidsTC
//
//  Created by zhanping on 8/21/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoreDetailModel.h"

typedef enum : NSUInteger {
    StoreDetailAppointmentBaseCellActionTypeMakeAppointment=1,
} StoreDetailAppointmentBaseCellActionType;

@class StoreDetailAppointmentBaseCell;
@protocol StoreDetailAppointmentBaseCellDelegate <NSObject>
- (void)storeDetailAppointmentBaseCell:(StoreDetailAppointmentBaseCell *)cell actionType:(StoreDetailAppointmentBaseCellActionType)type value:(id)value;
@end

@interface StoreDetailAppointmentBaseCell : UITableViewCell
@property (nonatomic, strong) NSArray<ActivityLogoItem *> *activeModelsArray;
@property (nonatomic, assign) id<StoreDetailAppointmentBaseCellDelegate> delegate;
@end
