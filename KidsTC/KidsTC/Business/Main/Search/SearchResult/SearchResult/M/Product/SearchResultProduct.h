//
//  SearchResultProduct.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/7.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"
/*
 serveId	Integer	100001
 name	String	钢琴独奏亲子音乐会《肖邦与夜曲》（红色区域下午）
 productType	Integer	0
 channelId	Integer	0
 productSearchType	Integer	2
 level	Integer	5
 status	Integer	1
 price	String	40~250
 num	Integer	0
 imgurl	String	http://img.kidstc.com/v1/img/T1LRETBKxT1RCvBVdK.jpg
 fullCut	Array
 isHaveCoupon	Boolean	true
 isGqt	Boolean	false
 isSst	Boolean	false
 isBft	Boolean	false
 bigImgurl	String	http://img.kidstc.com/v1/img/T1cRETByKv1RCvBVdK.jpg
 restDays	Integer	297
 storeNo	Integer	1
 mapAddress	String	121.456391000424,31.2431438681179
 address	String	江宁路631号
 distance	String	15m
 */
@interface SearchResultProduct : NSObject
@property (nonatomic, strong) NSString *serveId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) ProductDetailType productType;
@property (nonatomic, strong) NSString *channelId;
//@property (nonatomic, strong) NSString *productSearchType;
@property (nonatomic, assign) NSInteger level;
//@property (nonatomic, strong) NSString *status;
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

//selfDefine
@property (nonatomic, strong) SegueModel *segueModel;
@end
