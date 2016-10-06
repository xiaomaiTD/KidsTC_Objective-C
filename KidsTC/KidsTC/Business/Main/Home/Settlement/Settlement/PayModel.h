//
//  PayModel.h
//  KidsTC
//
//  Created by zhanping on 8/14/16.
//  Copyright © 2016 詹平. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    PayTypeNone,
    PayTypeAli,
    PayTypeWeChat,
} PayType;

@interface PayInfo : NSObject
@property (nonatomic, assign) PayType payType;
@property (nonatomic, strong) NSString *payUrl;
@property (nonatomic, assign) NSTimeInterval timeStamp;
@property (nonatomic, strong) NSString *packageValue;
@property (nonatomic, strong) NSString *partnerId;
@property (nonatomic, strong) NSString *prepayId;
@property (nonatomic, strong) NSString *nonceStr;
@property (nonatomic, strong) NSString *sign;
@property (nonatomic, strong) NSString *message;
@end

@interface PayData : NSObject
@property (nonatomic, strong) NSString *orderNo;
@property (nonatomic, assign) PayType  payType;
@property (nonatomic, strong) PayInfo  *payInfo;
@end

@interface PayModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) PayData *data;
@end
