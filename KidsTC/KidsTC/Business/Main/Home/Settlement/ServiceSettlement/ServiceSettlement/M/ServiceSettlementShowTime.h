//
//  ServiceSettlementShowTime.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/21.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceSettlementShowTime : NSObject
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *dayOfWeek;
@property (nonatomic, strong) NSString *minuteTime;
//selfDefine
@property (nonatomic, strong) NSString *showStr;
@end
