//
//  HomeActivityManager.h
//  KidsTC
//
//  Created by zhanping on 8/9/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GHeader.h"
#import "HomeActivityModel.h"

extern NSString *const kHomeActivityUpdateNoti;

@interface HomeActivityManager : NSObject
singleH(HomeActivityManager)
@property (nonatomic, strong) HomeActivityDataItem *data;
- (void)synchronize;
- (void)checkAcitvityWithTarget:(UIViewController *)target resultBlock:(void(^)())resultBlock;
@end
