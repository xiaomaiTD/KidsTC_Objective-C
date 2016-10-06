//
//  SettlementPickStoreViewController.h
//  KidsTC
//
//  Created by zhanping on 8/12/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import "ViewController.h"
#import "ServiceSettlementModel.h"
@interface SettlementPickStoreViewController : ViewController
@property (nonatomic, strong) NSString *serveId;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, strong) NSString *storeId;
@property (nonatomic, copy) void (^pickStoreBlock)(SettlementPickStoreDataItem *store);
@end
