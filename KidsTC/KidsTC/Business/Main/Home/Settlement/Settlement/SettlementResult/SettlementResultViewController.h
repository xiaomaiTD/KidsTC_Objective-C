//
//  SettlementResultViewController.h
//  KidsTC
//
//  Created by zhanping on 8/14/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ViewController.h"

@interface SettlementResultViewController : ViewController
@property (nonatomic, assign) BOOL paid;
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, assign) ProductDetailType productType;
@property (nonatomic, assign) SettlementResultType type;
@end
