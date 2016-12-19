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
@property (nonatomic, assign) CGFloat price;
@property (nonatomic, assign) CGFloat orignalPrice;
@property (nonatomic, strong) NSString *seat;
@property (nonatomic, assign) NSInteger maxBuyNum;
@property (nonatomic, strong) NSString *chId;
@property (nonatomic, assign) PriceSort priceSort;
@property (nonatomic, strong) NSString *priceSortName;
@property (nonatomic, assign) NSInteger minBuyNum;
//selfDefine
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) BOOL selected;
@end
