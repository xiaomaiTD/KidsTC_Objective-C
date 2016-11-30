//
//  MyTracksItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/30.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"

typedef enum : NSUInteger {
    MyTracksPriceStatusStill = 1,//没变
    MyTracksPriceStatusUp,//上涨
    MyTracksPriceStatusDown,//下降
} MyTracksPriceStatus;

@interface MyTracksItem : NSObject
@property (nonatomic, strong) NSString *storeNo;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, strong) NSString *storeAddress;
@property (nonatomic, strong) NSString *storeMapAddress;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *distanceDesc;
@property (nonatomic, strong) NSString *statusDesc;
@property (nonatomic, strong) NSString *browserDateTimeDesc;
@property (nonatomic, strong) NSString *recordSysNo;
@property (nonatomic, strong) NSString *productSysNo;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *picUrl;
@property (nonatomic, assign) CGFloat picRatio;
@property (nonatomic, strong) NSString *oldPrice;
@property (nonatomic, strong) NSString *gapPrice;
@property (nonatomic, assign) MyTracksPriceStatus priceStatus;
@property (nonatomic, strong) NSString *nowPrice;
@property (nonatomic, strong) NSString *isUnder;
@property (nonatomic, strong) NSString *promotionText;
@property (nonatomic, strong) NSString *promotionLikes;
@property (nonatomic, strong) NSString *validTimeDesc;
@property (nonatomic, assign) ProductDetailType productType;
//selfDefine
@property (nonatomic, strong) SegueModel *segueModel;
@end
