//
//  FlashBalanceSettlementPayInfoCell.h
//  KidsTC
//
//  Created by zhanping on 8/17/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "FlashBalanceSettlementBaseCell.h"

typedef enum : NSUInteger {
    FlashBalanceSettlementPayInfoCellTypePrice=1,
    FlashBalanceSettlementPayInfoCellTypeScore,
    FlashBalanceSettlementPayInfoCellTypeTransportationExpenses
} FlashBalanceSettlementPayInfoCellType;

@interface FlashBalanceSettlementPayInfoCell : FlashBalanceSettlementBaseCell
@property (nonatomic, assign) FlashBalanceSettlementPayInfoCellType type;
@end
