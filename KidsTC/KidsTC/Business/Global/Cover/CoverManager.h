//
//  CoverManager.h
//  KidsTC
//
//  Created by zhanping on 2016/9/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Single.h"

@interface CoverManager : NSObject
singleH(CoverManager)
- (void)showWelcome:(void(^)())resultBlock;
- (void)showPoster:(void(^)())resultBlock;
@end
