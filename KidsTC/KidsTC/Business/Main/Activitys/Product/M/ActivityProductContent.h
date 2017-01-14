//
//  ActivityProductContent.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ActivityProductTabItem.h"
#import "ActivityProductCoupon.h"
#import "ActivityProductItem.h"
#import "SegueModel.h"

@interface ActivityProductContent : NSObject

@property (nonatomic, strong) NSString *tabBgc;
@property (nonatomic, strong) NSString *tabFontCor;
@property (nonatomic, strong) NSString *tabSelBgc;
@property (nonatomic, strong) NSString *tabSelFontCor;
@property (nonatomic, strong) NSString *tabSelIndexCor;
@property (nonatomic, strong) NSArray<ActivityProductTabItem *> *tabItems;

@property (nonatomic, assign) SegueDestination linkType;
@property (nonatomic, strong) NSDictionary *params;
@property (nonatomic, strong) NSString *imageUrl;

@property (nonatomic, strong) NSString *countDownText;
@property (nonatomic, assign) NSTimeInterval countDownValue;
@property (nonatomic, assign) BOOL isShowCountDown;
@property (nonatomic, strong) NSString *fontColor;

@property (nonatomic, strong) NSString *assemblySysNo;
@property (nonatomic, strong) NSString *couponTips;
@property (nonatomic, strong) NSString *afterReceivePageUrl;
@property (nonatomic, strong) NSArray<ActivityProductCoupon *> *couponModels;

@property (nonatomic, strong) NSString *floorTopPicUrl;
@property (nonatomic, assign) CGFloat floorTopPicRate;
@property (nonatomic, strong) NSString *floorBgc;
@property (nonatomic, strong) NSArray<ActivityProductItem *> *productItems;

//selfDefine
@property (nonatomic, strong) SegueModel *segueModel;
//countDown
@property (nonatomic, assign) BOOL countDownOver;
@property (nonatomic, strong) NSString *countDownValueString;
@property (nonatomic, strong) NSString *daysLeft;
@property (nonatomic, strong) NSString *hoursLeft;
@property (nonatomic, strong) NSString *minuteLeft;
@property (nonatomic, strong) NSString *secondLeft;
@end
