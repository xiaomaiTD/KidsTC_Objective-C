//
//  ProductDetailRecommendItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/10/27.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface ProductDetailRecommendItem : NSObject
@property (nonatomic, strong) NSString *productNo;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *process;
@property (nonatomic, assign) ProductDetailType productRedirect;
//selfDefine
@property (nonatomic, strong) NSString *priceStr;
@property (nonatomic, strong) NSString *locationStr;
@end
