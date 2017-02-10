//
//  TCStoreDetailNearbyData.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/9.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCStoreDetailNearbyStore.h"
#import "TCStoreDetailNearbyProduct.h"

@interface TCStoreDetailNearbyData : NSObject
@property (nonatomic, strong) NSArray<TCStoreDetailNearbyStore *> *nearStores;
@property (nonatomic, strong) NSArray<TCStoreDetailNearbyProduct *> *nearProducts;
@end
