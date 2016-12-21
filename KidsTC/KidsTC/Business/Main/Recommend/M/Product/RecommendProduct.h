//
//  RecommendProduct.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/20.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"

@interface RecommendProduct : NSObject
@property (nonatomic, assign) ProductDetailType productType;
@property (nonatomic, strong) NSString *priceStr;
@property (nonatomic, strong) NSString *productSysNo;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, strong) NSString *picUrl;
@property (nonatomic, strong) NSString *picRatio;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *distanceDesc;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *useValidTimeDesc;
@property (nonatomic, strong) NSString *freeProductSaleNum;
@property (nonatomic, strong) NSString *freeProductTotalNum;

//selfDefine
@property (nonatomic, strong) SegueModel *segueModel;
@end
