//
//  NearbyRecommendModel.h
//  KidsTC
//
//  Created by 童成mac-dev1 on 2017/2/15.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NearbyItem.h"
@interface NearbyRecommendModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) NSArray<NearbyItem *> *data;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSString *page;
@end
