//
//  FlashBuyProductDetailModel.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/22.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FlashBuyProductDetailData.h"
@interface FlashBuyProductDetailModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) FlashBuyProductDetailData *data;
@end
