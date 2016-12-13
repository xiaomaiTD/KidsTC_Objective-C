//
//  ProductOrderNormalDetailRefund.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductOrderNormalDetailRefund : NSObject
@property (nonatomic, strong) NSString *refund_apply_time;
@property (nonatomic, strong) NSArray<NSString *> *consume_codes;
@property (nonatomic, strong) NSString *refund_status;
@property (nonatomic, strong) NSString *refund_status_desc;
@property (nonatomic, strong) NSString *refund_notice;
@property (nonatomic, strong) NSString *refund_money;
@property (nonatomic, strong) NSString *refund_score;
//selfDefine
@property (nonatomic, strong) NSAttributedString *refundDescStr;
@end
