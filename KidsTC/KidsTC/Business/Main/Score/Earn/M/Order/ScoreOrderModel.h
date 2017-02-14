//
//  ScoreOrderModel.h
//  KidsTC
//
//  Created by 童成mac-dev1 on 2017/2/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScoreOrderItem.h"

@interface ScoreOrderModel : NSObject
@property (nonatomic,assign) NSInteger errNo;
@property (nonatomic,strong) NSArray<ScoreOrderItem *> *data;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,strong) NSString *page;
@end
