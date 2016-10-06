//
//  ATCountDown.h
//  ICSON
//
//  Created by 钱烨 on 3/30/15.
//  Copyright (c) 2015 肖晓春. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATCountDown : NSObject

typedef struct {
    NSUInteger hour;
    NSUInteger min;
    NSUInteger sec;
}TimeStructHMS;

@property (nonatomic, assign, readonly) NSTimeInterval leftTime;

- (instancetype)initWithLeftTimeInterval:(NSTimeInterval)timeLeft;

- (void)startCountDownWithCurrentTimeLeft:(void(^)(NSTimeInterval currentTimeLeft))currentBlock;

- (void)startCountDownWithCurrentTimeLeft:(void(^)(NSTimeInterval currentTimeLeft))currentBlock completion:(void(^)())completion;

- (void)stopCountDown;

+ (TimeStructHMS)countDownTimeStructHMSWithLeftTime2:(NSTimeInterval)leftTime;

@end
