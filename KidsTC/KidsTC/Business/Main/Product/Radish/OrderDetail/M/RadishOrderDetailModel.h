//
//  RadishOrderDetailModel.h
//  KidsTC
//
//  Created by 詹平 on 2016/12/12.
//  Copyright © 2016年 zhanping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RadishOrderDetailData.h"

@interface RadishOrderDetailModel : NSObject
@property (nonatomic, assign) NSInteger errNo;
@property (nonatomic, strong) RadishOrderDetailData *data;
@end
