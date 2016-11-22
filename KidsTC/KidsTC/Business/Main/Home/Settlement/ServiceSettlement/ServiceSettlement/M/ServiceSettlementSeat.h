//
//  ServiceSettlementSeat.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/21.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceSettlementSeat : NSObject
@property (nonatomic, strong) NSString *seat;
@property (nonatomic, assign) NSUInteger num;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *skuId;
@end
