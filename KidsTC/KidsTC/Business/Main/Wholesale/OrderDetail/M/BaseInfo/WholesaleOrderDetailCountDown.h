//
//  WholesaleOrderDetailCountDown.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WholesaleOrderDetailCountDown : NSObject
@property (nonatomic, assign) BOOL showCountDown;
@property (nonatomic, assign) NSTimeInterval countDownTime;
@property (nonatomic, strong) NSString *countDownDesc;
//selfDefine
@property (nonatomic, assign) BOOL countDownOver;
@property (nonatomic, strong) NSString *countDownValueString;
@property (nonatomic, strong) NSString *daysLeft;
@property (nonatomic, strong) NSString *hoursLeft;
@property (nonatomic, strong) NSString *minuteLeft;
@property (nonatomic, strong) NSString *secondLeft;
@end
