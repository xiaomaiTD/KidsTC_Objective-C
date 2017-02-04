//
//  WholesalePickDateTime.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/18.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface WholesalePickDateTime : NSObject
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *skuId;
@property (nonatomic, assign) BOOL canBuy;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, assign) BOOL select;
//selfDefine
@property (nonatomic, strong) NSAttributedString *attTimeStr;
@end
