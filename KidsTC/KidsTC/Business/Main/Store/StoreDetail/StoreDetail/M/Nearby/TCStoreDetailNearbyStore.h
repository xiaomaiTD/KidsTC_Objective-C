//
//  TCStoreDetailNearbyStore.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/9.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"
@interface TCStoreDetailNearbyStore : NSObject
@property (nonatomic, strong) NSString *storeId;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, strong) NSString *storeImg;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, strong) NSString *distanceStr;
@property (nonatomic, strong) NSString *averagePrice;
//selfDefine
@property (nonatomic, strong) SegueModel *segueModel;
@end
