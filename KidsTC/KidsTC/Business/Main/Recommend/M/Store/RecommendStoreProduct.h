//
//  RecommendStoreProduct.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/22.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"

@interface RecommendStoreProduct : NSObject
@property (nonatomic, assign) ProductDetailType productType;
@property (nonatomic, strong) NSString *priceStr;
@property (nonatomic, strong) NSString *productSysNo;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, strong) NSString *picUrl;
@property (nonatomic, assign) CGFloat picRatio;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *distanceDesc;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *useValidTimeDesc;
//selfDefine
@property (nonatomic, strong) SegueModel *segueModel;
@end
