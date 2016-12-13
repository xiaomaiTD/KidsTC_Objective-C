//
//  ProductOrderNormalDetailCountDown.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/13.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductOrderNormalDetailCountDown : NSObject
@property (nonatomic, assign) BOOL showCountDown;
@property (nonatomic, assign) NSTimeInterval countDownTime;
@property (nonatomic, strong) NSString *countDownDesc;
//selfDefine
@property (nonatomic, assign) BOOL countDownOver;
@property (nonatomic, strong) NSString *countDownValueString;
@end
