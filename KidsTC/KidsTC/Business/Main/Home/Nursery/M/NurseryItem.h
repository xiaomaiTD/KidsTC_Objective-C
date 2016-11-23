//
//  NurseryItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/23.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface NurseryItem : NSObject
@property (nonatomic, strong) NSString *placeNo;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray<NSString *> *pictures;
@property (nonatomic, strong) NSString *distanceDesc;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *drivingTime;
@property (nonatomic, strong) NSString *drivingTimeDesc;
@property (nonatomic, strong) NSString *ridingTime;
@property (nonatomic, strong) NSString *ridingTimeDesc;
@property (nonatomic, strong) NSString *walkingTime;
@property (nonatomic, strong) NSString *walkingTimeDesc;
@property (nonatomic, assign) NSUInteger storesTotal;
@property (nonatomic, assign) NSUInteger busStopsTotal;
@property (nonatomic, strong) NSString *subwayStationDesc;
@property (nonatomic, strong) NSString *tradingAreaName;
@property (nonatomic, strong) NSString *officeTimeDesc;
@property (nonatomic, strong) NSString *facilitiesDesc;
@property (nonatomic, strong) NSString *mapAddress;
@property (nonatomic, strong) NSString *address;
//selfDefine
@property (nonatomic, strong) NSString *routeStr;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate2D;
@end
