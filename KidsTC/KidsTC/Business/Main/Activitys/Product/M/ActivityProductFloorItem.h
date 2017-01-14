//
//  ActivityProductFloorItem.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActivityProductContent.h"

typedef enum : NSUInteger {
    ActivityProductContentTypeBanner = 1,//banner
    ActivityProductContentTypeCoupon = 702,//优惠券
    ActivityProductContentTypeLarge = 508,//大图
    ActivityProductContentTypeSmall = 509,//小图
    ActivityProductContentTypeMedium = 510,//中图
    ActivityProductContentTypeCountDown = 801,//倒计时
    ActivityProductContentTypeToolBar = 1001,//底部tab
    ActivityProductContentTypeSlider = 1003,//顶部tab
} ActivityProductContentType;//楼层类型

@interface ActivityProductFloorItem : NSObject
@property (nonatomic, strong) NSString *floorSysNo;
@property (nonatomic, assign) ActivityProductContentType contentType;
@property (nonatomic, assign) CGFloat marginTop;
@property (nonatomic, assign) CGFloat ratio;
@property (nonatomic, strong) NSArray<ActivityProductContent *> *contents;
//selfDefine
@property (nonatomic, assign) BOOL hasSliderTabItem;
@property (nonatomic, assign) NSUInteger sliderTabItemIndex;
@end
