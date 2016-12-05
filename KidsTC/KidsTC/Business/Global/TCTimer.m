//
//  TCTimer.m
//  KidsTC
//
//  Created by 詹平 on 2016/12/5.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "TCTimer.h"
#import "YYTimer.h"

@interface TCTimer ()
@property (nonatomic, strong) YYTimer *timer;
@end

@implementation TCTimer
singleM(TCTimer)

- (instancetype)init {
    self = [super init];
    if (self) {
        self.timer = [YYTimer timerWithTimeInterval:1 target:self selector:@selector(countDown) repeats:YES];
    }
    return self;
}

- (void)countDown{
    [NotificationCenter postNotificationName:kTCCountDownNoti object:nil];
}

@end
