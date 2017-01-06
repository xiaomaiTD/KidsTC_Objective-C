//
//  RadishProductOrderListCountDown.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/6.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RadishProductOrderListCountDown : NSObject
@property (nonatomic, assign) BOOL showCountDown;
@property (nonatomic, assign) NSTimeInterval countDownTime;
@property (nonatomic, strong) NSString *countDownDesc;
//selfDefine
@property (nonatomic, assign) BOOL countDownOver;
@property (nonatomic, strong) NSString *countDownValueString;
@end
