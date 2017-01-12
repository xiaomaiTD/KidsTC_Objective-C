//
//  SeckillDataData.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/11.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SeckillDataItem.h"
@interface SeckillDataData : NSObject
@property (nonatomic, assign) BOOL isShowCountDown;
@property (nonatomic, strong) NSString *countDownDesc;
@property (nonatomic, assign) NSTimeInterval countDown;
@property (nonatomic, strong) NSArray<SeckillDataItem *> *items;
//selfDefine
@property (nonatomic, assign) BOOL countDownOver;
@property (nonatomic, strong) NSString *countDownValueString;
@property (nonatomic, strong) NSString *daysLeft;
@property (nonatomic, strong) NSString *hoursLeft;
@property (nonatomic, strong) NSString *minuteLeft;
@property (nonatomic, strong) NSString *secondLeft;
@end
