//
//  RadishRadishProductDetailModel.h
//  KidsTC
//
//  Created by 詹平 on 2017/1/6.
//  Copyright © 2017年 zhanping. All rights reserved.
//

#import "RadishProductDetailData.h"

@interface RadishProductDetailModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) RadishProductDetailData *data;
@end
