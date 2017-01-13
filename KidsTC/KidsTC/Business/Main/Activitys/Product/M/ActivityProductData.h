//
//  ActivityProductData.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActivityProductBase.h"
#import "ActivityProductShare.h"
#import "ActivityProductFloorItem.h"
#import "CommonShareObject.h"

@interface ActivityProductData : NSObject
@property (nonatomic, strong) ActivityProductBase *eventBaseInfo;
@property (nonatomic, strong) ActivityProductShare *shareInfo;
@property (nonatomic, strong) NSArray<ActivityProductFloorItem *> *floorItems;
//selfDefine
@property (nonatomic, strong) ActivityProductContent *sliderContent;
@property (nonatomic, strong) NSArray<ActivityProductFloorItem *> *showFloorItems;
@property (nonatomic, strong) ActivityProductContent *toolBarContent;
@property (nonatomic, strong) CommonShareObject *shareObj;
@end
