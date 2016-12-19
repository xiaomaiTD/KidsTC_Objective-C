//
//  AppBaseManager.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/16.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Single.h"
#import "AppBaseModel.h"

@interface AppBaseManager : NSObject
singleH(AppBaseManager)
@property (nonatomic, strong) AppBaseData *data;
- (void)synchronize;
@end
