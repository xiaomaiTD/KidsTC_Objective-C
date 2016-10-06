//
//  FailureViewManager.h
//  KidsTC
//
//  Created by zhanping on 8/30/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Single.h"

typedef enum : NSUInteger {
    FailureViewTypeWebView=1,
    FailureViewTypeOther
} FailureViewType;

typedef enum : NSUInteger {
    FailureViewManagerActionTypeWebView=1,
    FailureViewManagerActionTypeOther
} FailureViewManagerActionType;

@interface FailureViewManager : NSObject
singleH(FailureViewManager)

- (void)showType:(FailureViewType)type
          inView:(UIView *)view
     actionBlock:(void (^)(FailureViewManagerActionType type, id obj))actionBlock;

@end
