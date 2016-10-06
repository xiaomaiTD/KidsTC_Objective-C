//
//  ServiceOrderDetailPayInfoCell.h
//  KidsTC
//
//  Created by zhanping on 8/15/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ServiceOrderDetailBaseCell.h"

typedef enum : NSUInteger {
    ServiceOrderDetailPayInfoCellTypeTypePrice=1,
    ServiceOrderDetailPayInfoCellTypeTypePromotion,
    ServiceOrderDetailPayInfoCellTypeTypeScore,
    ServiceOrderDetailPayInfoCellTypeTransportationExpenses
} ServiceOrderDetailPayInfoCellType;

@interface ServiceOrderDetailPayInfoCell : ServiceOrderDetailBaseCell
@property (nonatomic, assign) ServiceOrderDetailPayInfoCellType type;
@end
