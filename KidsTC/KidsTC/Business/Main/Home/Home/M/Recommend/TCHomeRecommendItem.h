//
//  TCHomeRecommendItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/14.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCHomeFloor.h"
#import "TCHomeRecommendPromotion.h"

typedef enum : NSUInteger {
    TCHomeRecommendProductTypeNew=1,//今日新品
    TCHomeRecommendProductTypeHot=2,//热销活动
    TCHomeRecommendProductTypePopularity=3,//人气活动
    TCHomeRecommendProductTypePreference=5,//今日特惠
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
@property (nonatomic, strong) TCHomeRecommendPromotion *promotionIcon;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, strong) NSString *storeDistance;
@property (nonatomic, assign) NSInteger saleNum;
@property (nonatomic, assign) BOOL isPrivilege;
@property (nonatomic, strong) NSString *processDesc;
//selfDefine
@property (nonatomic, strong) SegueModel *segueModel;
- (TCHomeFloor *)conventToFloor;
@end
