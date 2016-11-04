//
//  FailureViewLoadData.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/4.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    FailureViewLoadDataActionTypeCheckNetWork,
    FailureViewLoadDataActionTypeRefresh,
} FailureViewLoadDataActionType;

@interface FailureViewLoadData : UIView
@property (nonatomic, copy) void (^actionBlock)(FailureViewLoadData *failureViewLoadData, FailureViewLoadDataActionType actionType);
@end
