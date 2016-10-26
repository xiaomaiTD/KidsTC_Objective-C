//
//  ProductDetailStandard.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/26.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductDetailStandard : NSObject
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *productContent;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString *statusDesc;
//selfDefine
@property (nonatomic, assign) BOOL isCanBuy;
@property (nonatomic, strong) NSString *priceStr;
@end
