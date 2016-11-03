//
//  ComposeViewController.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/25.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ViewController.h"
#import "ComposeModel.h"

@interface ComposeViewController : ViewController
@property (nonatomic, strong) ComposeModel *model;
@property (nonatomic, copy) void(^resultBlock)();
@end
