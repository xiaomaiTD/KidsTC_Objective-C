//
//  NearbyData.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NearbyPlaceInfo.h"
#import "NearbyItem.h"
@interface NearbyData : NSObject
@property (nonatomic, strong) NearbyPlaceInfo *placeInfo;
@property (nonatomic, strong) NSArray<NearbyItem *> *data;
@property (nonatomic, assign) NSInteger count;
//selfDefine
/*
 人气 =1，
 价格正序=4，
 价格倒序=5，
 促销=2
 */
@property (nonatomic, strong) NSString *stValue;//排序规则
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic,assign) BOOL isLoadRecommend;
@end
