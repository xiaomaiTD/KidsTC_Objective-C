//
//  NearbyModel.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NearbyItem.h"

@interface NearbyModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) NSArray<NearbyItem *> *data;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSString *page;
@end
