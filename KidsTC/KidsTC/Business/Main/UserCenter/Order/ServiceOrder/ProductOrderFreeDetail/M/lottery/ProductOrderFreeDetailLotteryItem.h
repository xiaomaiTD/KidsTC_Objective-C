//
//  ProductOrderFreeDetailLotteryItem.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/10.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProductOrderFreeDetailLotteryItem : NSObject
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userPhone;
@property (nonatomic, strong) NSString *rowCreateTimeStr;
//selfDefin
@property (nonatomic, assign) NSInteger index;
@end
