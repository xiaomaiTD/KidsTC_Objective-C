//
//  ProductDetailTicketSelectSeatTime.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/18.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ProductDetailTicketSelectSeatSeat.h"

@interface ProductDetailTicketSelectSeatTime : NSObject
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *dayOfWeek;
@property (nonatomic, strong) NSString *minuteTime;
@property (nonatomic, strong) NSArray<ProductDetailTicketSelectSeatSeat *> *seats;
//selfDefine
@property (nonatomic, assign) BOOL selected;
@end
