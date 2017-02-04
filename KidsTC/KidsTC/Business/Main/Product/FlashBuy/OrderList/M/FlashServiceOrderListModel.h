//
//  FlashServiceOrderListModel.h
//  KidsTC
//
//  Created by zhanping on 8/18/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlashServiceOrderDetailModel.h"

@interface FlashServiceOrderListItem : NSObject
@property (nonatomic, strong) NSString       *orderId;
@property (nonatomic, strong) NSString       *fsSysNo;
@property (nonatomic, assign) FlashBuyProductDetailStatus status;
@property (nonatomic, strong) NSString       *statusDesc;
@property (nonatomic, assign) BOOL           isLink;
@property (nonatomic, assign) BOOL           isShowCountDown;
@property (nonatomic, assign) NSTimeInterval countDownValue;
@property (nonatomic, strong) NSString       *countDownStr;
@property (nonatomic, assign) CGFloat        storePrice;
@property (nonatomic, assign) FlashServiceOrderDetailOrderStatus orderStatus;
@property (nonatomic, strong) NSString       *orderStatusDesc;
@property (nonatomic, strong) NSString       *productNo;
@property (nonatomic, strong) NSString       *productName;
@property (nonatomic, strong) NSString       *productImg;
@property (nonatomic, assign) NSInteger      productType;
@property (nonatomic, strong) NSString       *promotionText;
@property (nonatomic, assign) NSInteger      saleStock;
@property (nonatomic, assign) NSUInteger     prepaidNum;
@property (nonatomic, strong) NSString       *joinTime;
@property (nonatomic, strong) NSString       *buyTime;
@property (nonatomic, strong) NSString       *buyTimeEnd;
@property (nonatomic, strong) NSArray<FlashServiceOrderDetailPriceConfig *> *priceConfigs;
/**selfDefine*/
@property (nonatomic, assign) NSTimeInterval countDownValueOriginal;
@property (nonatomic, strong) FlashServiceOrderDetailPriceConfig *currentPriceConfig;
@property (nonatomic, strong) NSString *countDownValueString;
@end

@interface FlashServiceOrderListModel : NSObject
@property (nonatomic, assign) NSInteger  errNo;
@property (nonatomic, strong) NSArray<FlashServiceOrderListItem *> *data;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, strong) NSString   *page;
@end
