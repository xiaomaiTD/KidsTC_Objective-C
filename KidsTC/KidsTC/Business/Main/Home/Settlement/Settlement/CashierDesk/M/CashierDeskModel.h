//
//  CashierDeskModel.h
//  KidsTC
//
//  Created by zhanping on 8/17/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PayModel.h"

@interface CashierDeskChangePayTypeData : NSObject
@property (nonatomic, assign) PayType payType;
@property (nonatomic, strong) PayInfo *payInfo;
@end

@interface CashierDeskChangePayTypeModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) CashierDeskChangePayTypeData *data;
@end

@interface CashierDeskPayChannel : NSObject
@property (nonatomic, assign) NSInteger ali;
@property (nonatomic, assign) NSInteger WeChat;
@end

@interface CashierDeskOrder : NSObject
@property (nonatomic, strong) NSString *payMoney;
@property (nonatomic, strong) NSString *orderNo;
@property (nonatomic, assign) PayType payType;
@property (nonatomic, strong) PayInfo *payInfo;
@end

@interface CashierDeskData : NSObject
@property (nonatomic, strong) CashierDeskPayChannel *payChannel;
@property (nonatomic, strong) CashierDeskOrder *order;
@end

@interface CashierDeskModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) CashierDeskData *data;
@end
