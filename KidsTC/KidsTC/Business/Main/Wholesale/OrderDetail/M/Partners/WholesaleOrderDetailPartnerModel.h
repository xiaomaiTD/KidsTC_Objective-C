//
//  WholesaleOrderDetailPartnerModel.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/28.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WholesaleOrderDetailPartner.h"
#import "WholesaleProductDetailCount.h"

@interface WholesaleOrderDetailPartnerModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) NSArray<WholesaleOrderDetailPartner *> *data;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSString *page;
//selfDefine
@property (nonatomic, strong) NSArray<WholesaleProductDetailCount *> *counts;
@end
