//
//  NormalProductDetailStandard.h
//  KidsTC
//
//  Created by 詹平 on 2017/2/4.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NormalProductDetailStandard : NSObject
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *productContent;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString *statusDesc;
@property (nonatomic, strong) NSString *storeNo;
@property (nonatomic, assign) NSUInteger buyMinNum;
@property (nonatomic, assign) ProductDetailType productRedirect;
@property (nonatomic, strong) NSString *standardName;
//selfDefine
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) BOOL isCanBuy;
@property (nonatomic, strong) NSString *priceStr;
@end
