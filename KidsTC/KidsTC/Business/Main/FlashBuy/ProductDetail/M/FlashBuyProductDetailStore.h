//
//  FlashBuyProductDetailStore.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/22.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SegueModel.h"
@interface FlashBuyProductDetailStore : NSObject
@property (nonatomic, strong) NSString *storeId;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, assign) NSInteger level;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, assign) NSInteger hotCount;
@property (nonatomic, assign) NSInteger attentNum;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *mapAddress;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *officeHoursDesc;
//selfDefine
@property (nonatomic, assign) BOOL select;
@property (nonatomic, strong) SegueModel *segueModel;
@end
