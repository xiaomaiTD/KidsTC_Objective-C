//
//  RadishOrderDetailPayInfoCell.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "RadishOrderDetailBaseCell.h"

typedef enum : NSUInteger {
    RadishOrderDetailPayInfoCellTypeTypePrice=1,
    RadishOrderDetailPayInfoCellTypeTypePromotion,
    RadishOrderDetailPayInfoCellTypeTypeScore,
    RadishOrderDetailPayInfoCellTypeTransportationExpenses
} RadishOrderDetailPayInfoCellType;

@interface RadishOrderDetailPayInfoCell : RadishOrderDetailBaseCell
@property (nonatomic, assign) RadishOrderDetailPayInfoCellType type;
@end
