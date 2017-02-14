//
//  ScoreRecordModel.h
//  KidsTC
//
//  Created by 童成mac-dev1 on 2017/2/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScoreRecordItem.h"
@interface ScoreRecordModel : NSObject
@property (nonatomic,assign) NSInteger errNo;
@property (nonatomic,strong) NSArray<ScoreRecordItem *> *data;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,strong) NSString *page;
@end
