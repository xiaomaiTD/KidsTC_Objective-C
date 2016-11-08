//
//  AccountCenterHotProductItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/8.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountCenterHotProductItem : NSObject
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, assign) NSInteger saleNum;
@property (nonatomic, strong) NSString *productImg;
@property (nonatomic, strong) NSString *narrowImg;
@property (nonatomic, strong) NSString *channelId;
@property (nonatomic, strong) NSString *fsSysNo;
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, strong) NSString *linkUrl;
@end
