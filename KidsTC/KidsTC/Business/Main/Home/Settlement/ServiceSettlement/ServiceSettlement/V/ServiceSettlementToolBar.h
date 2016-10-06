//
//  ServiceSettlementToolBar.h
//  KidsTC
//
//  Created by zhanping on 8/12/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ServiceSettlementModel.h"

@interface ServiceSettlementToolBar : UIView
@property (nonatomic, weak) ServiceSettlementDataItem *item;
@property (nonatomic, copy) void (^commitBlock)();
@end
