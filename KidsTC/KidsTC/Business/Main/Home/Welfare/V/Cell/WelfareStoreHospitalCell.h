//
//  WelfareStoreHospitalCell.h
//  KidsTC
//
//  Created by zhanping on 7/22/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WelfareStoreModel.h"

typedef enum : NSUInteger {
    WelfareStoreHospitalCellActionTypePhone,
    WelfareStoreHospitalCellActionTypeGoto,
    WelfareStoreHospitalCellActionTypeNearby,
} WelfareStoreHospitalCellActionType;
@class WelfareStoreHospitalCell;
@protocol WelfareStoreHospitalCellDelegate <NSObject>
- (void)welfareStoreHospitalCell:(WelfareStoreHospitalCell *)cell actionType:(WelfareStoreHospitalCellActionType)type;
@end

@interface WelfareStoreHospitalCell : UITableViewCell
@property (nonatomic, strong) WelfareStoreItem *item;
@property (nonatomic, weak) id<WelfareStoreHospitalCellDelegate> delegate;
@end
