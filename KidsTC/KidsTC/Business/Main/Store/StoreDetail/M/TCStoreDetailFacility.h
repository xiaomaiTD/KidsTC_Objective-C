//
//  TCStoreDetailFacility.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/8.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TCStoreDetailFacilityItem.h"

@interface TCStoreDetailFacility : NSObject
@property (nonatomic, assign) NSUInteger type;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSArray<TCStoreDetailFacilityItem *> *items;
@end
