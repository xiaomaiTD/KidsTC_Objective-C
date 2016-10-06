//
//  ServiceSettlementPayInfoCell.h
//  KidsTC
//
//  Created by zhanping on 8/20/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ServiceSettlementBaseCell.h"

typedef enum : NSUInteger {
    ServiceSettlementPayInfoCellTypePrice=1,
    ServiceSettlementPayInfoCellTypePromotion,
    ServiceSettlementPayInfoCellTypeScore,
    ServiceSettlementPayInfoCellTypeTransportationExpenses
} ServiceSettlementPayInfoCellType;

@interface ServiceSettlementPayInfoCell : ServiceSettlementBaseCell
@property (nonatomic, assign) ServiceSettlementPayInfoCellType type;
@end
