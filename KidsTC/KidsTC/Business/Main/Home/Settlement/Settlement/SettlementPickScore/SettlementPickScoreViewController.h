//
//  SettlementPickScoreViewController.h
//  KidsTC
//
//  Created by zhanping on 8/11/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ViewController.h"

typedef enum : NSUInteger {
    ServiceSettlementPickScoreActionTypeCancle,
    ServiceSettlementPickScoreActionTypeSure,
} ServiceSettlementPickScoreActionType;

@interface SettlementPickScoreViewController : ViewController
@property (nonatomic, assign) NSUInteger scoreNum;
@property (nonatomic, copy) void (^resultBlock)(NSUInteger scoreNum);
@end
