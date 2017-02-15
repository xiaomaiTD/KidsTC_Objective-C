//
//  NearbyPlaceInfoData.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/15.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NearbyPlaceInfoData : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, assign) NurseryType placeType;
@end
