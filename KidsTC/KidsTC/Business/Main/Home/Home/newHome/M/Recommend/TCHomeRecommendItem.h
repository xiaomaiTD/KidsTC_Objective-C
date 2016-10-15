//
//  TCHomeRecommendItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCHomeFloor.h"

typedef enum : NSUInteger {
    TCHomeRecommendProductTypeNew=1,//今日新品
    TCHomeRecommendProductTypeHot,//热销活动
    TCHomeRecommendProductTypePopularity,//人气活动
} TCHomeRecommendProductType;

@interface TCHomeRecommendItem : NSObject
@property (nonatomic, strong) NSString *serveId;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, assign) TCHomeRecommendProductType reProductType;
@property (nonatomic, strong) NSString *serveName;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, assign) CGFloat picRate;
@property (nonatomic, strong) NSString *promotionText;
//selfDefine
@property (nonatomic, strong) SegueModel *segueModel;
- (TCHomeFloor *)conventToFloor;
@end
