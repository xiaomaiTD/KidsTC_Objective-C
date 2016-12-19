//
//  NearbyPlaceInfo.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NearbyPlaceInfoData.h"
@interface NearbyPlaceInfo : NSObject
@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, strong) NearbyPlaceInfoData *leftData;
@property (nonatomic, strong) NearbyPlaceInfoData *rightData;
@end
