//
//  AccountCenterConfig.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/8.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import "AccountCenterBanner.h"

#import "AccountCenterHotProduct.h"
#import "AccountCenterActivity.h"
#import "AccountCenterBackgroundImg.h"
#import "AccountCenterTCECordLink.h"
#import "AccountCenterResidualLink.h"

/*
 activityExhibitionHall	Array
 backgroundImg	Object
 tcECordLink	Object
 residualLink	Object
 */

@interface AccountCenterConfig : NSObject
@property (nonatomic, strong) NSArray<NSString *> *icons;
@property (nonatomic, strong) NSArray<AccountCenterBanner *> *banners;
@property (nonatomic, strong) AccountCenterHotProduct *hotProduct;
@property (nonatomic, strong) NSArray<AccountCenterActivity *> *activityExhibitionHall;
@property (nonatomic, strong) AccountCenterBackgroundImg *backgroundImg;
@property (nonatomic, strong) AccountCenterTCECordLink *tcECordLink;
@property (nonatomic, strong) AccountCenterResidualLink *residualLink;

//selfDefine
@property (nonatomic, assign) CGFloat bannerHeight;
@end
