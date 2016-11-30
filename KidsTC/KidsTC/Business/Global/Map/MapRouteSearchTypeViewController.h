//
//  MapRouteSearchTypeViewController.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/30.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "ViewController.h"
#import "KTCMapService.h"

@interface MapRouteSearchTypeViewController : ViewController
@property (nonatomic, assign) MapRouteSearchType type;
@property (nonatomic, copy) void ((^actionBlock)(MapRouteSearchType type));
@end
