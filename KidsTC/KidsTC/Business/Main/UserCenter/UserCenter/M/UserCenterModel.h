//
//  UserCenterModel.h
//  KidsTC
//
//  Created by zhanping on 7/26/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"

@interface UserCenterUserCount : NSObject
@property (nonatomic, assign) NSUInteger appointment_wait_arrive;
@property (nonatomic, assign) NSUInteger order_wait_pay;
@property (nonatomic, assign) NSUInteger order_wait_use;
@property (nonatomic, assign) NSUInteger order_wait_evaluate;
@property (nonatomic, assign) NSUInteger unReadMsgCount;
@property (nonatomic, assign) NSUInteger score_num;
@property (nonatomic, assign) NSUInteger userRadishNum;
@property (nonatomic, assign) NSUInteger userGrowthValue;
@property (nonatomic, assign) BOOL userHasNewCoupon;
@end

@interface UserCenterInvite : NSObject
@property (nonatomic, strong) NSString *linkUrl;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *btnDesc;
@property (nonatomic, strong) NSString *desc;
@end

@interface UserCenterRadish : NSObject
@property (nonatomic, strong) NSString *linkUrl;
@end

@interface UserCenterExHistory : NSObject
@property (nonatomic, strong) NSString *linkUrl;
@end

@interface UserCenterFsList : NSObject
@property (nonatomic, strong) NSString *linkUrl;
@end

@interface UserCenterUserInfo : NSObject
@property (nonatomic, strong) NSString *usrName;
@property (nonatomic, strong) NSString *headUrl;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, strong) NSString *levelName;
@property (nonatomic, strong) NSString *mobile;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, assign) NSUInteger age;

@property (nonatomic, strong) NSAttributedString *infoStr;
@end

@interface UserCenterBannersItem : NSObject
@property (nonatomic, assign) CGFloat Ratio;
@property (nonatomic, strong) NSString *ImageUrl;
@property (nonatomic, assign) SegueDestination linkType;
@property (nonatomic, strong) NSDictionary *params;

@property (nonatomic, strong) SegueModel *segueModel;
@end

@interface UserCenterProductLsItem : NSObject
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, assign) NSInteger saleNum;
@property (nonatomic, strong) NSString *productImg;
@property (nonatomic, strong) NSString *narrowImg;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, strong) NSString *fsSysNo;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, strong) NSString *linkUrl;
@end

typedef enum : NSUInteger {
    UserCenterHotProductTypeUnknow,//未知，不作跳转
    UserCenterHotProductTypeNormolProduct,//普通商品 跳商品详情
    UserCenterHotProductTypeCarrot,//萝卜商品 跳H5
    UserCenterHotProductTypeFlashBy//闪购商品 跳原生闪购
} UserCenterHotProductType;

@interface UserCenterHotProduct : NSObject
@property (nonatomic, strong) NSString *tit;
@property (nonatomic, assign) UserCenterHotProductType productType;
@property (nonatomic, strong) NSArray<UserCenterProductLsItem *> *productLs;
@end

@interface UserCenterConfig : NSObject
@property (nonatomic, strong) NSArray<NSString *> *icons;
@property (nonatomic, strong) NSArray<UserCenterBannersItem *> *banners;
@property (nonatomic, strong) UserCenterHotProduct *hotProduct;

@property (nonatomic, assign) CGFloat bannersHeight;
@property (nonatomic, assign) CGFloat hotProductHeight;
@end

@interface UserCenterData : NSObject
@property (nonatomic, strong) UserCenterUserCount *userCount;
@property (nonatomic, strong) UserCenterInvite *invite;
@property (nonatomic, strong) UserCenterRadish *radish;
@property (nonatomic, strong) UserCenterExHistory *exHistory;
@property (nonatomic, strong) UserCenterFsList *fsList;
@property (nonatomic, strong) NSString *kfMobile;
@property (nonatomic, strong) UserCenterUserInfo *userInfo;
@property (nonatomic, strong) UserCenterConfig *config;
@end

@interface UserCenterModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) UserCenterData *data;
@end
