//
//  ProductOrderListCountDown.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/3.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductOrderListCountDown : NSObject
@property (nonatomic, assign) BOOL showCountDown;
@property (nonatomic, assign) NSTimeInterval countDownTime;
@property (nonatomic, strong) NSString *countDownDesc;
//selfDefine
@property (nonatomic, strong) NSString *countDownValueString;
@end
