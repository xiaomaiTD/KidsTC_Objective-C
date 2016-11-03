//
//  ComposeManager.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/25.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Single.h"
#import "ComposeModel.h"

@interface ComposeManager : NSObject
singleH(ComposeManager)
@property (nonatomic, strong) ComposeModel *model;
- (void)synchronize;
- (void)showCompose:(void(^)())resultBlock;
@end
