//
//  ActivityProductItem.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/13.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"
@interface ActivityProductItem : NSObject
@property (nonatomic, strong) NSString *promotionText;
@property (nonatomic, strong) NSString *ageGroup;
@property (nonatomic, strong) NSString *productImage;
@property (nonatomic, strong) NSString *btnName;
@property (nonatomic, strong) NSString *priceDesc;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, strong) NSString *mapAddress;
@property (nonatomic, strong) NSString *useTimeStr;
@property (nonatomic, strong) NSString *joinDesc;
@property (nonatomic, strong) NSString *productNo;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, assign) ProductDetailType productRedirect;
//selfDefine
@property (nonatomic, strong) SegueModel *segueModel;
@end
