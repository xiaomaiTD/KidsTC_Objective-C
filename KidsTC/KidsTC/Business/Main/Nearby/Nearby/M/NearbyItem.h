//
//  NearbyItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/11.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"

@interface NearbyItem : NSObject
@property (nonatomic, strong) NSString *endTimeDesc;
@property (nonatomic, assign) BOOL isInterest;
@property (nonatomic, strong) NSString *categoryName;
@property (nonatomic, strong) NSString *districtName;
@property (nonatomic, strong) NSString *serveId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) SearchResultProductType productType;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, assign) ProductDetailType productSearchType;
@property (nonatomic, strong) NSString *level;
@property (nonatomic, assign) SearchResultProductStatus status;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *joinText;
@property (nonatomic, strong) NSString *num;
@property (nonatomic, strong) NSString *imgurl;
@property (nonatomic, strong) NSString *fullCut;
@property (nonatomic, strong) NSString *isHaveCoupon;
@property (nonatomic, strong) NSString *isGqt;
@property (nonatomic, strong) NSString *isSst;
@property (nonatomic, strong) NSString *isBft;
@property (nonatomic, strong) NSString *bigImgurl;
@property (nonatomic, assign) CGFloat bigImgRatio;
@property (nonatomic, strong) NSString *restDays;
@property (nonatomic, strong) NSString *storeNo;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, strong) NSString *storeLogo;
@property (nonatomic, strong) NSString *mapAddress;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *districtId;
@property (nonatomic, strong) NSString *category;
//selfDefine
@property (nonatomic, strong) SegueModel *segueModel;
@end
