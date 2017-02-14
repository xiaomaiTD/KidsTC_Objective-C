//
//  ScoreConsumeTopicItem.h
//  KidsTC
//
//  Created by 童成mac-dev1 on 2017/2/14.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScoreProductItem.h"

typedef enum : NSUInteger {
    ScoreConsumeTopicItemTypeSmall = 1,//小图
    ScoreConsumeTopicItemTypeLarge = 2,//大图
} ScoreConsumeTopicItemType;
@interface ScoreConsumeTopicItem : NSObject
@property (nonatomic,strong) NSArray<ScoreProductItem *> *products;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,assign) ScoreConsumeTopicItemType picType;
@end
