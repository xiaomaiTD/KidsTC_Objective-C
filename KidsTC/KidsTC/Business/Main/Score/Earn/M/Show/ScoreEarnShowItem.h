//
//  ScoreEarnShowItem.h
//  KidsTC
//
//  Created by 童成mac-dev1 on 2017/2/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScoreEarnShowItem : NSObject
@property (nonatomic,strong) NSString *cellId;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,assign) NSUInteger index;
+ (instancetype)itemWithCellId:(NSString *)cellId index:(NSUInteger)index;
@end
