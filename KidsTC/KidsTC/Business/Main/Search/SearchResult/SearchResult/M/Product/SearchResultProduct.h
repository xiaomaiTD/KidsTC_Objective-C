//
//  SearchResultProduct.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"

@interface SearchResultProduct : NSObject
@property (nonatomic, strong) NSString *serveId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) SearchResultProductType productType;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, assign) ProductDetailType productSearchType;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, assign) SearchResultProductStatus status;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *num;
@property (nonatomic, strong) NSString *imgurl;
@property (nonatomic, strong) NSArray *fullCut;
@property (nonatomic, assign) BOOL isHaveCoupon;
@property (nonatomic, assign) BOOL isGqt;
@property (nonatomic, assign) BOOL isSst;
@property (nonatomic, strong) NSString *bigImgurl;
@property (nonatomic, assign) CGFloat bigImgRatio;
@property (nonatomic, strong) NSString *restDays;
@property (nonatomic, strong) NSString *storeNo;
@property (nonatomic, strong) NSString *mapAddress;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *endTimeDesc;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, strong) NSString *storeLogo;
@property (nonatomic, strong) NSString *joinText;
@property (nonatomic, assign) BOOL isFreeShipping;
@property (nonatomic, strong) NSString *freeShippingRange;
@property (nonatomic, strong) NSString *commentNum;
@property (nonatomic, strong) NSString *goodCommentPercent;

//selfDefine
@property (nonatomic, strong) SegueModel *segueModel;
@end
