//
//  SettlementResultViewController.h
//  KidsTC
//
//  Created by zhanping on 8/14/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ViewController.h"

typedef enum : NSUInteger {
    SettlementResultTypeService=1,
    SettlementResultTypeFlash,
} SettlementResultType;

@interface SettlementResultViewController : ViewController
@property (nonatomic, assign) BOOL paid;
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, assign) SettlementResultType type;
@end
