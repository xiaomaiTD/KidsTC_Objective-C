//
//  AppVersionViewController.h
//  KidsTC
//
//  Created by zhanping on 2016/9/21.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ViewController.h"
#import "AppVersionModel.h"

@interface AppVersionViewController : ViewController
@property (nonatomic, strong) AppVersionData *data;
@property (nonatomic, copy) void (^updateBlock)();
@property (nonatomic, copy) void (^cancleBlock)();
@end
