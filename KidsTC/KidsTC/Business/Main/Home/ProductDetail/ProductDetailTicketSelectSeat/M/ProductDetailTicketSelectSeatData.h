//
//  ProductDetailTicketSelectSeatData.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/18.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductDetailTicketSelectSeatTime.h"

@interface ProductDetailTicketSelectSeatData : NSObject
@property (nonatomic, strong) NSString *seatSmallImg;
@property (nonatomic, strong) NSString *seatImg;
@property (nonatomic, assign) BOOL isSupportSelectMultiSeat;
@property (nonatomic, strong) NSArray<ProductDetailTicketSelectSeatTime *> *seatTimes;
@end
