//
//  RadishUserData.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/12.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface RadishUserData : NSObject
@property (nonatomic, strong) NSString *radishGrade;
@property (nonatomic, assign) NSUInteger radishCount;
@property (nonatomic, assign) BOOL isCheckIn;
@property (nonatomic, assign) NSUInteger checkInDays;
@end
