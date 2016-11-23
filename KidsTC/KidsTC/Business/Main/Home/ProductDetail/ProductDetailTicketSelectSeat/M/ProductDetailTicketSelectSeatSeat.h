//
//  ProductDetailTicketSelectSeatSeat.h
//  KidsTC
//
//  Created by 詹平 on 2016/11/18.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductDetailTicketSelectSeatSeat : NSObject
@property (nonatomic, strong) NSString *sku;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *seat;
@property (nonatomic, assign) NSInteger maxBuyNum;
//selfDefine
@property (nonatomic, assign) NSInteger minBuyNum;
@property (nonatomic, assign) NSInteger count;;
@property (nonatomic, strong) NSAttributedString *attInfoStr;
@property (nonatomic, assign) BOOL selected;
@end