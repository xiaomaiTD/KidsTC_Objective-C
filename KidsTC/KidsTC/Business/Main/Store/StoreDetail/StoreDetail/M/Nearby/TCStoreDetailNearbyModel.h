//
//  TCStoreDetailNearbyModel.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/9.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCStoreDetailNearbyData.h"
@interface TCStoreDetailNearbyModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) TCStoreDetailNearbyData *data;
@end
