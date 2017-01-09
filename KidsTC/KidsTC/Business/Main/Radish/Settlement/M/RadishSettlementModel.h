//
//  RadishSettlementModel.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/6.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RadishSettlementData.h"

@interface RadishSettlementModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) RadishSettlementData *data;
@end
